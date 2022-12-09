{ fourmolu
, writePorcelainLinter
}:

{ src
, opts
, find ? "*.hs"
}: writePorcelainLinter {
  name = "foormolu-all";
  exec = "${fourmolu}/bin/fourmolu -m inplace ${opts}";
  inherit find;
  inherit src;
}
