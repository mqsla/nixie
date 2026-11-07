{pkgs, ...}: {
  programs = {
    gamescope = {
      enable = true;
      capSysNice = false;
    };
    steam = {
      enable = true;
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
