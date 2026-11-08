{pkgs, ...}: let
  keys = import ../../keys.nix;
in {
  users = {
    defaultUserShell = pkgs.zsh;
    users.tvrz = {
      isNormalUser = true;
      hashedPassword = "$y$j9T$QuxDGfaO/gc39T/H5rE4u0$scjGWOnBLgNlaa204PZnq3iQaFsn2LkNQjFhPdzOh28";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        keys.fuchsia.trwz
        keys.momiji.yanville
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
