{ config, pkgs, ... }:

{

  services.desktopManager.lomiri = {
    enable = true;
  };
  
  xdg.portal = {
  	extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
	enable = true;
  };
}
