{pkgs}: {
  bettbox = pkgs.callPackage ./bettbox {};
  catppuccin-jetbrains = pkgs.callPackage ./catppuccin-jetbrains {};
  idea-settings = pkgs.callPackage ./idea-settings {};
  truckersmp-cli = pkgs.callPackage ./truckersmp-cli {};
  womic = pkgs.callPackage ./womic {};
}
