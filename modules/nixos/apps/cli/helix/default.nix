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

  cfg = config.${namespace}.apps.cli.helix;
in
{
  options.${namespace}.apps.cli.helix = {
    enable = mkBoolOpt false "Whether to install Helix";
  };
  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "gruvbox_dark_hard";
        editor = {
          cursorline = true;
          color-modes =true;
          line-number = "relative";
          true-color = true;
          };
        statusline = {
          left = ["mode" "spacer" "spinner" "spacer" "version-control"];
          center = ["file-name"];
          right = [
            "dignostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
          rainbow-option = "dim";
        };
        lsp.display-messages = true;
        whitespace.characters = {
          
          newline = "↴";
          tab = "⇥";
        };
      };
    };
  };
}