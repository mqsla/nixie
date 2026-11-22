{
  lib,
  pkgs,
  ...
}: {
  dconf.settings = {
    "org/gnome/shell" = {
      always-show-log-out = true;
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        blur-my-shell.extensionUuid
        copyous.extensionUuid
        emoji-copy.extensionUuid
      ];
    };
    "org/gnome/shell/extensions/copyous" = {
      database-backend = "json";
      disable-hljs-dialog = true;
    };
    "org/gnome/shell/extensions/copyous/code-item".syntax-highlighting = false;
    "org/gnome/shell/extensions/copyous/file-item" = {
      file-preview-visibility = "hidden";
      syntax-highlighting = false;
    };
    "org/gnome/shell/extensions/copyous/link-item".show-link-preview = false;
    "org/gnome/desktop/interface" = {
      accent-color = "pink";
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    "org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple ["xkb" "us"])
        (lib.hm.gvariant.mkTuple ["xkb" "ru"])
      ];
      xkb-options = ["grp:alt_shift_toggle"];
    };
    "org/gnome/settings-daemon/plugins/media-keys".mic-mute = ["F10"];
  };
}
