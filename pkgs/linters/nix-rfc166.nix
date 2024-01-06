{ nixfmt-rfc166
, writePorcelainLinter
}:

{ src
, width ? null
, find ? "*.nix"
}:
let width-flag = if width == null then "" else "-w ${toString width}"; in
writePorcelainLinter {
  name = "nix-rfc166-format";
  exec = "${nixfmt-rfc166}/bin/nixfmt ${width-flag}";
  inherit find;
  inherit src;
}
