# NixOS Configuration

## Welcome to My Configuration

Welcome to my NixOS configuration repository. This is me learning and building my configuration as I transition away from Gentoo.

- **Personal**: Configurations for Personal Setup Across all Installs, for Example ZSH and Nushell.
- **Laptop**: Configurations tailored for Laptops in General.
- **Workstation**: Configurations geared for Workstation, GUI, Apps
- **Server**: Optimized settings for my home server.
- **VMs**: Configurations for various virtual machines used for testing and development.

## Using Snowfall

This configuration leverages the Snowfall library to streamline and enhance the setup process. Snowfall is a powerful tool that helps manage NixOS configurations.

### Documentation
My Nix configuration, based on the SnowfallOrg lib structure, provides a flexible and organized approach to managing your Nix environment. Here's how it works:

- Custom Library: An optional custom library in the lib/ directory contains a Nix function called with inputs, snowfall-inputs, and lib. The function should return an attribute set to merge with lib.

- Modular Directory Structure: You can create any (nestable) directory structure within lib/, packages/, modules/, overlays/, systems/, and homes/. Each directory should contain a Nix function that returns an attribute set to merge with the corresponding section.

- Package Overlays: The packages/ directory includes an optional set of packages to export. Each package is instantiated with callPackage, and the files should contain functions that take an attribute set of packages and the required lib to return a derivation.

- Modules for Configuration: In the modules/ directory, you can define NixOS modules for various platforms, such as nixos, darwin, and home. This modular approach simplifies system configuration management.

- Custom Overlays: The overlays/ directory is for optional custom overlays. Each overlay file should contain a function that takes three arguments: an attribute set of your flake's inputs and a channels attribute containing all available channels, the final set of pkgs, and the previous set of pkgs. This allows you to customize package sets effectively.

- System Configurations: The systems/ directory organizes system configurations based on architecture and format. You can create configurations for different architectures and formats, such as x86_64-linux, aarch64-darwin, and more.

- Home Configurations: Similar to system configurations, the homes/ directory organizes home configurations based on architecture and format. This is especially useful if you want to manage home environments with Nix.

This structured approach to Nix configuration makes it easier to manage and customize your Nix environment while maintaining flexibility and modularity.

For detailed information about Snowfall and how to use it, please refer to the official Snowfall documentation:

- [Snowfall Documentation](https://snowfall.org/)

## Inspiration and Help

I would like to extend my gratitude to the following individuals and communities for their inspiration, guidance, and support in building this NixOS configuration:

- **Jake Hamilton** - for creating and maintaing Snowfall, and just making everything tie together. [JakeHamilton](https://github.com/jakehamilton/config/tree/main)
- **Khanelinux** - for his awesome configuration and documentation. [Khanelinux](https://github.com/khaneliman/khanelinix/tree/main) 
- **IogaMaster** - For hes videos and Snowfall-Starter Config. [IogaMaster] (https://github.com/IogaMaster/snowfall-starter/tree/main)


## TODO

Still a work in progress and planning

---

Thank you for visiting my NixOS configuration repository. Happy hacking!
