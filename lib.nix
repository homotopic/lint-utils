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

  ormolu = lint-bin
    "find . -name '*.hs | xargs ${pkgs.ormolu}/bin/ormolu -i";

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
    hpack = lint-app hpack;
    nixpkgs-fmt = lint-app nixpkgs-fmt;
    ormolu = lint-app ormolu;
    stylish-haskell = lint-app stylish-haskell;
  };

  linters = {
    cabal-fmt = porcelainLinter "cabal-fmt" cabal-fmt;
    dhall-format = porcelainLinter "dhall-format" dhall-format;
    hlint = hlint;
    hpack = porcelainLinter "hpack" hpack;
    nixpkgs-fmt = porcelainLinter "nixpkgs-fmt" nixpkgs-fmt;
    ormolu = porcelainLinter "ormolu" ormolu;
    stylish-haskell = porcelainLinter "stylish-haskell" stylish-haskell;
  };

}
