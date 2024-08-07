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

  cfg = config.${namespace}.virtualisation.vswitches;
  vswitchinterface = config.vswitchinterface;
in
{
  options.${namespace}.virtualisation.vswitches = {
    enable = mkBoolOpt false "Whether to enable Open VSwitch";
    interface = mkOption {
      type = lib.types.str;
      default = "";
      description = "Physical Interface to bind to bridge";
    };
  };
  
  config = mkIf cfg.enable {
    virtualisation = {
      vswitch ={
        enable = true;
      };
    };
    networking = {
      vswitches = {
        br0 = {
          interfaces = {
            cfg.interface = {};
            br1 = {
              type = "internal";
              vlan = 1;
            };
            br5 = {
              type = "internal";
              vlan = 5;
            };
            br7 = {
              type = "internal";
              vlan = 7;
            };
            br9 = {
              type = "internal";
              vlan = 9;
            };
            br11 = {
              type = "internal";
              vlan = 11;
            };
            br13 = {
              type = "internal";
              vlan = 13;
            };
            br15 = {
              type = "internal";
              vlan = 15;
            };
          };
        };
      };
    };
  };
}