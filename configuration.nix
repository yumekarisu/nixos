# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
      ./niri.nix
      ./qt.nix
      ./locale-ime.nix # enable fcitx5 and set locale
      ./fonts.nix # fonts
      ./sound.nix # sound
      ./networkmanager.nix # networkmanager
      ./gaming.nix # steam and gaming
    ];

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
        "psmouse.elantech_smbus=0"
    ];
  };

  # zram swap
  zramSwap.enable = true;

  networking.hostName = "yumeka-ThinkPad"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable32Bit = true; # enable 32-bit GPU driver
  };

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Keyd
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings.main.capslock = "overload(control, muhenkan)";
      };
    };
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable opentabletdriver
  hardware.opentabletdriver.enable = true;

  services.tailscale.enable = true;
  networking.firewall.checkReversePath = "loose";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yumeka = {
    isNormalUser = true;
    description = "yumeka";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.firefox = {
    enable = true;
    package = pkgs.pkgs.librewolf;
    preferences = {
      "sidebar.verticalTabs" = true;
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    sessionVariables = {};
    systemPackages = with pkgs; [
      vim
      git
      curl
      wget
      rclone
      rsync
      stow
      tailscale
      calibre
      sioyek
      libsForQt5.fcitx5-qt
      libappindicator
      jre_minimal
      libreoffice-qt6-fresh
      zotero
      hunspell
      hunspellDicts.en_US
      hunspellDicts.id_ID
      obsidian
      bitwarden-desktop
      ente-auth
      anki-bin
      mpv
      krita
      discord
      spotify
      easyeffects
      protonplus
      protontricks
      qbittorrent
      zed-editor
      nixd
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
