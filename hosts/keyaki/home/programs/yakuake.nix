{
  lib,
  pkgs,
  ...
}: let
  kconfig = lib.getExe' pkgs.kdePackages.kconfig "kwriteconfig6";
  yakuake = pkgs.kdePackages.yakuake;
in {
  home.packages = [yakuake];

  xdg = {
    configFile."autostart/org.kde.yakuake.desktop".source = "${yakuake}/share/applications/org.kde.yakuake.desktop";

    terminal-exec = {
      enable = true;
      settings.default = ["org.kde.yakuake.desktop"];
    };
  };

  home.activation.yakuakeDefaultTerminal = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${kconfig} \
      --file kdeglobals \
      --group General \
      --key TerminalApplication \
      yakuake

    ${kconfig} \
      --file kdeglobals \
      --group General \
      --key TerminalService \
      org.kde.yakuake.desktop
  '';
}
