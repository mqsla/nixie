{pkgs, ...}: let
  inherit (pkgs.localPackages.clientside) grdcontrol kompas3d-fhs;
in {
  environment.systemPackages = [
    grdcontrol
    kompas3d-fhs
  ];

  services.udev.packages = [grdcontrol];

  systemd.services.grdcontrol = {
    description = "Guardant Control Center";
    wantedBy = ["multi-user.target"];
    wants = ["network-online.target"];
    after = ["network-online.target"];

    serviceConfig = {
      Type = "forking";
      ExecStart = "${grdcontrol}/libexec/grdcontrol/grdcontrold --daemon";
      WorkingDirectory = "${grdcontrol}/libexec/grdcontrol";
      StateDirectory = "grdcontrol";
      Restart = "on-abort";
      LimitNOFILE = "infinity";
    };
  };
}
