with {
  pkgs = import ./nix { };
  sources = import ./nix/sources.nix;
}; {
  imports = [
    ./hardware-configuration.nix
    "${sources.nixos-hardware}/common/cpu/intel"
    "${sources.nixos-hardware}/common/pc/ssd"
    "${sources.nixos-hardware}/common/pc/laptop"
    "${sources.home-manager}/nixos"
    ./cachix.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmpOnTmpfs = true;
  boot.plymouth.enable = true;

  networking.useDHCP = false;
  networking.interfaces.wlp58s0.useDHCP = true;
  networking.networkmanager.enable = true;

  i18n = {
    consoleFont = "latarcyrheb-sun20";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  time.timeZone = "America/Los_Angeles";

  nix.trustedUsers = [ "jared" ];

  fonts = {
    fonts = with pkgs; [ noto-fonts noto-fonts-cjk noto-fonts-emoji ];

    fontconfig.penultimate.enable = true;
    fontconfig.useEmbeddedBitmaps = true;
  };

  # TODO: Finish stripping pkgs of all this extra global stuff and stick more
  # packages deeper in eg my zsh config necessitates `lsd` but nothing else
  # does. Neovim requires things like hie, rust, etc.
  #
  # Eventually most of this will migrate to home-manager
  # There exists a natural tension between home-manager and configuration.nix
  # where both want to manage everything if they can but I'd like to have as
  # much of my config work with root and sudo as possible (eg neovim plugins,
  # zsh, etc)
  # I think the best way forward for that will to be to pull the home-manager
  # stuff out to a couple different files and import the common stuff into a
  # users.root as well
  environment.systemPackages = with pkgs; [
    bc
    lsd
    lastpass-cli
    google-chrome
    firefox-devedition-bin
    # Wait for https://github.com/mozilla/nixpkgs-mozilla/issues/199 to be fixed
    # latest.firefox-nightly-bin
    latest.rustChannels.nightly.rust
    # cargo-edit
    binutils.bintools
    git
    htop

    xmonad-with-packages

    neovim-remote
    nodePackages.neovim
    python37Packages.pynvim
    ((neovim.override { withNodeJs = true; }).passthru.unwrapped.overrideAttrs
      (o: {
        version = "master";
        src = sources.neovim;
        buildInputs = o.buildInputs ++ [ utf8proc ];
      }))

    networkmanager
    nix-index
    wget
    nixfmt
    calibre

    aspell
    aspellDicts.en

    ncurses

    yarn
    nodejs-13_x
    nodePackages.node2nix
    universal-ctags
    kitty

    cachix
    ((import sources.all-hies { }).selection {
      selector = p: { inherit (p) ghc865; };
    })
    (import sources.ghcide-nix { }).ghcide-ghc865
    nix-prefetch-git
    nix-prefetch-scripts
    cabal-install
    direnv

    python3
    bat
    fd
    fzf
    gcc
    ghc
    gnumake
    gnupg
    highlight
    libnotify
    libxml2
    mpv
    mupdf
    pandoc
    ranger
    niv
    ripgrep
    stack
    texlive.combined.scheme-full
    w3m
  ];

  environment.variables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    VISUAL = "nvim";
    EDITOR = "nvim";
    # Scroll with a toushcreen in firefox
    MOZ_USE_XINPUT2 = "1";
    RUST_SRC_PATH = "${
        (pkgs.latest.rustChannels.nightly.rust.override {
          extensions = [ "rust-src" ];
        })
      }/lib/rustlib/src/rust/src";
  };

  programs.ssh.startAgent = true;
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    promptInit = "";
  };

  services.thermald.enable = true;
  services.interception-tools.enable = true;
  services.system-config-printer.enable = true;
  services.printing.enable = true;

  location.provider = "geoclue2";
  services.redshift = {
    enable = true;
    temperature = {
      day = 6500;
      night = 2300;
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    autoRepeatDelay = 240;
    autoRepeatInterval = 30;

    libinput = {
      naturalScrolling = true;
      disableWhileTyping = true;
      accelSpeed = "0.5";
    };

    displayManager.sddm = {
      enable = true;
      autoLogin = {
        enable = true;
        user = "jared";
      };
    };

    desktopManager.plasma5.enable = true;

    # TODO: Figure out how to get this done with
    # keeping plasma because I'll lose too much time replicating plasma's setup
    # wrt stuff like NetworkManager, printer, etc. *sigh* whatevs. The
    # convenience is worth losing some street cred I suppose.

    # desktopManager.default = "none";
    # desktopManager.xterm.enable = false;
    # windowManager.default = "xmonad";
    # windowManager.xmonad = {
    #   enable = true;
    #   enableContribAndExtras = true;
    #   haskellPackages = pkgs.unstable.haskellPackages;
    #   config = /home/jared/.config/xmonad/xmonad.hs;
    # };
    # displayManager.sessionCommands = lib.mkAfter ''
    #   ${pkgs.unstable.xorg.xset}/bin/xset r rate 240 30
    # '';

  };

  virtualisation.docker.enable = true;

  users.users.jared = {
    isNormalUser = true;
    home = "/home/jared";
    shell = pkgs.zsh;
    extraGroups =
      [ "wheel" "networkmanager" "tty" "video" "audio" "disk" "docker" ];
  };

  # Use pkgs from system closure by ignoring input args
  home-manager.users.jared = { ... }:
    let
      lorri = import sources.lorri { };
      path = with pkgs; lib.makeSearchPath "bin" [ nix gnutar git mercurial ];
    in {

      home.packages = [ lorri ];

      programs.rofi = {
        enable = true;
        font = "Pragmata Pro 11";
        fullscreen = true;
        extraConfig = ''
          rofi.theme: ./onelight.rasi
        '';
      };

      # home.file.".config/autostart/plasmashell.desktop".text = ''
      #   [Desktop Entry]
      #   Exec=
      #   X-DBUS-StartupType=Unique
      #   Name=Plasma Desktop Workspace
      #   Type=Application
      #   X-KDE-StartupNotify=false
      #   X-DBUS-ServiceName=org.kde.plasmashell
      #   OnlyShowIn=KDE;
      #   X-KDE-autostart-phase=0
      #   Icon=plasma
      #   NoDisplay=true
      # '';
      home.file.".local/share/xmonad/touch".text = "";
      # home.file.".config/plasma-workspace/env/set_window_manager.sh".text = ''
      #   export KDEWM=/home/jared/.local/share/xmonad/xmonad-x86_64-linux
      # '';

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
              oldHighlight = "red bold 52";
              newNormal = "green bold";
              newHighlight = "green bold 22";
            };
            diff = {
              meta = "11";
              frag = "magenta bold";
              commit = "yellow bold";
              old = "red bold";
              new = "green bold";
              whitespace = "red reverse";
            };
          };
        };
      };

      systemd.user.sockets.lorri = {
        Unit = { Description = "lorri build daemon"; };
        Socket = { ListenStream = "%t/lorri/daemon.socket"; };
        Install = { WantedBy = [ "sockets.target" ]; };
      };

      systemd.user.services.lorri = {
        Unit = {
          Description = "lorri build daemon";
          Documentation = "https://github.com/target/lorri";
          ConditionUser = "!@system";
          Requires = "lorri.socket";
          After = "lorri.socket";
          RefuseManualStart = true;
        };

        Service = {
          ExecStart = "${lorri}/bin/lorri daemon";
          PrivateTmp = true;
          ProtectSystem = "strict";
          WorkingDirectory = "%h";
          Restart = "on-failure";
          Environment = "PATH=${path} RUST_BACKTRACE=1";
        };
      };
    };

  system.autoUpgrade.enable = true;
  nix.optimise.automatic = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
