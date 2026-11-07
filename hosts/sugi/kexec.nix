{lib, ...}: {
  networking = {
    useDHCP = false;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  system.kexec-installer.name = "sugi-kexec-installer";

  systemd.services.restore-network.enable = false;
  systemd.network.networks."10-sugi-bootstrap" = {
    matchConfig.MACAddress = "00:00:5e:00:53:01";
    linkConfig.RequiredForOnline = "routable";
    address = ["198.51.100.42/32"];
    routes = [
      {
        Gateway = "10.0.0.1";
        GatewayOnLink = true;
      }
    ];
    networkConfig = {
      DHCP = "no";
      IPv6AcceptRA = false;
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAPLACEHOLDER admin@example"
    "ssh-ed25519 AAAAPLACEHOLDER nixos-anywhere@example"
  ];

  networking.firewall.enable = lib.mkForce false;
}
