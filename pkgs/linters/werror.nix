{ overrideCabal }:

{ pkg }: overrideCabal
  (old: { buildFlags = (old.buildFlags or [ ]) ++ [ "--ghc-options=-Werror" ]; })
  pkg
