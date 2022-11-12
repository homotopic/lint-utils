{ cabal-fmt
, writePorcelainLinter
}:

{ src }: writePorcelainLinter {
  name = "lint-cabal-fmt";
  exec = "${cabal-fmt}/bin/cabal-fmt -i";
  filepattern = "*.cabal";
  inherit src;
}
