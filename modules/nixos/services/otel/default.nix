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

  cfg = config.${namespace}.services.otel;
in

{
  options.${namespace}.services.otel = {
    enable = mkBoolOpt false "Whether to enable Logging Services";
  };
  config = mkIf cfg.enable {
    services.opentelemetry-collector = {
      enable = true;
      settings = [
        
      ]
    }
  }
}