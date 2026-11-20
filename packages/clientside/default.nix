{pkgs}: let
  kompas3d = pkgs.kdePackages.callPackage ./kompas3d {};
in {
  bettbox = pkgs.callPackage ./bettbox {};
  catppuccin-jetbrains = pkgs.callPackage ./catppuccin-jetbrains {};
  grdcontrol = pkgs.callPackage ./grdcontrol {};
  idea-settings = pkgs.callPackage ./idea-settings {};
  inherit kompas3d;
  kompas3d-fhs = pkgs.callPackage ./kompas3d/fhs.nix {inherit kompas3d;};
  truckersmp-cli = pkgs.callPackage ./truckersmp-cli {};
  womic = pkgs.callPackage ./womic {};
}
