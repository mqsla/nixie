{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./networking.nix
    ./modules/caddy
  ];

  boot.loader = {
    grub = {
      enable = true;
      efiSupport = false;
    };

    systemd-boot.enable = false;
    efi.canTouchEfiVariables = false;
  };

  networking.hostName = "pawass";

  time.timeZone = "Etc/UTC";
  i18n.defaultLocale = "C.UTF-8";

  users.users.root.extraGroups = ["docker"];
  users = {
    mutableUsers = false;
    users.root = {
      hashedPassword = "$y$j9T$.8090qVZPCnP4lMpHrYvI/$ky3wRK0oBS2j.6VoCBwxJEvHcM6WxCZ.vlijy.IslU3";
      shell = pkgs.zsh;
    };
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
    "f /root/.zshrc 0600 root root - -"
  ];

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
      PubkeyAuthentication = false;
      X11Forwarding = false;
    };
  };

  services.resolved.settings.Resolve = {
    DNSStubListenerExtra = "172.17.0.1";
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      registry-mirrors = [
        "https://docker.m.daocloud.io"
        "https://dockerproxy.com"
        "https://mirror.baidubce.com"
      ];
      dns = ["172.17.0.1"];
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
    docker-compose
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = ["root"];
  };

  system.stateVersion = "26.05";
}
