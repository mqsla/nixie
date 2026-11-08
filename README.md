# ❄️ os-nix-config

> the commit history is short because this Nix config used to live in another repo, which no longer exists

| hostname | role |
| --- | --- |
| `momiji` | my desktop and gaming workstation |
| `keyaki` | Ryzen/Radeon KDE gaming workstation belonging to [@TVRZ](https://github.com/tvrzdev) |
| `fuchsia 🇳🇱` | VPS hosted by play2go.cloud - not recommended due to poor network quality |
| `pawass 🇩🇪` | VPS belonging to [@NeMarkAdderly](https://github.com/NeMarkAdderly), also hosted on play2go.cloud |
| `sugi` | example meta-config |

#

| path | purpose |
| --- | --- |
| `flake.nix` | inputs and host definitions |
| `hosts/<hostname>/default.nix` | host entry point |
| `hosts/<hostname>/hardware.nix` | hardware and filesystems |
| `hosts/<hostname>/modules/` | system services and features |
| `hosts/<hostname>/home/` | Home Manager configuration for desktop hosts |
| `packages/clientside/` | shared desktop packages |
| `packages/serverside/` | shared server packages |
| `hosts/keys.nix` | public host keys |
| `secrets.nix` | Agenix secret recipients |
