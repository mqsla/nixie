{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
