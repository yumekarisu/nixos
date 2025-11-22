{ config, pkgs, ... }:

{
  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "qt5ct";
  };
}
