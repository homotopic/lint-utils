{ lib
, prettier
, writePorcelainOrDieCheck
}:

{ src }: writePorcelainOrDieCheck rec {
  name = "prettier-all";
  command = ''${lib.getExe prettier} -w .'';
  inherit src;
  advice = "Found errors with ${name}, try running ${command}";
}
