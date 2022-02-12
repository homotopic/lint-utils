{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let pkgs = import nixpkgs { inherit system; };
      in
      {
      checks =
        with pkgs;
        with import ./lib.nix { inherit pkgs; };
       {
        hlint = runCommand "hlint" { meta = { description = "Run hlint"; }; } "cd ${self}; ${hlint}/bin/hlint | tee $out";
        nixpkgs-fmt = porcelainOrDie "nixpkgs-fmt" { meta = { description = "Run nixpkgs-fmt"; }; } "find . -name '*.nix' | xargs -I x ${nixpkgs-fmt}/bin/nixpkgs-fmt $x;" "Nixpkgs-fmt errors, run nixpkgs-fmt";
      };
    });
}
