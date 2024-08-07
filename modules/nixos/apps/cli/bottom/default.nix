{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.apps.cli.bottom;
in
{
  options.${namespace}.apps.cli.bottom = {
    enable = mkBoolOpt false "Enable Bottom instead of HTOP";
  };

  config = mkIf cfg.enable {
    programs.bottom = {
      enable = true;
      settings = {
        flags = {
          avg_cpu = true;
          temperature_type = "c"
        };
        theme = "gruvbox";
      };
    };
  };
}