{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = import ./lib.nix { inherit pkgs; };
      in
      {
        apps = lib.apps;
        linters = lib.linters;
        checks = {
          nixpkgs-fmt = lib.linters.nixpkgs-fmt ./.;
        };
      });
}
