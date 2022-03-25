{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
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
