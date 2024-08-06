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

  cfg = config.${namespace}.virtualisation.incus;
in

{
  options.${namespace}.virtualisation.incus = {
    enable = mkBoolOpt false "Whether to enable Incus";
  };

  config = mkIf cfg.enable {
    networking.nftables.enable = true;
    virtualisation = {
      incus = {
        inherit (cfg) enable;
      };
    };
  };
}