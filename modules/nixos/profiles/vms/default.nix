{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.profiles.vm;
in
{
  options.${namespace}.profiles.vm = {
    enable = mkBoolOpt false "Whether ornot to ienable the vm Profile";
  };
  
  config = mkIf cfg.enable {
    eminentlinux = {
      suits = {
        common = enabled;
        vm = enabled;
      };
    };
  };
}