{ config, pkgs, ... }:

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
  home.shellAliases = {
    hwc = "vim ~/.config/nixpkgs/home.nix";
    hws = "home-manager switch";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.htop
  ];

  # config: vim and neovim
  programs = {
    vim = {
      enable = true;
      plugins = [ 
        pkgs.vimPlugins.vim-nix
      ];
      # plugins = [
      #   <derivation vimplugin-vim-nix-2022-04-25>
      # ];
      settings = {
        number = true;
        expandtab = true;
        copyindent = true;
        relativenumber = true;

        shiftwidth = 2;
        tabstop = 2;
      };
      extraConfig = ''
        syntax on
        set wrap
        set smartindent
      '';
    };
    neovim = {
      enable = true;
      extraConfig = ''
        syntax on
        set wrap
        set smartindent
        set number
        set relativenumber
        set expandtab

        set tabstop=2
        set shiftwidth=2
      '';
    };
  };

}
