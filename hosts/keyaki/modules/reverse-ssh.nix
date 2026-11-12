{pkgs, ...}: {
  systemd.services.fuchsia-reverse-ssh = {
    description = "Reverse SSH tunnel through fuchsia";
    wantedBy = ["multi-user.target"];
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      User = "tvrz";
      Environment = "HOME=/home/tvrz";
      ExecStart = ''
        ${pkgs.openssh}/bin/ssh -NT \
          -i /home/tvrz/.ssh/id_ed25519 \
          -o ExitOnForwardFailure=yes \
          -o ServerAliveInterval=30 \
          -o ServerAliveCountMax=3 \
          -o StrictHostKeyChecking=accept-new \
          -R 0.0.0.0:25566:127.0.0.1:22 \
          tvrz@144.31.203.21
      '';
      Restart = "always";
      RestartSec = "5s";
    };
  };
}
