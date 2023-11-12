# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  lib,
  pkgs,
  packages,
  programs,
  ...
}: let
  home-manager =
    builtins.fetchTree
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  sha256 = "sha256-xFumnivtVwu5fFBOrTxrv6fv3geHKF04RGP23EsDVaI=";
  nix-software-center = import (pkgs.fetchFromGitHub {
    owner = "vlinkz";
    repo = "nix-software-center";
    rev = "0.1.2";
    sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
  }) {};

  wallpaper-engine-kde-plugin = pkgs.plasma5Packages.callPackage ./wallpaper-engine-kde-plugin.nix {
    inherit (pkgs.gst_all_1) gst-libav;
    inherit (pkgs.python3Packages) websockets;
  };
  plasma5-wallpapers-dynamic = pkgs.plasma5Packages.callPackage ./plasma5-wallpapers-dynamic.nix;
  alejandra =
    (import (builtins.fetchTarball {
      url = "https://github.com/kamadorueda/alejandra/tarball/3.0.0";
      sha256 = "sha256:18jm0d5xrxk38hw5sa470zgfz9xzdcyaskjhgjwhnmzd5fgacny4";
    }) {})
    .outPath;
in {
  hardware.ckb-next.enable = true;
  hardware.sensor.iio.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.i2c.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    intel-ocl
    intel-vaapi-driver
  ];
  hardware.acpilight.enable = true;
  gtk.iconCache.enable = true;

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.sansSerif = ["NotoSans Nerd Font"];
  fonts.fontconfig.subpixel.rgba = "rgb";
  fonts.fontconfig.defaultFonts.serif = ["NotoSerif Nerd Font"];
  fonts.fontconfig.defaultFonts.monospace = ["NotoSans Nerd Font"];
  fonts.fontconfig.hinting.style = "full";
  environment.enableAllTerminfo = true;
  environment.shellAliases = {
    catridges = "flatpak run hu.kramo.Cartridges";
    discord = "flatpak run de.shorsh.discord-screenaudio";
    retroarch = "flatpak run org.libretro.RetroArch";
    stremio = "flatpak run com.stremio.Stremio";
    geeqie = "flatpak run org.geeqie.Geeqie";
    ezsh = "exec zsh";
    yuzu = "flatpak run org.yuzu_emu.yuzu";
    flatseal = "flatpak run com.github.tchx84.Flatseal";
    ksu = "pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY KDE_SESSION_VERSION=5 KDE_FULL_SESSION=true";
    nvidia-powerstate = "cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status";
    nvidia-modeset-test = "sudo cat /sys/module/nvidia_drm/parameters/modeset";
    my-ip = "wget -qO- https://ipecho.net/plain ; echo";
    shizuki = "adb shll sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh";
    save-kde-session = "qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.saveCurrentSession";
    locate = "plocate";
  };
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";
    XCURSOR_THEME = "breeze_cursors";
    QT_QPA_PLATFORM = "wayland-egl;wayland;xcb";
    DXVK_ASYNC = "1";
  };

  programs.command-not-found.enable = false;
  programs.zsh.enable = true;
  programs.corectrl.enable = true;
  programs.thefuck.enable = true;
  imports = [
    # Include the results of the hardware scan.
    (import "${home-manager}/nixos")
    ./hardware-configuration.nix
./zsh.nix
    #    inputs.nixos-hardware.nixosModules.common-cpu-amd
    #    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    #    inputs.nixos-hardware.nixosModules.common-gpu-amd
    #    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    #    inputs.nixos-hardware.nixosModules.common-pc
    #    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  nix.settings.experimental-features = ["nix-command" "flakes" "ca-derivations" "auto-allocate-uids"];
  nix.channel.enable = true;
  nix.gc.automatic = true;
  # Bootloader.

  networking.hostId = "7bd45fef";
  ##  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.enable = true;
  #boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.kernel.sysctl = {
    # Enable Magic keys
    "kernel.sysrq" = 1;
    # Reduce swap preference
    "vm.swappiness" = 10;
  };
  #boot.loader.grub.devices = [ "/dev/nvme0n1" ];
  boot.bootspec.enable = true;
  boot.plymouth.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "dominix-surfacepro7"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.packagekit.enable = true;
  services.mullvad-vpn.enable = true;

  services.logrotate.enable = true;
  services.avahi.enable = true;
  services.avahi.hostName = "dominix-surfacepro7";
  services.acpid.enable = true;
  services.cpupower-gui.enable = true;
  services.accounts-daemon.enable = true;
  services.upower.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = false;
  services.xserver.displayManager.sddm.wayland.enable = true;
  #  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  xdg.sounds.enable = true;
  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  #   hardware.openrgb = {
  #      enable = true;
  #      motherboard = "amd";
  #      package = pkgs.openrgb-with-all-plugins;
  #    };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.domglusk = {
    isNormalUser = true;
    description = "Dominic Gluskin";
    extraGroups = [
      "nixusers"
      "tty"
      "rtkit"
      "lp"
      "polkituser"
      "surface-control"
      "syncthing"
      "networkmanager"
      "wheel"
      "plugdev"
      "video"
      "render"
      "sddm"
      "autologin"
      "plocate"
      "adm"
      "trusted"
      "cachix"
    ];
    packages = with pkgs; [
      #  thunderbird
      wallpaper-engine-kde-plugin
    ];
  };
  security.sudo = {
    wheelNeedsPassword = false;
    extraConfig = ''
      Defaults env_keep = "LANG LC_ADDRESS LC_CTYPE LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE LC_TIME LC_ALL LANGUAGE LINGUAS XDG_SESSION_DESKTOP XDG_SESSION_TYPE TERM XDG_SESSION_COOKIE XMODIFIERS GTK_IM_MODULE QT_IM_MODULE QT_IM_SWITCHER WAYLAND_DISPLAY DISPLAY XCURSOR_THEME XDG_DATA_DIR KDE_FULL_SESSION XAUTHORITY XDG_RUNTIME_DIR KDE_SESSION_VERSION DESKTOP_SESSION XDG_SESSION_DESKTOP XDG_SESSION_TYPE LS_COLORS WINDOW_MANAGER"
    '';
  };
  services.gpm.enable = true;
  programs.xwayland.enable = true;
  programs.adb.enable = true;
  programs.vim.defaultEditor = true;
  programs.feedbackd.enable = true;
  programs.autojump.enable = true;
  programs.nix-ld.enable = true;
  programs.light.enable = true;
  programs.fish.useBabelfish = true;
  programs.fish.enable = true;
  programs.ccache.enable = true;
  programs.git.enable = true;
  programs.yazi.enable = true;
  programs.htop.enable = true;
  programs.fzf.fuzzyCompletion = true;
  programs.firefox.enable = true;
  programs.gamemode.enable = true;
  programs.dconf.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "domglusk";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.kdeconnect.enable = true;
  security.pam.services.domglusk.enableKwallet = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowBroken = true;
  environment = {
    pathsToLink = ["/share/zsh"];
    systemPackages = with pkgs; [
      bc
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.hydro
      fzf
      fishPlugins.grc
      grc
      bandwhich
      bottom
      btop
      catimg
      coreutils
      curl
      du-dust
      duf
      applet-window-title
      blurredwallpaper
      input-leap_git
      editorconfig-core-c
      fd
      findutils
      file
      hyperfine
      imv
      joshuto
      jq
      killall
      lm_sensors
      topgrade
      yadm
      nixd
      rnix-lsp
      kak-lsp
      shellspec
      lightly-boehs
      eza
      lz4
      man-pages
      man-pages-posix
      mpc_cli
      mpg123
      neofetch
      pciutils
      perl
      procs
      psmisc
      p7zip
      ranger
      ripgrep
      rsync
      sd
      trash-cli
      tree
      unrar
      unzip
      util-linux
      wget
      xarchiver
      zip
      yt-dlp
      alacritty
      any-nix-shell
      flavours
      blanket
      cod
      deadnix
      iay
      kate
      kcolorchooser
      manix
      mousai
      nix-init
      nix-output-monitor
      nix-tree
      open-interpreter
      openssl
      wget
      bat
      coreutils-full
      curl
      shellcheck
      plocate
      powerline
      libratbag
      font-awesome
      starship
      vim_configurable
      kate
      dolphin
      fish
      file
      fzy
      gnumake
      nsh
      complgen
      zsh-abbr
      fzf
      firefox
      intel-gpu-tools
      php83Packages.composer
      spacevim
      papirus-icon-theme
      go
      luarocks
      julia
      helix

      gcc
      wl-clipboard
      tree-sitter
      nil
      git
      gh
      libsForQt5.qt5.qtbase
      libsForQt5.qt5.qtx11extras
      discover
      backlight-auto
      themechanger
      subversion
      adw-gtk3
      zinit
      oh-my-posh
      nerdfonts
      paper-gtk-theme
      themechanger
      haskellPackages.highlighting-kate
      cargo
      kate
      libportal-gtk4
      surface-control
      syncthing
      syncthing-relay
      syncthing-discovery
      git
      cmake
      extra-cmake-modules
      mpv
      vulkan-headers
      vulkan-tools
      vulkan-loader
      lz4
      atuin
      cod
      pyenv
      thefuck
      cpupower-gui
      powerstat
      android-tools
      android-file-transfer
      scrcpy
      p7zip
      rar
      ncurses
      vector
      unzip
      ffmpeg
      ffmpegthumbnailer
      libopus
      mediainfo
      mpv
      fzf
      fx
      ripgrep
      direnv
      nix-direnv
      nixfmt
      nixos-option
      python311Full
      vlc
      sshpass
      ark
      nodePackages.npm
      filelight
      kate
      kcalc
      kdiff3
      qt6.qttools
      hw-probe
      gparted
      ntfs3g
      delta
      asunder
      duf
      fd
      jq
      figlet
      inotify-tools
      stow
      navi
      mullvad
      kleopatra
      tldr
      less
      lsd
      parallel-full
      tree
      pmutils
      psmisc
      nixops_unstable
      pfetch
      neovim
      xdg-launch
      xdg-utils
      glxinfo
      lm_sensors
      ueberzugpp
      libstdcxx5
      llvmPackages.libstdcxxClang
      pipx
      lazygit
      bottom
      ripgrep
      usbutils
      nix-software-center
      alejandra
      lshw
      glxinfo
      libsForQt5.packagekit-qt
      libsForQt5.kaccounts-providers
      retroarchFull
      libsForQt5.kdecoration
      qt6.qtlanguageserver
      rune-languageserver
      lua-language-server
      dot-language-server
      java-language-server
      yaml-language-server
      cmake-language-server
      kotlin-language-server
      haskell-language-server
      rPackages.languageserver
      arduino-language-server
      fortran-language-server
      ansible-language-server
      bitbake-language-server
      buf-language-server
      zls
      nls
      ccls
      dart
      svls
      scry
      nixd
      sqls
      codeium
      qt6.qtwebsockets
      libsForQt5.kdesu
      vscodium-fhs
      vimPlugins.lazy-nvim
      vimPlugins.lazy-lsp-nvim
      vimPlugins.LazyVim
      python311Packages.pynvim
      waynergy
      sbclPackages.vectors
      ncurses
      tmuxPlugins.online-status
      tmuxPlugins.power-theme
      tmuxPlugins.onedark-theme
      tmuxPlugins.mode-indicator
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.continuum
      conky
      zinit
      nmap-formatter
      foot
      alacritty
      qogir-kde
      sweet-nova
      syncthingtray
      plasma-browser-integration
      kwallet-pam
      kwalletmanager
      krunner-ssh
      kmail
      termusic
      kio-admin
      breeze-plymouth
      akonadi
      luna-icons
      nerdfix
      weather-icons
      nixos-icons
      zafiro-icons
      material-icons
      unidings
      line-awesome
      pacvim
      neovide
      efm-langserver
    ];
    shells = [pkgs.bashInteractive pkgs.zsh];
  };
  programs.nix-index.enable = true;
  programs.nix-index.enableZshIntegration = true;
  programs.nix-index.enableBashIntegration = false;
  #   programs.tmux = {
  #     enable = true;
  #     extraConfig = ''
  #           set -g @plugin 'jaclu/tmux-menus'
  #           set -g @plugin 'trevarj/tmux-open-nvim'
  #       #    set -g @plugin '2kabhishek/tmux2k'
  #           set -g @plugin 'tmux-plugins/tmux-sidebar'
  #           set -g @treemux-tree-nvim-init-file '~/.tmux/plugins/treemux/configs/treemux_init.lua'
  #           set -g @plugin 'kiyoon/treemux'
  #           set -g @plugin 'tmux-plugins/tmux-yank'
  #           set -g @yank_selection_mouse 'clipboard' # or 'primary' or 'secondary'
  #           set -g @shell_mode 'vi'
  #           set -g @plugin 'jaclu/tmux-mouse-swipe'
  #           set -g @plugin 'lljbash/tmux-update-display'
  #           set -g @plugin '27medkamal/tmux-session-wizard'
  #           set -g @plugin Freed-Wu/tmux-digit
  #           set -g @plugin 'MunifTanjim/tmux-mode-indicator'
  #           set -g @override_copy_command 'wl-copy'
  #           set -g @plugin 'catppuccin/tmux'
  #
  #           # Tmux 2K default configs
  #           # available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, network, network-bandwidth, network-ping, weather, time
  #           #set -g @tmux2k-left-plugins "git cpu-usage ram-usage"
  #           #set -g @tmux2k-right-plugins "battery network time"
  #           #set -g @tmux2k-show-powerline true
  #           #set -g @tmux2k-show-fahrenheit true
  #           #set -g @tmux2k-military-time false
  #           #set -g @tmux2k-border-contrast true
  #           ##set -g status-right {tmux_mode_indicator}'
  #
  #           #set -g @tmux2k-cpu-usage-colors "blue dark_gray"
  #
  #           # it can accept `session`, `rocket`, `window`, or any character.
  #           #set -g @tmux2k-show-left-icon "window"
  #
  #           # network interface to monitor
  #           ##set -g @tmux2k-network-name "en0"/"wlo1" (Mac/Linux)
  #
  #           # update powerline symbols
  #           #set -g @tmux2k-show-left-sep ""
  #           #set -g @tmux2k-show-right-sep ""
  #
  #           # change refresh rate
  #           set -g @tmux2k-refresh-rate 5
  #           set -g @plugin '2kabhishek/tmux-tilit'
  #           run '~/.tmux/plugins/tpm/tpm'
  #
  #     '';
  #   };
  stylix = {
    image = "/home/domglusk/etc/nixos/catppuccin.jpg";
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";
    targets = {
      console.enable = true;
      fish.enable = false;
      kmscon.enable = true;
    };
  };
  # zsh
  # programs.zsh.enable = true;
  #   programs.zsh.ohMyZsh.theme = "pygmalion-virtualenv";
  #   programs.zsh.setOptions = [
  # "COMPLETE_ALIASES"
  # "COMPLETE_IN_WORD"
  # "HASH_LIST_ALL"
  # "GLOBAL_EXPORT"
  #   "HIST_IGNORE_DUPS"
  #   "SHARE_HISTORY"
  #   "HIST_FCNTL_LOCK"
  # "HIST_EXPIRE_DUPS_FIRST"
  # "INC_APPEND_HISTORY"
  # ];
  #   programs.zsh.vteIntegration = true;
  #   programs.zsh.enableBashCompletion = true;
  #   programs.zsh.zsh-autoenv.enable = true;
  #   programs.zsh.enableCompletion = true;
  # #   programs.zsh.autosuggestions.strategy = [
  # #  "match_prev_cmd"
  # #  "completion"
  # #  "history"
  # # ];
  # #   programs.zsh.autosuggestions.extraConfig = {
  # #   "ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE" = "20";
  # # };
  # #   programs.zsh.autosuggestions.async = true;
  # #   programs.zsh.autosuggestions.enable = true;
  # #   programs.zsh.syntaxHighlighting.enable = false;
  # #   programs.zsh.syntaxHighlighting.styles = {
  # #  "command" = "blue";
  # # };
  #   programs.zsh.interactiveShellInit = ''
  #   '';
  # Make user colour green in prompt instead of default blue
  users.extraUsers.domglusk = {
    # ...
    shell = pkgs.zsh;
  };
  environment.etc.zshrc.enable = false;
  programs.steam.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        set number
        set cc=80
        set list
        set scrolloff 5
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {start = [ctrlp];};
    };
    withRuby = true;
    withPython3 = true;
  };
  programs.java.enable = true;
  nixpkgs.overlays = [
    (_final: prev: {
      steam = prev.steam.override ({extraPkgs ? _pkgs': [], ...}: {
        extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [libgdiplus]);
      });
    })
  ];
  # List services that you want to enable:
  fonts.fontDir.enable = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Syncthing
  services = {
    syncthing = {
      enable = true;
      user = "domglusk";
      dataDir = "/home/domglusk/Sync"; # Default folder for new synced folders
      configDir = "/home/domglusk/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };
  # Power
  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "auto";
    };
    charger = {
      governor = "ondemand";
      turbo = "auto";
    };
  };
  # services.tlp = {
  #       enable = true;
  #       settings = {
  #         CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #         CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #
  #         CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #         CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
  #
  #         CPU_MIN_PERF_ON_AC = 0;
  #         CPU_MAX_PERF_ON_AC = 100;
  #         CPU_MIN_PERF_ON_BAT = 0;
  #         CPU_MAX_PERF_ON_BAT = 20;
  #       };
  # };
  #  nixpkgs.config.packageOverrides = pkgs: {
  #    nur = import (builtins.fetchTarball
  #"https://github.com/nix-community/NUR/archive/master.tar.gz") {
  #      inherit pkgs;
  #    };
  #  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  services.flatpak.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  console = {
    font = "ter-powerline-v24b";
    packages = [pkgs.terminus_font pkgs.powerline-fonts];
    useXkbConfig = true;
  };
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };
  nix.optimise.automatic = true;
  nix.optimise.dates = ["03:45"];
  services.kmscon = {
    enable = true;
    autologinUser = "domglusk";
    hwRender = true;
    extraOptions = "--term xterm-256color";
    extraConfig = "font-size=14";
    fonts = [
      {
        name = "MesloLGS Nerd Font Mono";
        package = pkgs.nerdfonts;
      }
    ];
  };
  location.provider = "geoclue2";
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
  services = {
    journald.extraConfig = ''
      SystemMaxUse=500M
    '';
    timesyncd.enable = lib.mkDefault true;
  };
  systemd.oomd.enable = false;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    #    nixos-channels = [
    #    "https://nixos.org/channels/nixos-unstable nixos"
    #    "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware"
    #];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.domglusk = {pkgs, ...}: {
    home.packages = [pkgs.atool pkgs.httpie];
    programs.bash.enable = true;
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.05";
  };
  appstream.enable = true;
  qt.enable = true;
  qt.platformTheme = "kde";
  qt.style = "breeze";
}
