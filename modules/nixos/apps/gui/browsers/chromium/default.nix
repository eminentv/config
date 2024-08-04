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

  cfg = config.${namespace}.apps.gui.broswers.chromium;
in
{
  options.${namesspace}.apps.gui.browsers.chromium = {
    enable = mkBoolOpt false "Install chromium";
  };

  home.programs.chromium = {
    enable = true;
    extensions = [
      { id = ""; }
    ];
  }
}