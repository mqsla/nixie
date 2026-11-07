{...}: {
  networking = {
    useDHCP = false;
    useNetworkd = true;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    extraHosts = ''
      87.120.186.222 wcf.taiwan1989.xyz pawass
    '';

    firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
      allowedUDPPorts = [443];
      trustedInterfaces = ["docker0"];
    };
    nat.enable = true;
  };

  systemd.network = {
    enable = true;

    networks."10-ens3" = {
      matchConfig.Name = "ens3";
      linkConfig.RequiredForOnline = "routable";
      address = ["87.120.186.222/32"];
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
  };
}
