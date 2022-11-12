{ git
, mkDerivation
, writeBashBin
}:

rec {

  writePorcelainOrDieBin = { name, src, command, advice }: mkDerivation {
    inherit name src;
    meta = { description = "Linting check: ${name}"; };
    dontBuild = true;
    installPhase = ''
      PATH="$PATH:${git}/bin"
      export GIT_AUTHOR_NAME="nobody"
      export EMAIL="no@body.com"
      git init
      git add .
      git commit -m "init"
      echo "Running ${command}"
      ${command}
      (if [ -z "$(git status --porcelain)" ]; then
        echo "OK"
      else
        echo "${advice}"
        exit 1
      fi) | tee $out
    '';
  };

  writeFindAndLintBin = { name, filepattern, exec }:
    writeBashBin name "find . -name '${filepattern}' | xargs ${exec}";

  writePorcelainLinter = { name, src, filepattern, exec }:
    let
      runAll = writeFindAndLintBin { inherit name filepattern exec; };
      command = "${runAll}/bin/${name}";
      advice = "Found errors with ${name}, try running ${runAll}/bin/${name}";
    in
    writePorcelainOrDieBin { inherit name src advice command; };
}
