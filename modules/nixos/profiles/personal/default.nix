{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.profiles.personal;
in
{
  options.${namespace}.profiles.personal = {
    enable = mkBoolOpt false "Whether to enable the personal profile";
  };

  config = mkif cfg.enable {
    eminentlinux = {
      services = {};
      suites = {};
    };
  };
}