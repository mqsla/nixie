let
  keys = import ./hosts/keys.nix;
  recipients = [
    keys.fuchsia.yanville
    keys.fuchsia.host
  ];
in {
  # --- Calagopus ---
  "secrets/fuchsia/calagopus/app-encryption-key.age".publicKeys = recipients;
  "secrets/fuchsia/calagopus/wings-token-id.age".publicKeys = recipients;
  "secrets/fuchsia/calagopus/wings-token.age".publicKeys = recipients;

  # --- RustDesk ---
  "secrets/fuchsia/rustdesk/id_ed25519.age".publicKeys = recipients;
}
