{ config, pkgs, ... }:
let sources = import ./nix/sources.nix;
in let
  dynamic-wallpaper = pkgs.stdenv.mkDerivation {
    name = "dynamic-wallpaper";
    nativeBuildInputs = [ pkgs.wrapGAppsHook pkgs.glib ];
    buildInputs = with pkgs; [
      glib
      ncurses
      xorg.xrandr
      gsettings-desktop-schemas
      dbus
      gnome3.dconf
    ];
    src = sources.dynamic-wallpaper;
    installPhase = ''
      mkdir -p $out/bin $out/share/dynamic-wallpaper
      cp -r ./dwall.sh ./images $out/share/dynamic-wallpaper
      sed -i -e "s!/usr/share/!/share/!g" -e "s!DIR=\"!DIR=\"$out!g" \
          $out/share/dynamic-wallpaper/dwall.sh
      ln -s $out/share/dynamic-wallpaper/dwall.sh $out/bin/dwall
    '';
  };
in {
  home-manager.users.jared.systemd.user.services.dynamic-wallpaper = {
    Service.Type = "oneshot";
    Service.Environment = "DISPLAY=:0";
    Service.ExecStart = "${dynamic-wallpaper}/bin/dwall -o firewatch ";
    Install.WantedBy = [ "graphical-session.target" ];
  };
  home-manager.users.jared.systemd.user.timers.dynamic-wallpaper = {
    Timer.OnCalendar = "*:0/5";
    Timer.Persistent = "true";
    Timer.Unit = "dynamic-wallpaper.service";
    Install.WantedBy = [ "dynamic-wallpaper.service" ];
  };
  # systemd.user.services.dynamic-wallpaper = {
  #   environment.DISPLAY = ":0";
  #   environment.DESKTOP_SESSION = "gnome";
  #   environment.TERM = "xterm-256color";
  #   path = with pkgs; [
  #     glib
  #     ncurses
  #     xorg.xrandr
  #     gsettings-desktop-schemas
  #     dbus
  #     gnome3.dconf
  #     gawk
  #   ];
  #   script = ''
  #     source ${config.system.build.setEnvironment}
  #     ${dynamic-wallpaper}/bin/dwall -o firewatch
  #   '';
  #   serviceConfig.Type = "oneshot";
  #   startAt = "hourly";
  #   wantedBy = [ "graphical-session.target" ];
  # };
}
