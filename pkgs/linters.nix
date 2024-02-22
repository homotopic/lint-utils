{ pkgs, haskellPackages, callPackage, writers, ... }:
with pkgs.haskell.lib.compose;
with writers;
{

  cabal-fmt = callPackage ./linters/cabal-fmt.nix {
    inherit (pkgs.lib) getBin;
    inherit writePorcelainLinter;
    inherit (haskellPackages) cabal-fmt;
  };

  deadnix = callPackage ./linters/deadnix.nix { inherit (pkgs.stdenv) mkDerivation; };

  dhall-format = callPackage ./linters/dhall-format.nix { inherit writePorcelainLinter; };

  fourmolu = callPackage ./linters/fourmolu.nix { inherit writePorcelainLinter; inherit (haskellPackages) fourmolu; };

  hlint = callPackage ./linters/hlint.nix { inherit (pkgs.stdenv) mkDerivation; };

  hpack = callPackage ./linters/hpack.nix { inherit writePorcelainLinter; };

  nix-rfc166 = callPackage ./linters/nix-rfc166.nix { inherit writePorcelainLinter; };

  nixpkgs-fmt = callPackage ./linters/nixpkgs-fmt.nix { inherit writePorcelainLinter; };

  ormolu = callPackage ./linters/ormolu.nix { inherit writePorcelainLinter; };

  prettier = callPackage ./linters/prettier.nix {
    inherit writePorcelainOrDieCheck; inherit (pkgs.nodePackages) prettier;
  };

  statix = callPackage ./linters/statix.nix { inherit (pkgs.stdenv) mkDerivation; };

  stylish-haskell = callPackage ./linters/stylish-haskell.nix { inherit writePorcelainLinter; };

  tee-check = callPackage ./linters/tee-check.nix { inherit (pkgs.stdenv) mkDerivation; };

  treefmt = callPackage ./linters/treefmt.nix { inherit (pkgs.stdenv) mkDerivation; };

  werror = callPackage ./linters/werror.nix { inherit overrideCabal; };

}
