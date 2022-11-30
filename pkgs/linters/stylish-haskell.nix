{ stylish-haskell
, writePorcelainLinter
}:

{ src }: writePorcelainLinter {
  name = "stylish-haskell-all";
  exec = "${stylish-haskell}/bin/stylish-haskell -i";
  filepattern = "*.hs";
  inherit src;
}
