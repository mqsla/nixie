{
  programs.nixcord = {
    enable = true;
    discord = {
      branches = ["stable"];
      vencord.enable = true;
    };
  };
}
