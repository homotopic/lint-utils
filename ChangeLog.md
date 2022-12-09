# ChangeLog for lint-utils

## v0.1.0.0

* Collection of presets for flake checks: formatting, linting, warnings
  for haskell, nix and dhall.
* `writePorcelainOrDieCheck` will run a `command` on some `src`, and die
  with some `advice` if the execution fails.
* `writePorcelainLinter` is shorthand for
  `"find . -name '${find}' | xargs ${exec}";`, where find and exec
  can be specified by the user.
* Add specific porcelain linters with default `find` presets:
  `cabal-fmt` with `find ? "*.cabal".
  `dhall-format` with `find ? "*.dhall".
  `fourmolu` with `find ? "*.hs".
  `hpack` with `find ? "package.yaml".
  `nixpkgs-fmt` with `find ? "*.nix".
  `ormolu` with `find ? "*.hs".
  `stylish-haskell` with `find ? "*.hs".
* Add two other linters:
  `hlint`, which runs `hlint` on the specified `src`.
  `werror`, which adds `--ghc-options=-Werror` to a cabal project.
