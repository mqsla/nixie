{
  lib,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      gnomeExtensions =
        prev.gnomeExtensions
        // {
          copyous = prev.gnomeExtensions.copyous.overrideAttrs (old: {
            buildInputs = (old.buildInputs or []) ++ [final.libgda5];
            postPatch =
              (old.postPatch or "")
              + ''
                sed -i '/case FileType.Audio:/,/^[[:space:]]*break;$/c\
                \t\tcase FileType.Audio:\
                \t\tcase FileType.Video:\
                \t\t\tfileInfo = new FileInfo(size);\
                \t\t\tbreak;' lib/ui/components/contentInfo.js
              '';
            postInstall =
              (old.postInstall or "")
              + ''
                sed -i "s|/nix/store/[^']*-libgda-6[^']*|${final.libgda5}/lib/girepository-1.0|g" \
                  $out/share/gnome-shell/extensions/copyous@boerdereinar.dev/lib/database/entryTracker.js \
                  $out/share/gnome-shell/extensions/copyous@boerdereinar.dev/lib/preferences/dependencies/dependencies.js

                cp ${final.fetchurl {
                  url = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/es/highlight.min.js";
                  hash = "sha256-eGWDmUnwdk2eCiHjEaTixCYz7q7oyl7BJ7hkOFZXMf4=";
                }} $out/share/gnome-shell/extensions/copyous@boerdereinar.dev/highlight.min.js
              '';
          });
        };
    })
  ];

  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  programs = {
    dconf.enable = true;
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "ghostty";
    };
  };

  environment = {
    gnome.excludePackages = [pkgs.gnome-console];
    sessionVariables.NAUTILUS_4_EXTENSION_DIR = lib.mkForce "/run/current-system/sw/lib/nautilus/extensions-4";
  };

  fonts = {
    packages = [pkgs.twitter-color-emoji];
    fontconfig = {
      defaultFonts.emoji = ["Twitter Color Emoji"];
      localConf = ''
        <fontconfig>
          <alias binding="strong">
            <family>Noto Color Emoji</family>
            <prefer><family>Twitter Color Emoji</family></prefer>
          </alias>
        </fontconfig>
      '';
    };
  };

  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    copyous
    emoji-copy
  ];
}
