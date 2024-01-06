{ statix
, mkDerivation
}:

{ src }: mkDerivation {
  name = "statix";
  inherit src;
  meta = { description = "Run statix"; };
  dontBuild = true;
  installPhase = ''
    ${statix}/bin/statix check . | tee $out
  '';
}
