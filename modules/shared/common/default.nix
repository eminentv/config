{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}).suites.common;

  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = {
    enable = mkBoolOpt false "Whether or not to enable common Configuration";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      uutils-coreutils
      policycoreutils
    ]
  }
}