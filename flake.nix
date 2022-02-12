{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {
    checks = {
      hlint = runCommand "hlint" { meta = { description = "Run hlint"; } } "cd ${self}; ${hlint}/bin/hlint";
    };
  };
}
