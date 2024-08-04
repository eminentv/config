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

  cfg = config.${namespace}.security.otel;
in
{
  options.${namespace}.security.otel {
    enable = mkBoolOpt false "wether to add Otel Collecter";
  };
  config = mkIf cfg.enable {
    services.opentelemetry-collector = {
      enable = true;
    };
  };
}