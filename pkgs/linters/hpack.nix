{ hpack
, writePorcelainLinter
}:

{ src }: writePorcelainLinter {
  name = "hpack-all";
  exec = "${hpack}/bin/hpack";
  filepattern = "package.yaml";
  inherit src;
}
