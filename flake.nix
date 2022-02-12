{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      {
      checks = with import nixpkgs { inherit system; };
      {
        hlint = runCommand "hlint" { meta = { description = "Run hlint"; }; } "cd ${self}; ${hlint}/bin/hlint";
      };
    });
}
