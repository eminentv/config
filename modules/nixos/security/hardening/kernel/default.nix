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
  cfg = config.${namespace}.security.hardening.kernel;
in
{
  options.${namespace}.security.hardening.kernel = {
    enable = mkBoolOpt false "Whether to do Kernel Hardening";
  };
  config = mkIf cfg.enable {
    environment = {
      memoryAllocator.provider = "scudo";
      variables.SCUDO_OPTIONS = "ZeroContents=1";
      defaultPackages = lib.mkForce [];
    };
    security = {
      lockKernelModules = true;
      protectKernelImage = true;
      forcePageTableIsolation =true;
    };
    boot.kernelParams = [
      # Don't merge slabs
      "slab_nomerge"

      # Overwrite free'd pages
      "page_poison=1"

      # Enable page allocator randomization
      "page_alloc.shuffle=1"

      # Disable debugfs
      "debugfs=off"

      # Enable mitigations
      "mitigations=auto,nosmt"

      # Better entropy, may lead to longer boot time
      "random.trust_cpu=off"
      "random.trust_bootloader=off"
    ];
  };
}