{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}).mkBoolOpt enabled;

  cfg = config.${namespace}.profiles.workstation;
in
{
  options.${namespace}.profiles.workstation = {
    enable = mkBoolOpt false "Whether to enable workstation profile";
  };

  config = mkIf cfg.enable {
    eminentlinux = {
      suites = {
        common = enabled;
        desktop = enabled;
        devlopement = enabled;
      };
    };
  };
}