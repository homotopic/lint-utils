{ stylish-haskell
, writePorcelainLinter
}:

{ src
, find ? "*.hs"
}: writePorcelainLinter {
  name = "stylish-haskell-all";
  exec = "${stylish-haskell}/bin/stylish-haskell -i";
  inherit find;
  inherit src;
}
