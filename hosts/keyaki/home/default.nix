{pkgs, ...}: {
  imports = [
    ./programs/easyeffects.nix
    ./programs/ghostty.nix
    ./programs/git.nix
    ./programs/libreoffice.nix
    ./programs/minecraft.nix
    ./programs/nixcord.nix
    ./programs/sober.nix
    ./programs/spicetify.nix
    ./programs/vscode.nix
    ./programs/zen-browser.nix
  ];

  home = {
    username = "tvrz";
    homeDirectory = "/home/tvrz";
    stateVersion = "26.05";
    packages = with pkgs; [
      ayugram-desktop
      eza
      ouch
      ripgrep
      rustdesk-flutter
      scrcpy
    ];
    file.".local/state/MangoHud/.keep".text = "";
  };

  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    legacy_layout=0
    position=top-left
    fps
    frametime
    frame_timing
    cpu_stats
    gpu_stats
    ram
    vram
    histogram
    autostart_log=1
    log_duration=0
    output_folder=/home/tvrz/.local/state/MangoHud
  '';

  programs = {
    home-manager.enable = true;
    fastfetch.enable = true;
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "eza --icons=auto --group-directories-first";
        ll = "eza --icons=auto --group-directories-first -lah --git";

        grep = "rg --color=auto --smart-case";
        egrep = "rg --color=auto --smart-case";
        fgrep = "rg --color=auto --smart-case --fixed-strings";
      };
      oh-my-zsh = {
        enable = true;
        theme = "bira";
        plugins = ["git"];
      };
    };
  };
}
