{ config, pkgs, inputs, ... }:

{

  imports = [
    ./programs
    ./shell
    ./development
  ];

  home = {
    username = "alikindsys";
    homeDirectory = "/home/alikindsys";
        
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

