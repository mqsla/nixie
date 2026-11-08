{
  config,
  inputs,
  lib,
  ...
}: {
  imports = ["${inputs.nixpkgs}/nixos/modules/installer/scan/not-detected.nix"];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "sd_mod"
      "usb_storage"
      "usbhid"
      "xhci_pci"
    ];
    initrd.kernelModules = ["amdgpu"];
    kernelModules = ["kvm-amd"];
  };

  disko.devices.disk.main = {
    type = "disk";
    device = lib.mkDefault "/dev/disk/by-id/nvme-ADATA_LEGEND_750_6L202L116148";

    destroy = false;

    content = {
      type = "gpt";
      partitions = {
        bios = {
          priority = 0;
          start = "34s";
          end = "2047s";
          type = "EF02";
          label = "BIOSBOOT";
        };

        games = {
          priority = 1;
          start = "2048s";
          end = "706238463s";
          type = "8300";
          uuid = "9db3f4c7-3457-4822-9ee0-a27b70e3b030";
          label = "games";
        };

        esp = {
          priority = 2;
          start = "706238464s";
          end = "708335615s";
          type = "EF00";
          uuid = "2f8b6cdc-86fe-47a4-a707-2cc949117811";
          label = "NIXBOOT";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };

        root = {
          priority = 3;
          start = "708335616s";
          end = "976773119s";
          type = "8300";
          uuid = "5da5fab3-c8fd-4a61-a1b8-730aa4a5a19f";
          label = "system";
          content = {
            type = "filesystem";
            format = "btrfs";
            mountpoint = "/";
            mountOptions = [
              "compress=zstd"
              "noatime"
            ];
          };
        };
      };
    };
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/8e2f4344-1efe-469e-8aca-b0c95c96eb6b";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "noatime"
    ];
  };

  swapDevices = [];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
