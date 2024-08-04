{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkEnable mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.apps.cli.bat;
in
{
  options.${namespace}.apps.cli.bat = {
    enable = mkBoolOpt false "Whether or not to to replace cat  with bat";
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        style = "numbers,change,header";
        theme = "Catppuccin-mocha";
      };
      extraPackages = builtins.attrValues {
        inherit
        (pkgs.bat-extras)
        batgrep
        batdiff
        batman
        batwatch
        ;
      };
    };
  };
}