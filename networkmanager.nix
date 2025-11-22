{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    dns = "systemd-resolved";
  };
  services.resolved = {
    enable = true;
    domains = [ "~." ];
    dnsovertls = "true";
    fallbackDns = [
      "194.242.2.4#base.dns.mullvad.net"
      "194.242.2.2#dns.mullvad.net"
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
  };
}
