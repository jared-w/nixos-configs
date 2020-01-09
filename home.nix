{ ... }:
with { pkgs = import ./nix { }; }; {
  nixpkgs = { inherit (pkgs) config overlays; };

  programs.firefox = {
    enable = true;
    package = pkgs.latest.firefox-nightly-bin.override { pname = "firefox"; };
    profiles.default = {
      isDefault = true;
      id = 0;
      settings = {
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "gfx.canvas.azure.accelerated" = true;
        "layout.css.devPixelsPerPx" = "1.25";
        "pdfjs.enableWebGL" = true;
      };
    };
    # TODO: Figure out why tridactyl won't install nicely
  };

  xdg.configFile."tridactyl/tridactylrc".source = ./dots/tridactylrc;
  xdg.configFile."kitty".source = ./dots/kitty;
  xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";

  services.lorri.enable = true;
  programs.direnv.enable = true;
  programs.fzf.enable = true;
  # programs.zsh = {
  #   enable = true;
  #   dotDir = ".config/zsh";
  #   # Already configured with zplugin
  #   enableCompletions = false;
  #   initExtraBeforeCompInit =
  # };

  programs.git = {
    enable = true;
    userName = "jared-w";
    userEmail = "jaredweakly@gmail.com";
    package = pkgs.gitAndTools.gitFull;
    extraConfig = {
      core = { pager = "diff-so-fancy | less --tabs=4 -RFX"; };
      color = {
        ui = true;
        diff-highlight = {
          oldNormal = "red bold";
          oldHighlight = "white red";
          newNormal = "green bold";
          newHighlight = "white green";
        };
        diff = {
          meta = "11";
          func = "12";
          frag = "magenta bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
      };
      diff-so-fancy.markEmptyLines = false;
    };
  };
}
