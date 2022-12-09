{ nixpkgs-fmt
, writePorcelainLinter
}:

{ src
, find ? "*.nix"
}: writePorcelainLinter {
  name = "nixpkgs-fmt-all";
  exec = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
  inherit find;
  inherit src;
}
