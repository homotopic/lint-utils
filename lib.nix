{ pkgs }:
rec {

  porcelainOrDieScript = cmd: advice: pkgs.writers.writeBashBin "lint" ''
    ls
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

  hlint = src: pkgs.stdenv.mkDerivation {
    name = "hlint";
    src = src;
    meta = { description = "Run hlint"; };
    dontBuild = true;
    installPhase = ''
      ${pkgs.hlint}/bin/hlint | tee $out
    '';
  };

  nixpkgs-fmt = src: porcelainOrDie src "nixpkgs-fmt"
    "find . -name '*.nix' | xargs ${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"
    "Found errors with nixpkgs-fmt, try running 'find . -name \'*.nix\' | xargs nixpkgs-fmt'";

  ormolu = src: porcelainOrDie src "ormolu"
    "find . -name '*.hs | xargs ${pkgs.ormolu}/bin/ormolu"
    "Found errors with ormolu, try running 'find . -name \'*.hs\' | xargs ormolu -i";

  stylish-haskell = src: porcelainOrDie src "stylish-haskell"
    "find . -name '*.hs' | xargs ${pkgs.stylish-haskell}/bin/stylish-haskell -i"
    "Found errors with stylish-haskell, try running 'find . -name \'*.hs\' | xargs stylish-haskell -i";

}
