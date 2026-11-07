{...}: {
  networking = {
    useDHCP = false;
    useNetworkd = true;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    firewall.enable = true;
  };

  systemd.network = {
    enable = true;

    networks = {
      "10-ens3" = {
        matchConfig.Name = "ens3";
        address = ["198.51.100.42/32"];
        routes = [
          {
            Gateway = "10.0.0.1";
            GatewayOnLink = true;
          }
        ];
      };
    };
  };
}
