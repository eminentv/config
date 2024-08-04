inputs@{
  options,
  config,
  lib,
  pkgs,
  namespace,
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.cli.atuin;
in
{
  options.${namespace}.cli-apps.atuin = with types; {
    enable = mkBoolOpt false "Whether or not to enable neovim.";
  };
  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = {
        auto_sync = true;
        sync_fregquency = "5m";
        filter_mode = "host";
        search_mode = "fuzzy";
        filter_mode_shell_up_key_binding = "directory";
        keymap_mode = "vim-inset";
        show_preview = true;
        style = "auto";
        invert = false;
        inline_height = 20;
      };
    };
  };
}