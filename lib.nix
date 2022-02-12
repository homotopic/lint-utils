{ pkgs }:
rec {
  porcelainOrDieScript = cmd: advice: pkgs.writers.writeBashBin "lint" ''
    ${cmd}
    if [ -z "$(git status --porcelain)" ]; then
      echo "OK"
    else
      echo "${advice}"
      exit 1
    fi
    '';
  porcelainOrDie = name: attrs: cmd: advice: pkgs.runCommand name attrs ''
    PATH="$PATH:${pkgs.git}/bin"
    export GIT_AUTHOR_NAME="nobody"
    export EMAIL="no@body.com"
    git init
    git add .
    git commit -m "init"
    ${porcelainOrDieScript cmd advice}/bin/lint | tee $out
    '';
}
