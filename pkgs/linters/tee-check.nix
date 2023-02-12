{ mkDerivation }:

{ name, src, exe }: mkDerivation {
  inherit name src;
  dontBuild = true;
  installPhase = ''
    export LC_ALL=C.UTF-8
    ${exe} | tee $out
  '';
}
