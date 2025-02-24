{ pkgs, mkDerivation }:

{ src, buildInputs ? [ ], treefmt ? pkgs.treefmt }: mkDerivation {
  name = "treefmt";
  inherit buildInputs src;
  meta = { description = "Run treefmt"; };
  dontBuild = true;
  installPhase = ''
    ${treefmt}/bin/treefmt --fail-on-change --no-cache | tee $out
  '';
}
