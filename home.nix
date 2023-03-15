{ config, pkgs, ... }:

let 
  # shell color: diff typr of file will have diff color
  # b = pkgs.callPackage ./src/b {};
  LS_COLORS = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    rev = "09dab448207002624d17f01ed7cbf820aa048063";
    sha256 = "sha256-hQTT/yNS9UIDZqHuul0xmknnOh6tOtfotQIm0SY5TTE=";
  };
  ls-colors = pkgs.runCommand "ls-colors" { } ''
    mkdir -p $out/bin $out/share
    ln -s ${pkgs.coreutils}/bin/ls          $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors   $out/bin/dircolors
    cp ${LS_COLORS}/LS_COLORS               $out/share/LS_COLORS
  '';
  minidev = pkgs.callPackage ./src/minidev {};
  user = "jacky";
  my-python-packages = p: with p; [
    pandas
    matplotlib
    pylint
    rarfile
  ];
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "22.11";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    src/zsh.nix
  ];

  home.packages = [
    # Basical 
    pkgs.git
    pkgs.ripgrep    # search the content of the file in a directory
    pkgs.tmux       # terminal split screen
    pkgs.tree       # show the directory structure as a tree
    pkgs.jq         # ?
    pkgs.fzf        # everything
    pkgs.rnix-lsp   # lsp support of nix
    pkgs.htop       # colorful top
    pkgs.ranger     # file management

    # Coding 
    pkgs.gnumake
    pkgs.clang
    (pkgs.python310.withPackages my-python-packages)
    # pkgs.python3

    # Personal
    ls-colors
    minidev
  ];

  # config: vim and neovim
  programs = {
    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ 
        # language support
        vim-nix
        rust-vim
        vim-toml

        # UI
        vim-gitgutter   # status in gitter
        vim-airline     # vim-devicons
        
        ## colocscheme
        gruvbox
      ];
      extraConfig = builtins.readFile ./vimAndNeovim/vimExtraConfig;
    };
    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ 
        # language support
        vim-nix
        rust-vim
        vim-toml

        # UI
        vim-gitgutter   # status in gitter
        vim-airline     # vim-devicons
        
        ## colocscheme
        gruvbox
      ];
      extraConfig = builtins.readFile ./vimAndNeovim/vimExtraConfig;
      # coc = {
      #   enable = true;
      #   # settings = {
      #   #   languageserver = {
      #   #     nix = {
      #   #       command = "rnix-lsp";
      #   #       filetypes = [ "nix" ];
      #   #     };
      #   #   };
      #   # };
      # };
    };
  };


  # terminal 
  programs = {
    bat = {
      enable = true;
      config = {
        # theme = "ansi-dark";
        theme = "base16-256";
      };
    };
  };
}
