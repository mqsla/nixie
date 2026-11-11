{pkgs, ...}: let
  bettbox = pkgs.localPackages.clientside.bettbox;
in {
  environment.systemPackages = [bettbox];

  boot.kernelModules = ["tun"];
  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = ["Bettbox"];
  };

  users.groups.bettbox = {};
  users.users.yanville.extraGroups = ["bettbox"];

  security.wrappers.BettboxCore = {
    source = "${bettbox}/libexec/bettbox/BettboxCore";
    owner = "root";
    group = "bettbox";
    permissions = "u+rx,g+rx,o-rwx";
    setuid = true;
  };
}
