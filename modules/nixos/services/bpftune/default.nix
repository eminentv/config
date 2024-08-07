{
  config,
  pkgs,
  lib,
  namespaces,
  ...
}:
let
  inherit(lib)mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.bpftune;
in
{
  options.${namespace}.services.bpftune = {
    enable = mkBoolOpt false "Whether to enable BPF Tune";
  };
  config= mkIf cfg.enable {
    services.bpftune.enable = true;
  };
}