{
  description = "Alikind System Machine Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";
    # In-flight: Fix build of khal, dependency of quickshell
    # nixpkgs-patch-493590 = {
    #   url = "https://github.com/NixOS/nixpkgs/pull/493590.patch";
    #   flake = false;
    # };
    # In-flight: Fix build of lager, dependency of Krita
  };

  outputs = { self, nixpkgs, nixpkgs-patcher, home-manager, dms, niri, ... }@inputs: {
    nixosConfigurations.ideapad-s145 = nixpkgs-patcher.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hosts/ideapad-s145

        home-manager.nixosModules.home-manager {
          home-manager.backupFileExtension = "hmbkp";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = inputs;
          home-manager.users.alikindsys = import ./home;

          home-manager.sharedModules = [
            # niri.homeModules.niri
            # dms.homeModules.dank-material-shell
            # dms.homeModules.niri
          ];
        }
      ];

      specialArgs = inputs;
    };
  };
}
