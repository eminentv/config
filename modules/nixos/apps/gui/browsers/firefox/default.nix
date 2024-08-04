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

  cfg = config.${namespace.apps.gui.browsers.firefox};
in

{
  options.${namespace}.apps.gui.browsers.firefox = {
    enable = mkBoolOpt false "Install Firefox";
  };
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}