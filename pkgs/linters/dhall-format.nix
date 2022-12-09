{ dhall
, writePorcelainLinter
}:

{ src
, find ? "*.dhall"
}: writePorcelainLinter {
  name = "dhall-format-all";
  exec = "-I{} ${dhall}/bin/dhall format {} --unicode";
  inherit find;
  inherit src;
}
