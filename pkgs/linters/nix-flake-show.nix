{ nix
, writePorcelainLinter
}:

{ src
, find ? "flake.nix"
}: writePorcelainLinter {
  name = "nix-flake-show";
  exec = "${nix-flake-show}/bin/nixpkgs-fmt";
  inherit find;
  inherit src;
}
