{ pkgs, haskellPackages, callPackage, writers, ... }:
with pkgs.haskell.lib.compose;
with writers;
{

  cabal-fmt = callPackage ./linters/cabal-fmt.nix { inherit writePorcelainLinter; inherit (haskellPackages) cabal-fmt; };

  dhall-format = callPackage ./linters/dhall-format.nix { inherit writePorcelainLinter; };

  fourmolu = callPackage ./linters/fourmolu.nix { inherit writePorcelainLinter; inherit (haskellPackages) fourmolu; };

  hlint = callPackage ./linters/hlint.nix { inherit (pkgs.stdenv) mkDerivation; };

  hpack = callPackage ./linters/hpack.nix { inherit writePorcelainLinter; };

  nixpkgs-fmt = callPackage ./linters/nixpkgs-fmt.nix { inherit writePorcelainLinter; };

  ormolu = callPackage ./linters/ormolu.nix { inherit writePorcelainLinter; };

  stylish-haskell = callPackage ./linters/stylish-haskell.nix { inherit writePorcelainLinter; };

  tee-check = callPackage ./linters/tee-check.nix { inherit (pkgs.stdenv) mkDerivation; };

  werror = callPackage ./linters/werror.nix { inherit overrideCabal; };

}
