{
  config,
  pkgs,
  lib,
  namespaces,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.apps.cli.zoxide;
in

{
  options.${namespace}.apps.cli.zoxide = {
    enable = mkBoolOpt false "Install zoxide";
  };
  config = mkIf cfg.enable {
    programs.zoxid = {
      enable = true;
      enableBashIntegration = true;
      enableNushellintegration = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };
  };
}