{
  lib,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "pastel-pink";
      bell-features = "no-system,no-audio,no-attention,no-title,no-border";
      term = "xterm-256color";
    };

    themes.pastel-pink = {
      background = "211820";
      foreground = "f3dfe8";
      cursor-color = "f4a7c3";
      selection-background = "5a3b4e";
      selection-foreground = "fff1f6";
      palette = [
        "0=#2a2028"
        "1=#e991a8"
        "2=#b8d8ba"
        "3=#ead3a6"
        "4=#aec6e8"
        "5=#e6a8d1"
        "6=#acd8d3"
        "7=#eadde4"
        "8=#725b69"
        "9=#f3a1b8"
        "10=#c9e4c5"
        "11=#f3dfb4"
        "12=#bfd5f1"
        "13=#f3b7de"
        "14=#bde5df"
        "15=#fff2f7"
      ];
    };
  };

  xdg.terminal-exec = {
    enable = true;
    settings.default = ["com.mitchellh.ghostty.desktop"];
  };

  home.activation.ghosttyIntegration = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${lib.getExe' pkgs.kdePackages.kconfig "kwriteconfig6"} \
      --file kdeglobals \
      --group General \
      --key TerminalApplication \
      ghostty

    ${lib.getExe' pkgs.kdePackages.kconfig "kwriteconfig6"} \
      --file kdeglobals \
      --group General \
      --key TerminalService \
      com.mitchellh.ghostty.desktop

    ${lib.getExe' pkgs.systemd "busctl"} --user call \
      org.kde.kglobalaccel \
      /kglobalaccel \
      org.kde.KGlobalAccel \
      setForeignShortcut \
      asai \
      4 com.mitchellh.ghostty.desktop _launch Ghostty Ghostty \
      1 50331705 \
      >/dev/null 2>&1 || true
  '';
}
