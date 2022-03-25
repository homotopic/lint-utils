{ pkgs }:
rec {

  porcelainOrDieScript = cmd: advice: pkgs.writers.writeBashBin "lint" ''
    echo "Running ${cmd}"
    ${cmd}
    if [ -z "$(git status --porcelain)" ]; then
      echo "OK"
    else
      echo "${advice}"
      exit 1
    fi
  '';

  porcelainOrDie = src: name: cmd: advice: pkgs.stdenv.mkDerivation {
    name = name;
    src = src;
    meta = { description = "Linting check: ${name}"; };
    dontBuild = true;
    installPhase = ''
      PATH="$PATH:${pkgs.git}/bin"
      export GIT_AUTHOR_NAME="nobody"
      export EMAIL="no@body.com"
      git init
      git add .
      git commit -m "init"
      ${porcelainOrDieScript cmd advice}/bin/lint | tee $out
    '';
  };

  lint-app = app: {
    type = "app";
    program = "${app}/bin/lint";
  };

  lint-bin = cmd: pkgs.writers.writeBashBin "lint" cmd;

  cabal-fmt = lint-bin
    "find . -name '*.cabal' | xargs ${pkgs.haskellPackages.cabal-fmt}/bin/cabal-fmt -i";

  dhall-format = lint-bin
    "find . -name '*.dhall' | xargs -I{} ${pkgs.dhall}/bin/dhall format {} --unicode";

  nixpkgs-fmt = lint-bin
    "find . -name '*.nix' | xargs ${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";

  hpack = lint-bin
    "find . -name 'package.yaml' | xargs ${pkgs.hpack}/bin/hpack";

  fourmoluWithOpts = opts: lint-bin
    "find . -name '*.hs' | xargs ${pkgs.haskellPackages.formolu}/bin/fourmolu -m inplace ${opts}";

  ormoluWithOpts = opts: lint-bin
    "find . -name '*.hs' | xargs ${pkgs.ormolu}/bin/ormolu -i ${opts}";

  ormoluStandardGhc8107 = ormoluWithOpts "-o-XTypeApplications";

  fourmoluStandardGhc8107 = fourmoluWithOpts "-o-XTypeApplications";

  ormoluStandardGhc921 = ormoluWithOpts "-o-XTypeApplications -o-XQualifiedDo -o-XOverloadedRecordDot";

  fourmoluStandardGhc921 = fourmoluWithOpts "-o-XTypeApplications -o-XQualifiedDo -o-XOverloadedRecordDot";


  stylish-haskell = lint-bin
    "find . -name '*.hs' | xargs ${pkgs.stylish-haskell}/bin/stylish-haskell -i";

  lint-error = name: app:
    "Found errors with ${name}, try running ${app}/bin/lint";

  porcelainLinter = name: app: src:
    porcelainOrDie src name "${app}/bin/lint" (lint-error name app);

  hlint = src: pkgs.stdenv.mkDerivation {
    name = "hlint";
    src = src;
    meta = { description = "Run hlint"; };
    dontBuild = true;
    installPhase = ''
      ${pkgs.hlint}/bin/hlint | tee $out
    '';
  };

  apps = {
    cabal-fmt = lint-app cabal-fmt;
    dhall-format = lint-app dhall-format;
    fourmoluStandard8107 = lint-app fourmoluStandardGhc8107;
    fourmoluStandard921 = lint-app fourmoluStandardGhc921;
    hpack = lint-app hpack;
    nixpkgs-fmt = lint-app nixpkgs-fmt;
    ormoluStandardGhc8107 = lint-app ormoluStandardGhc8107;
    ormoluStandardGhc921 = lint-app ormoluStandardGhc921;
    stylish-haskell = lint-app stylish-haskell;
  };

  linters = {
    cabal-fmt = porcelainLinter "cabal-fmt" cabal-fmt;
    dhall-format = porcelainLinter "dhall-format" dhall-format;
    fourmolu = src: opts: porcelainLinter "fourmolu" (fourmoluWithOpts opts) src;
    fourmoluStandardGhc8107 = porcelainLinter "fourmolu-standard-ghc-8107" fourmoluStandardGhc8107;
    fourmoluStandardGhc921 = porcelainLinter "fourmolu-standard-ghc-921" fourmoluStandardGhc921;
    hlint = hlint;
    hpack = porcelainLinter "hpack" hpack;
    nixpkgs-fmt = porcelainLinter "nixpkgs-fmt" nixpkgs-fmt;
    ormolu = src: opts: porcelainLinter "ormolu" (ormoluWithOpts opts) src;
    ormoluStandardGhc8107 = porcelainLinter "ormolu-standard-ghc-8107" ormoluStandardGhc8107;
    ormoluStandardGhc921 = porcelainLinter "ormolu-standard-ghc-921" ormoluStandardGhc921;
    stylish-haskell = porcelainLinter "stylish-haskell" stylish-haskell;
  };

}
