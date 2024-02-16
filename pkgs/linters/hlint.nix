{ pkgs, mkDerivation }:

{ src, hlint ? pkgs.hlint }: mkDerivation {
  name = "hlint";
  inherit src;
  meta = { description = "Run hlint"; };
  dontBuild = true;
  installPhase = ''
    ${hlint}/bin/hlint . | tee $out
  '';
}
