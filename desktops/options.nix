{lib, ...}: {
  options.mycustom = {
    desktop = lib.mkOption {
      type = lib.types.enum ["dms" "noctalia"];
      default = "dms";
      description = "DE/Desktop Shell option";
    };

    vm.enable = lib.mkEnableOption "VM guest-specific configuration";
  };
}
