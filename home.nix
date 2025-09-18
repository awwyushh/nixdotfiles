{ inputs, config, pkgs, nix4nvchad, ... }:

let
  myAliases = {
    cat     = "bat";   # modern cat
    ls      = "eza";   # modern ls
    cd      = "z";     # smarter cd
    grep    = "rg";    # ripgrep
    hupdate = "home-manager switch --flake ~/.dotfiles#ayush";
  };
in {
  # Allow unfree packages like Android Studio / SDK
  nixpkgs.config.allowUnfree = true;

  # User info
  home.username      = "ayush";
  home.homeDirectory = "/home/ayush";
  home.stateVersion  = "25.05"; # don't change lightly

  # Packages
  
  imports = [
    nix4nvchad.homeManagerModule
  ];
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      nodePackages.bash-language-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      emmet-language-server
      nixd
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        flake8
      ]))
      
    # Rust
    rust-analyzer
    cargo
    rustc
    clippy
    rustfmt

    # Elixir
    elixir
    elixir-ls
    erlang
    ];
    hm-activation = true;
    backup = true;
  };
  
  home.packages = with pkgs; [
    hello
    vscode
    gedit
    zsh-powerlevel10k
    pkgs.nerd-fonts.meslo-lg
    ripgrep
    tailscale
    # Android / Flutter dev
    android-studio
    #    androidsdk.platformTools   # adb, fastboot
    #    androidenv.platformTools
    #    androidenv.androidPkgs_9_0.platform-tools
    openjdk17
    flutter

    # hardware
    kicad
    
 
    # CLI tools
    bat
    eza
    zoxide
    fzf
    kitty 
 ];

  # Session variables
  home.sessionVariables = { };

  # Dotfiles
  home.file.".p10k.zsh".text = builtins.readFile ./p10k.zsh;

  # Shells
  programs.bash = {
    enable       = true;
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable       = true;
    shellAliases = myAliases;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent  = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  # Git
  programs.git = {
    enable    = true;
    userName  = "awwyushh";
    userEmail = "awwwyushh@gmail.com";
    aliases   = {
      co = "checkout";
      st = "status";
      cm = "commit -m";
      br = "branch";
      df = "diff";
      lg = "log --oneline --graph --decorate --all";
    };
  };

  # Bat
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
    };
  };

  # CLI enhancements
  programs.eza.enable = true;
  programs.zoxide = {
    enable              = true;
    enableZshIntegration = true;
  };
  programs.fzf = {
    enable              = true;
    enableZshIntegration = true;
  };

  # Kitty terminal
  programs.kitty = {
    enable = true;

    font = {
      package = pkgs.nerd-fonts.meslo-lg;
      name = "MesloLGS Nerd Font";
      size = 13;
    };

    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      background_opacity = "0.90";
      dynamic_background_opacity = "yes";

      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";

      url_color = "#89B4FA";
      cursor = "#F5E0DC";

      color0  = "#45475A";
      color8  = "#585B70";
      color1  = "#F38BA8";
      color9  = "#F38BA8";
      color2  = "#A6E3A1";
      color10 = "#A6E3A1";
      color3  = "#F9E2AF";
      color11 = "#F9E2AF";
      color4  = "#89B4FA";
      color12 = "#89B4FA";
      color5  = "#F5C2E7";
      color13 = "#F5C2E7";
      color6  = "#94E2D5";
      color14 = "#94E2D5";
      color7  = "#BAC2DE";
      color15 = "#A6ADC8";
    };
  };

  # Home Manager
  programs.home-manager.enable = true;
} 
