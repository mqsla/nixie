{pkgs, ...}: let
  bettbox = pkgs.callPackage ../packages/bettbox {};
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
    capabilities = "cap_net_admin,cap_net_bind_service,cap_net_raw+ep";
  };
}
