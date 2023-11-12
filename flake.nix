{
  description = "NixOS configuration with flakes";
  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    nh.url = "github:viperML/nh";
    homeage.url = "github:jordanisaacs/homeage";
    homeage.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    talhelper.url = "github:budimanjojo/talhelper";
    talhelper.inputs.nixpkgs.follows = "nixpkgs";
    nh.inputs.nixpkgs.follows = "nixpkgs";
    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    neovim-src = {
      url = "github:neovim/neovim";
      flake = false;
    };
    #nixfmt = {
    #  url = "github:piegamesde/nixfmt?ref=rfc101-style";
    #};
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    stylix,
    nixpkgs,
    chaotic,
    nixos-hardware,
    home-manager,
    ...
  }: {
    homeConfigurations.domglusk = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    nixosConfigurations = {
      dominix-surfacepro7 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
          chaotic.nixosModules.default
          stylix.nixosModules.stylix
        ];
      };
    };
  };
  #     customRC = import ./home/domglusk/.config/nvim/init.lua;
  #     neovimConfig = neovimUtils.makeNeovimConfig {
  #       plugins = [
  #         # Add plugins from nixpkgs here
  #         nixpkgs.vimPlugins.nvim-treesitter.withAllGrammars
  #       ]
  #       ++ lib.mapAttrsToList
  #         (name: src: (nixpkgs.vimUtils.buildVimPlugin { inherit name src; }))
  #         (import ./npins);
  #       withPython3 = true;
  #       extraPython3Packages = _: [ ];
  #       withRuby = true;
  #       viAlias = false;
  #       vimAlias = false;
  #     };
}
