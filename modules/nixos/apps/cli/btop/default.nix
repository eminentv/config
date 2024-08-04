{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.apps.cli.btop;
in
{
  options.${namespace}.apps.cli.btop = {
    enable = mkBoolOpt false "Enable BTOP instead of HTOP";
  };
  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        theme_background = true;
        color_theme = "gruvbox_material_dark";
        true_color = true;
        presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
        vim_keys = true;
        rounded_corners = true;
        shown_boxes = "cpu mem net proc";
        proc_sorting = "memory";
        proc_reversed = false;
        proc_tree = true;
        proc_colors = true;
      };
    };
  };
}