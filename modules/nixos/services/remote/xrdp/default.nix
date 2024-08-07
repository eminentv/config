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

  cfg = config.${namespace}.services.remote.xrdp;
in
{
  options.${namespace}.services.remote.xrdp = {
    enable = mkBoolOpt false "Whether to Enable RDP";
  };
  config = mkIf cfg.enable {
    services.xrdp = {
      enable = true;
      openFirewall = true;
      defaultWindowManager = "gnome";
      audio.enable = true;
    };
  };
}