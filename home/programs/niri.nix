{ pkgs, lib, config, ...}:
{
  programs.dank-material-shell = {
    enable = true;
    niri = {
      includes = {
        enable = true;
        override = true;
        originalFileName = "hm";

        filesToInclude = [
          "alttab"
          "binds"
          "colors"
          "layout"
        ];
      };
      enableSpawn = true;
    };

    enableDynamicTheming = true;
    enableClipboardPaste = true;
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      prefer-no-csd = true;
      input.keyboard.xkb = {
        layout = "br";
        variant = "abnt2";
      };

      input.mouse = {
        accel-profile = "flat";
      };

      layout = {
        gaps = 4;
        focus-ring = {
          enable = true;
          width = 2;
        };
      };
    };
  };

  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  #   config = {
  #     common = {
  #       default = "*";
  #       "org.freedesktop.impl.portal.ScreenCast" = "*";
  #     };
  #   };
  #   
  #   extraPortals = with pkgs; [
  #     kdePackages.xdg-desktop-portal-kde
  #     xdg-desktop-portal-gtk
  #     xdg-desktop-portal-gnome
  #   ];
  # };
}
