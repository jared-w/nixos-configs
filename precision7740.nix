with {
  pkgs = import ./nix { };
  sources = import ./nix/sources.nix;
}; {
  imports = [ ./machines/precision7740.nix ./common.nix ./work.nix ];

  boot.plymouth.logo = ./dots/galois.png;

  environment.systemPackages = with pkgs;
    [ (import "${sources.mhnix}/configs.nix" { }).matterhorn ];

  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp111s0.useDHCP = true;
  services.openvpn.servers = import ./openvpn.nix;
  # services.tlp.enable = false;
  environment.etc."systemd/sleep.conf".text = ''
    AllowHibernation=no
    SuspendState=freeze
  '';

  system.stateVersion = "20.03";
}
