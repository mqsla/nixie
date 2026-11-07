{...}: {
  services.rustdesk-server = {
    enable = true;
    openFirewall = true;

    signal = {
      enable = true;
      relayHosts = ["fuchsia.wanivy.com"];
      extraArgs = ["-k" "_"];
    };

    relay = {
      enable = true;
      extraArgs = ["-k" "_"];
    };
  };
}
