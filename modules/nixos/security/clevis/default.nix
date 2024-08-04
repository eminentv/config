{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.security.clevis;
in
{
  options.${namespace}.security.clevis = {
    enable = mkBoolOpt false "Whether or not to enable Clevis";
  };

  config = mkIf cfg.enable {
    boot = {
      initrd = {
        network.enable = true;
        clevis = {
          enable = true;
          useTang = true;
        };;
      };
    };
  };
}