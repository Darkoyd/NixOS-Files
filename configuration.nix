# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  boot.supportedFilesystems = ["ntfs"];
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "minegrub-theme";
    version="2.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "Lxtharia";
      repo = "minegrub-theme";
      rev = "v2.0.0";
      hash = "sha256-HZnVr9NtierP22pMy8C/BeZJDpBkKixROG0JaCAq5Y8=";
    };
    installPhase = "cp -r minegrub $out";
  };
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Experimentals
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [mozc];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT = "es_CO.UTF-8";
    LC_MONETARY = "es_CO.UTF-8";
    LC_NAME = "es_CO.UTF-8";
    LC_NUMERIC = "es_CO.UTF-8";
    LC_PAPER = "es_CO.UTF-8";
    LC_TELEPHONE = "es_CO.UTF-8";
    LC_TIME = "es_CO.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "latam";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [pkgs.hplip];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.darkoyd = {
    isNormalUser = true;
    description = "Catalina";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    openssh.authorizedKeys.keys = ["AAAAB3NzaC1yc2EAAAADAQABAAABgQDTskePFD4/nYz94EuNUcXzxE8DZwYMv94zTiYLv/v3Xdl0jR1aZ5yx56VHMpnkUF9JMyWQFVJcZBo0p+3VsMK3y9jWDoLLwjKWcglHqc5xy6FzKP3I+B4l+BV/4io6RhW0rji6uTeHWcCuVxLlfYVPRjQaFo+cQZF66Y+VdKoD3gb1Fjs0j/g8CY1c5XbfbdcPnwtTBOT2ZMWsZV4K49I+W9N4abREA0TY6/XqUYqp/Sxxgd2mbFwehC1Y292IN6MSK5/ybjsSbPwMlQ0VdODJHHYDQTQQVlzy3aQmbuHHUavBAUhKXAnTg/lKVTx9YWqJYHEvjHqwBRjPKUtf1l/GVjiKB+MAWvtziAmkQ/UCTKTiGkEQvFJxJKCvmMSbjUWIb56epFxwh9JlxYYVpKZjFKHc0UafO+aSkex5OtZV9hODfIDnySfOZMZSG3xaJfnQ1q9iqJr9wOz3lzQAXF8jJ9JQWcr6k9523D9+9d4TuA2UKPEOCwDqgeH7QAhz9Gs="];
    packages = with pkgs; [
    #  kate
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "darkoyd";


  # Flatpak
  services.flatpak.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     	opera
	spotify-player
	nodejs_21
	texliveFull
	git
	ntfs3g
	insomnia
	rustup
	gcc
	elixir_1_16
	erlang_26
	android-studio
	python3
	qjackctl
	sonic-pi
	pulseaudioFull
	woeusb
	libreoffice-qt
	glpk
	ipopt
	neofetch
	gimp
	jdk17
	vscode
	gleam
	gparted
	fwup
	etcher
	avahi
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];
  nixpkgs.config.permittedInsecurePackages = ["electron-19.1.9"];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
  # ADB support
   
   programs.adb.enable = true;

   programs.nix-ld.enable = true;   
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
#   services.avahi = {
#     nssmdns = true;
#     enable = true;
#     ipv4 = true;
#     ipv6 = true;
#     publish = {
#	enable = true;
#	addresses = true;
#	workstation = true;
  #   };
  # };
  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
