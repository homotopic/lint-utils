{ hpack
, writePorcelainLinter
}:

{ src
, find ? "package.yaml"
}: writePorcelainLinter {
  name = "hpack-all";
  exec = "${hpack}/bin/hpack";
  inherit find;
  inherit src;
}
