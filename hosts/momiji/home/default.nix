{
  agenix,
  keyguard,
  pkgs,
  ...
}: {
  imports = [
    ./programs/zen-browser.nix
    ./programs/ghostty.nix
    ./programs/gnome.nix
    ./programs/nixcord.nix
    ./programs/easyeffects.nix
    ./programs/git.nix
    ./programs/spicetify.nix
    ./programs/minecraft.nix
    ./programs/vscode.nix
    # ./programs/zed-editor.nix
    ./programs/intellij-idea.nix
    ./programs/libreoffice.nix
    ./programs/thunderbird.nix
    ./programs/sober.nix
  ];

  home = {
    username = "yanville";
    homeDirectory = "/home/yanville";
    stateVersion = "26.05";
    packages = with pkgs; [
      audacity
      ayugram-desktop
      codex
      ente-auth
      keyguard
      mangohud
      rustdesk-flutter
      scrcpy
      pkgs.localPackages.clientside.truckersmp-cli
      agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    file.".local/share/Steam/package/beta".text = "publicbeta";
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
    output_folder=/home/yanville/.local/state/MangoHud
  '';

  programs = {
    home-manager.enable = true;
    fastfetch.enable = true;
    zsh = {
      enable = true;
      package = null;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        secret() (cd ~/nixos && EDITOR=nano agenix -e "secrets/$1.age" -i ~/.ssh/id_ed25519_fuchsia)
      '';
      shellAliases = {
        deploy-fuchsia = "NH_SSHOPTS='-4 -F /dev/null -i /home/yanville/.ssh/id_ed25519_fuchsia -o IdentitiesOnly=yes' nh os switch path:/home/yanville/nixos --hostname fuchsia --target-host yanville@144.31.203.21 --elevation-strategy passwordless --ask";
        deploy-tvrz = "nh os switch ~/nixos -H keyaki --target-host tvrz-deploy -e passwordless --ask";

        ls = "eza --icons=auto --group-directories-first";
        ll = "eza --icons=auto --group-directories-first -lah --git";

        grep = "rg --color=auto --smart-case";
        egrep = "rg --color=auto --smart-case";
        fgrep = "rg --color=auto --smart-case --fixed-strings";
      };
      oh-my-zsh = {
        enable = true;
        theme = "clean";
        plugins = ["git"];
      };
    };
  };
}
