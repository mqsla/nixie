{
  config,
  inputs,
  lib,
  ...
}: {
  imports = ["${inputs.nixpkgs}/nixos/modules/installer/scan/not-detected.nix"];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel" "coretemp"];
  boot.extraModulePackages = [];

  disko.devices = {
    disk.main = {
      type = "disk";
      device = lib.mkDefault "/dev/disk/by-id/nvme-eui.324f3433323951534ce000184334434c";
      destroy = true;
      content = {
        type = "gpt";
        partitions = {
          esp = {
            priority = 1;
            size = "1G";
            type = "EF00";
            uuid = "083b0113-6961-4a3f-bb29-bc620ff052f5";
            label = "NIXBOOT";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["fmask=0077" "dmask=0077"];
            };
          };
          root = {
            priority = 2;
            size = "238G";
            type = "8300";
            uuid = "f7e9059b-02e3-415a-b5ed-5c385a7e87a1";
            label = "system";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/";
              mountOptions = ["compress=zstd" "noatime"];
            };
          };
          files = {
            priority = 3;
            size = "100%";
            type = "8300";
            uuid = "d40107c5-7816-4f56-8880-cbada33e670a";
            label = "files";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/mnt/nvme";
              mountOptions = ["compress=zstd" "noatime"];
            };
          };
        };
      };
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
