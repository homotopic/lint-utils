{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        writers = pkgs.callPackage ./pkgs/writers.nix { inherit (pkgs.stdenv) mkDerivation; inherit (pkgs.writers) writeBashBin; };
        linters = with pkgs.stdenv; pkgs.callPackage ./pkgs/linters.nix { inherit writers; };
      in
      {
        linters = linters;
        checks = {
          dhall-format = linters.dhall-format { src = ./.; };
          nixpkgs-fmt = linters.nixpkgs-fmt { src = ./.; };
        };
      });
}
