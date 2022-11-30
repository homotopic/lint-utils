{ fourmolu
, writePorcelainLinter
}:

{ src, opts }: writePorcelainLinter {
  name = "foormolu-all";
  exec = "${fourmolu}/bin/fourmolu -m inplace ${opts}";
  filepattern = "*.hs";
  inherit src;
}
