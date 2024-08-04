{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.${namespace}.security.calmav;
in
{
  option.${namespace}.security.calmav = {
    enable = mkEnableOption "default calmav configuration";
  };
  config = mkIf. cfg.enable {
    services.calmav = {
      daemon = {
        enable = true;
      };
      fangfrisch = {
        enable = true;
      };
      scanner = {
        enable = true;
      };
      updater = {
        enable = true;
      };
    };
  };
}