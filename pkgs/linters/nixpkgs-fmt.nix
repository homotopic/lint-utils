{ nixpkgs-fmt
, writePorcelainLinter
}:

{ src }: writePorcelainLinter {
  name = "nixpkgs-fmt-all";
  exec = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
  filepattern = "*.nix";
  inherit src;
}
