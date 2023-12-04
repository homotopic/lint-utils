{ cabal-fmt
, getBin
, writePorcelainLinter
}:

{ src
, find ? "*.cabal"
}: writePorcelainLinter {
  name = "lint-cabal-fmt";
  exec = "${getBin cabal-fmt}/bin/cabal-fmt -i";
  inherit find;
  inherit src;
}
