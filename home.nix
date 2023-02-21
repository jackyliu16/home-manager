{ config, pkgs, ... }:

let 
  b = pkgs.callPackage ./src/b {};
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

  home.packages = with pkgs; [
    minidev
    minidev
    git
    ripgrep
    tree
    jq
    bat
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
    };
  };

}
