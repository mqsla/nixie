{pkgs, ...}: let
  keys = import ../../keys.nix;
in {
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      root.openssh.authorizedKeys.keys = [keys.momiji.yanville];
      yanville = {
        isNormalUser = true;
        hashedPassword = "$y$j9T$dFeNNKUPAhto2SW8/JNc2.$gzAGpYHD332yOVc96lFXuzpBXaqwp2Iu1oNUVpDFMlC";
        extraGroups = ["wheel" "networkmanager"];
        openssh.authorizedKeys.keys = [keys.momiji.yanville];
      };
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
