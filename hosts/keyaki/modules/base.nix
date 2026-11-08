{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "Europe/Moscow";
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_TIME = "en_US.UTF-8";
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = ["tvrz"];

      max-jobs = 2;
      cores = 4;
      auto-optimise-store = true;

      min-free = 3 * 1024 * 1024 * 1024;
      max-free = 8 * 1024 * 1024 * 1024;
    };

    daemonCPUSchedPolicy = "batch";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  systemd.services.nix-daemon.serviceConfig = {
    CPUWeight = 50;
    IOWeight = 50;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };
  services.fstrim.enable = true;

  programs = {
    mtr.enable = true;
    zsh.enable = true;
    nh = {
      enable = true;
      flake = "/home/tvrz/nixos";
    };
  };

  environment.systemPackages = with pkgs; [
    btop
    fastfetch
    git
    nano
    pciutils
    usbutils
    iperf3
    lm_sensors
    util-linux
    vim
    openssl
  ];
}
