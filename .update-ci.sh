#!/usr/bin/env bash

nix flake show --allow-import-from-derivation --json | json-to-dhall > temp
export INPUT=./temp
dhall-to-yaml --file .gitlab-ci.dhall > .gitlab-ci.yml
