{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox    
#    chromium
   discord
#    vesktop
#    equibop
    psst
    thunderbird
    qbittorrent
  ];
}
