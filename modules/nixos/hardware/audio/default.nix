{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types mkIf mkForce;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;
  cfg = config.${namespace}.hardware.audio;
in
{
  options.${namespace}.hardware.audio = with types; {
    enable = mkBoolOpt false "Weather or not to enable Audio Support";
    alsa-monitor = mkOpt attrs {} "Alsa configuration";
    extra-packages = mkOpt (listOf package) [
      pkgs.qjackctl
      pkgs.easyeffects
    ] "Additional packages to install";
    modules = mkOpt (listOf attrs) [ ] "Audio modules to pass to pipewire as 'context.modules'";
    nodes = mkOpt (lstOf attrs) [ ] "Audio nodes to pass to Pipewire as 'context.objects'";
  };
  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [
        pulemixer
        pavucontrol
        helvum
      ]
      ++ cfg.extra-packages;

    hardware.pulseaudio.enable = mkForce false;

    ### COME BACK
    khanelinux = {
      user.extraGroups = [ "audio" ];
    };
    
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      audio.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    programs.noisetorch.enable = true;
  };
}