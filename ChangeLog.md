# lint-utils

## v0.1.0.0

* Collection of presets for flake checks: formatting, linting, warnings
  for haskell, nix and dhall.
* `writePorcelainOrDieCheck` will run a `command` on some `src`, and die
  with some `advice` if the execution fails.
