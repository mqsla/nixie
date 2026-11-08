{pkgs, ...}: {
  programs = {
    gamescope = {
      enable = true;
      capSysNice = false;
    };
    steam = {
      enable = true;
      extraCompatPackages = [pkgs.unstable.proton-ge-bin];
      package = pkgs.steam.override {
        extraLibraries = packages: [
          packages.gamemode.lib
          packages.mangohud
        ];
      };
    };
    gamemode.enable = true;
  };
  users.users.yanville.extraGroups = ["gamemode"];
}
