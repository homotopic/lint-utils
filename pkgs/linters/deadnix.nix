{ deadnix
, mkDerivation
}:

{ src }: mkDerivation {
  name = "deadnix";
  inherit src;
  meta = { description = "Run deadnix"; };
  dontBuild = true;
  installPhase = ''
    ${deadnix}/bin/deadnix -f . | tee $out
  '';
}
