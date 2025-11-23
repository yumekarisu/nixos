{ config, pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };

  programs = {
    niri.enable = true;
    waybar.enable = true;
  };

  security = {
    polkit.enable = true; # polkit
    pam.services.swaylock = {};
  };

  services = {
    udisks2.enable = true;
    dbus.packages = [ pkgs.nautilus ];
    gnome.gnome-keyring.enable = true; # secret service
    /*
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session";
          user = "yumeka";
        };
      };
    };
    */
    xserver.displayManager.lightdm.greeters.gtk = {
      enable = true;
      cursorTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 16;
      };
    };
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
       alacritty
       fuzzel
       swaylock
       mako
       swayidle
       waypaper
       swaybg
       xwayland-satellite
       tuigreet
       brightnessctl
       bluetuith
       pamix
       nautilus
       file-roller
       udiskie
       nwg-look
       qt6Packages.qt6ct
       papirus-icon-theme
       papirus-folders
       adwaita-qt6
       whitesur-cursors
    ];
  };

  qt = {
    enable = true;
    style = "breeze";
    platformTheme = "qt5ct";
  };
}
