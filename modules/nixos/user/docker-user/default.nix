{
  options,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  
  cfg = config.user;
in
{
  options.${namespace}.user = with types; {
    email = mkOpt str "user" "The email of the user";
    extraGroups = mkOpt (listOf str) [ ] "groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } "extra options passed to <option>users.users.<name>.</option>.";
    fullName = mkOpt str " " "The full name of the user.";
    initialPassword = 
      mkOpt str "password"
        "The initial password to use when the user is first created.";
      name = mkOpt str "" "the name to use for the user account";
  };

  config = {
    environment.systemPackages = with pkgs; [

    ];

    environment.pathsToLink = [ "/share/zsh" ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      histFile = "XDG_CACHE_HOME/zsh.history";
      history = {
        extended = true;
        ignoreAllDups = true;
      };
      sessionVariables = [
        EDITOR = "hx";
        TERM = "xterm-256color";
        USE_EDITOR = "$EDITOR";
        VISUAL = "$EDITOR";
        LANGUAGE = en;
        TZ = US/Eastern;
      ];
      shellAliases = {
        myip = "curl http://ipecho.net/plain; echo";
        rm = "rm -i";
        vim = "hx";
        grep = "rg";
        cat = "bat";
        htop = "btop";
        du = "dust";
      };
      antidote = {
        enable = true;
        plugins = [
          "ohmyzsh/ohmyzsh path:lib/git.zsh"
          "ohmyzsh/ohmyzsh path:lib/clipboard.zsh"
          "ohmyzsh/ohmyzsh path:plugins/aliases"
          "ohmyzsh/ohmyzsh path:plugins/copypath"
          "ohmyzsh/ohmyzsh path:plugins/colored-man-pages"
          "ohmyzsh/ohmyzsh path:plugins/extract"
          "ohmyzsh/ohmyzsh path:plugins/git"
          "ohmyzsh/ohmyzsh path:plugins/git-extras"
          "ohmyzsh/ohmyzsh path:plugins/magic-enter"
          "ohmyzsh/ohmyzsh path:plugins/pyenv"
          "ohmyzsh/ohmyzsh path:plugins/python"
          "ohmyzsh/ohmyzsh path:plugins/tmux"
          "djui/alias-tips"
          "dim-an/cod"
          "wfxr/forgit"
          "MichaelAquilina/zsh-autoswitch-virtualenv"
          "chisui/zsh-nix-shell"
          "nix-community/nix-zsh-completions"
        ];
      };
    };
    users.users.${cfg.name} = {
      inherit (cfg) name initialPassword;

      extraGroups = [
        "wheel"
        "systemd-journal"
        "audio"
        "video"
        "input"
        "plugdev"
        "lp"
        "tss"
        "power"
        "nix"
      ] ++ cfg.extraGroups;

      group = "users";
      home = "/home/${cfg.name}";
      isNormalUser = true;
      shell = pkgs.zsh;
    } // cfg.extraOptions;
  };
}
