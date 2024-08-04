{
  options,
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; {
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  options.home = with types; {
    file = 
      mkOpt attrs {}
      "A set of files to be managed by home-managers <option>home.file</option>.";
    configfile = 
      mkOpt attrs {}
      "A set of files to bemanaged by home-manager's <option>xdg.configFile</option>.";
    programs = mkOpt attrs {} "Programs to bemanaged by home-manager.";
    extraOptions = mkOpt attrs {} "Options to pass directly to home-manager.";
  };

  config = {
    home.extraOptions = {
      home.stateVersion = config.system.statVersion;
      home.file = mkAliasDefinitions options.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.home.configFile;
      programs = mkaliasDefinitions options.home.programs;
    };

    home-manager = {
      useUserPackages = true;

      users.${config.user.name} =
        mkAliasDefinitions options.home.extraOptions;
    };
  };
}