{
  services.flatpak = {
    enable = true;
    packages = ["org.vinegarhq.Sober"];
    overrides."org.vinegarhq.Sober".Context.devices = ["input"];
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
  };
}
