{ cabal-fmt
, writePorcelainLinter
}:

{ src
, find ? "*.cabal"
}: writePorcelainLinter {
  name = "lint-cabal-fmt";
  exec = "${cabal-fmt}/bin/cabal-fmt -i";
  inherit find;
  inherit src;
}
