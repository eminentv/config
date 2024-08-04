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

  cfg = config.${namespace}.apps.cli.eza;
in
{
  options.${namespace}.apps.cli.eza = {
    enable = mkBoolOpt false "whether to install eza";
  };
  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      git = true;
      icons = true;
    };
  };
}
