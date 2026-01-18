{ config, pkgs, ... }:

{
  imports = [
    ./other.nix    
    ./obs.nix
    ./internet.nix
    ./utilities.nix
    ./games.nix
    ./xcompose.nix
  ];
}
