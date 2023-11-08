# lint-utils - linters for nix

lint-utils contains a library of pre-rolled linters you can use in your flake checks.

```
{


  inputs =  {
    lint-utils = {
      url = "git+https://gitlab.nixica.dev/nix/lint-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
   };


   outputs = inputs@
   {  self
   ,  lint-utils
   , ... 
   }: {
   ...
     checks =
          with lint-utils.outputs.linters.${system}; {
            cabal-fmt = cabal-fmt { src = self; };
            dhall-format = dhall-format { src = self; };
            hlint = hlint { src = self; };
            nixpkgs-fmt = nixpkgs-fmt { src = self; };
            stylish-haskell = stylish-haskell { src = self; };
            werror = werror { pkg = myPkg; };
          };
   };

}
```
