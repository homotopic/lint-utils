{ ormolu
, writePorcelainLinter
}:

{ src, opts }: writePorcelainLinter {
  name = "ormolu-all";
  exec = "${ormolu}/bin/ormolu -i ${opts}";
  filepattern = "*.hs";
  inherit src;
}
