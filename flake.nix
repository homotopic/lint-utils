{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixfmt-rfc166.url = "github:piegamesde/nixfmt/rfc101-style";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixfmt-rfc166, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (_: _: { nixfmt-rfc166 = nixfmt-rfc166.packages.${system}.default; }) ];
        };
        writers = pkgs.callPackage ./pkgs/writers.nix { inherit (pkgs.stdenv) mkDerivation; inherit (pkgs.writers) writeBashBin; };
        linters = with pkgs.stdenv; pkgs.callPackage ./pkgs/linters.nix { inherit writers; };
      in
      {
        packages = {
          inherit (pkgs)
            deadnix
            dhall
            hlint
            hpack
            nixfmt-rfc166
            nixpkgs-fmt
            ormolu
            statix
            stylish-haskell;
          inherit (pkgs.haskellPackages) cabal-fmt fourmolu;
          inherit (pkgs.nodePackages) prettier;
        };
        checks = {
          deadnix = linters.deadnix { src = ./.; };
          dhall-format = linters.dhall-format { src = ./.; };
          nixpkgs-fmt = linters.nixpkgs-fmt { src = ./.; };
          statix = linters.statix { src = ./.; };
        };
        inherit linters;
        inherit writers;
      });
}
