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
}
