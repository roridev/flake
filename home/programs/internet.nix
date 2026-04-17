{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox    
#    chromium
    discord
#    cinny-desktop
#    vesktop
#    equibop
    psst
    thunderbird
    qbittorrent
  ];
}
