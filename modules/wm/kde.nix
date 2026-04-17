{ config, pkgs, ... }:

{

  # SDDM for KDE
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
  };

  programs.kdeconnect.enable = true;

  services.desktopManager.plasma6 = {
    enable = true;
  };
  
  xdg.portal = {
    enable = true;
  };

}
