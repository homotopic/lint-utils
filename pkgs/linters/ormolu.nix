{ ormolu
, writePorcelainLinter
}:

{ src
, find ? "*.hs"
, opts
}: writePorcelainLinter {
  name = "ormolu-all";
  exec = "${ormolu}/bin/ormolu -i ${opts}";
  inherit find;
  inherit src;
}
