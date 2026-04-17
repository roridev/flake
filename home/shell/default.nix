{ config, pkgs, ... }:

{
  imports = [ ./fish.nix ./starlight.nix ];

  programs.nix-your-shell.enable = true;
}
