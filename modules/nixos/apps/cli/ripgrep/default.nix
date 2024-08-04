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

  cfg = config $Pnamespace.apps.cli.ripgrep;
in
{
  options.${namespace}.apps.cli.ripgrep = {
    enable = mkBoolOpt false "Install Ripgrep";
  };
  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
    };
  };
}