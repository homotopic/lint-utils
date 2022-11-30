{ dhall
, writePorcelainLinter
}:

{ src }: writePorcelainLinter {
  name = "dhall-format-all";
  exec = "-I{} ${dhall}/bin/dhall format {} --unicode";
  filepattern = "*.dhall";
  inherit src;
}
