{
  config,
  pkgs,
  ...
}: let
  email = "me@tvrz.dev";
  keys = import ../../../keys.nix;
  publicKey = keys.fuchsia.trwz;
in {
  home.file.".ssh/id_ed25519.pub".text = "${publicKey}\n";

  programs.git = {
    enable = true;
    signing = {
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    settings = {
      core.sshCommand = "ssh -F /dev/null -i ${config.home.homeDirectory}/.ssh/id_ed25519 -o AddKeysToAgent=yes -o IdentitiesOnly=yes";
      user = {
        name = "TVRZdev";
        inherit email;
      };
      gpg.ssh.allowedSignersFile = toString (pkgs.writeText "git-allowed-signers" "${email} ${publicKey}");
    };
  };
}
