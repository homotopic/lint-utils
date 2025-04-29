{ pkgs, mkDerivation }:

{ src, cabal-project-file }: mkDerivation {
  name = "no-srp";
  inherit src;
  meta = { description = "Disallow source-repository-packages"; };
  dontBuild = true;
  installPhase = ''
  if grep -q source-repository-package ${cabal-project-file}; then
    echo "Error: \"source-repository-package\" found in ${cabal-project-file}"
    exit 1
  else
    echo "Success" > $out
  fi
  '';
}
