{ config, pkgs, ... }:

let 
  b = pkgs.callPackage ./src/b {};
  pkgs = import <nixpkgs> {};
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
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jacky";
  home.homeDirectory = "/home/jacky";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.git
    pkgs.ripgrep
    pkgs.tree
    pkgs.jq
    pkgs.fzf    # everything
    pkgs.rnix-lsp # lsp support of nix
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
        nix-develop-nvim
        rust-vim
        vim-toml

        # UI
        vim-gitgutter   # status in gitter
        vim-airline     # vim-devicons
        
        ## colocscheme
        gruvbox
      ];
      extraConfig = builtins.readFile ./vimAndNeovim/vimExtraConfig;
      coc = {
        enable = true;
        settings = {
          languageserver = {
            nix = {
              command = "rnix-lsp";
              filetypes = [ "nix" ];
            };
          };
        };
      };
    };
  };

  programs.bat = {
    enable = true;
    config = {
      # theme = "ansi-dark";
      theme = "base16-256";
    };
  };
}
