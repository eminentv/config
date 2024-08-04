{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.gpu.intel;
in
{
  options.${namespace}.hardware.gpu.intel = {
    enable = mkBoolOpt false "Wether or not to enable support for Intel GPU";
  };
  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
    hardware = {
      opengl = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-sdk
          intel-media-driver
          vaapiIntel
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
      intel-gpu-tools.enable = true;
    };
    driSupport = true;
  };
}