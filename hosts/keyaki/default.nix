{
  imports = [
    ./hardware.nix
    ./modules/base.nix
    ./modules/users.nix
    ./modules/plasma.nix
    ./modules/pipewire.nix
    ./modules/peripherals.nix
    ./modules/gaming.nix
    ./modules/sober.nix
    ./modules/bettbox.nix
    ./modules/reverse-ssh.nix
  ];

  boot.loader.grub.enable = true;

  networking.hostName = "keyaki";
  system.stateVersion = "26.05";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.tvrz = import ./home;
  };
}
