{
  options,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namesspace}) mkBoolOpt;

  cfg = config.${namespace}.tools.gnupg;
in
{
  options.${namespace}.tools.gnupg = {
    enable = mkBoolOpt false "Enable gnupg";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.pinetry pkgs.pinentry-curses]
  }
}