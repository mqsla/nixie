{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    mutableUserSettings = false;

    extraPackages = with pkgs; [
      alejandra
      bun
      caddy
      nixd
      nodejs_24
      python3
    ];

    extensions = [
      "caddyfile"
      "catppuccin"
      "catppuccin-icons"
      "nix"
    ];

    userSettings = {
      theme = {
        mode = "dark";
        dark = "Catppuccin Mocha";
        light = "Catppuccin Latte";
      };
      icon_theme = "Catppuccin Mocha";
      project_panel.dock = "left";
      title_bar.show_menus = true;

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
          formatter = "language_server";
        };
        Python.language_servers = [
          "basedpyright"
          "ruff"
        ];
      };

      lsp = {
        basedpyright.settings.basedpyright.analysis.typeCheckingMode = "basic";
        nixd.initialization_options.formatting.command = [
          "alejandra"
          "--quiet"
          "--"
        ];
      };
    };
  };
}
