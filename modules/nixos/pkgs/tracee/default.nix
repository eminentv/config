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

  cfg = config.${namespace}.pkgs.tracee;
in

{
  options.${namespace}.pkgs.tracee = {
    enable = mkBoolOpt false "Whether to enable Tracee";
  };
  
}