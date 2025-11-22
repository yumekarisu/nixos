{ config, pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };
  programs.niri.enable = true;
  security = {
    polkit.enable = true; # polkit
    pam.services.swaylock = {};
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session";
        user = "yumeka";
      };
    };
  };
  services.gnome.gnome-keyring.enable = true; # secret service
  programs.waybar = {
    enable = true;
  };
  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
       alacritty
       fuzzel
       swaylock
       mako
       swayidle
       xwayland-satellite
       tuigreet
       brightnessctl
       impala
       bluetuith
       pamix
       nwg-look
       qt6Packages.qt6ct
     ];
  };
}
