{ hlint
, mkDerivation
}:

{ src }: mkDerivation {
  name = "hlint";
  inherit src;
  meta = { description = "Run hlint"; };
  dontBuild = true;
  installPhase = ''
    ${hlint}/bin/hlint . | tee $out
  '';
}
