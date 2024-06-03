{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
    fastfetch
    eza
    ripgrep
    jq
    flameshot
    nix-direnv
    direnv
    wget
    zip
    unzip
    busybox
    gnupg
  ];

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
}
