{ pkgs, config, ... }: {
  users.users.jared = {
    isNormalUser = true;
    home = "/home/jared";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "tty"
      "video"
      "audio"
      "disk"
      "docker"
      "libvirtd"
      "adbusers"
      "dialout"
    ];
  };

  home-manager.users.jared = import ./home.nix;
  home-manager.useGlobalPkgs = true;
  systemd.services.home-manager-jared.preStart =
    "${pkgs.nix}/bin/nix-env -i -E";
}
