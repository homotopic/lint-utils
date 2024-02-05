{ git
, lib
, mkDerivation
, writeBashBin
}:
let sdn = lib.strings.sanitizeDerivationName; in
rec {

  writePorcelainOrDieBin = { name, src, command, advice }: writeBashBin (sdn name) ''
    set -e
    PATH="$PATH:${git}/bin"
    export GIT_AUTHOR_NAME="nobody"
    export EMAIL="no@body.com"
    git init
    git add .
    git commit -m "init"
    echo "Running ${name}"
    ${command}
    (if [ -z "$(git status --porcelain)" ]; then
      echo "OK"
    else
      echo "${advice}"
      exit 1
    fi)
  '';

  writePorcelainOrDieCheck = { name, src, command, advice }:
    let x = writePorcelainOrDieBin { inherit name src command advice; };
    in
    mkDerivation {
      inherit name src;
      meta = { description = "Linting check: ${name}"; };
      dontBuild = true;
      installPhase = "${x}/bin/${sdn name} | tee $out";
    };

  writeFindAndLintBin = { name, find, exec }:
    writeBashBin (sdn name) "find . -name '${find}' | xargs ${exec}";

  writePorcelainLinter = { name, src, find, exec }:
    let
      runAll = writeFindAndLintBin { inherit name find exec; };
      command = "${runAll}/bin/${sdn name}";
      advice = "Found errors with ${name}, try running ${runAll}/bin/${sdn name}";
    in
    writePorcelainOrDieCheck { inherit name src advice command; };
}
