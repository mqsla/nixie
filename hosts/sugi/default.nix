{pkgs, ...}: let
  keys = import ../keys.nix;
in {
  imports = [
    ./hardware.nix
    ./networking.nix
  ];

  boot.loader = {
    grub = {
      enable = true;
      efiSupport = false;
    };

    systemd-boot.enable = false;
    efi.canTouchEfiVariables = false;
  };

  networking.hostName = "sugi";

  time.timeZone = "Etc/UTC";
  i18n.defaultLocale = "C.UTF-8";

  users.users.yanville = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [keys.fuchsia.yanville];
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "clean";
      plugins = ["git"];
    };
  };

  systemd.tmpfiles.rules = [
    "f /home/yanville/.zshrc 0644 yanville users - -"
  ];

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };

  services.qemuGuest.enable = true;
  services.fstrim.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    fastfetch
    git
    htop
    iperf3
    mtr
    nano
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = ["yanville"];
  };

  system.stateVersion = "26.05";
}
