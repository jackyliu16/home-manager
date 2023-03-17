{ pkgs, lib, ... }:

let 
  nixvim = import (builtins.fetchGit {
    url = "git@github.com:pta2002/nixvim.git";
  });
in
{
  imports = [
    # for home-manager 
    nixvim.homeManagerModules.nixvim
    # for NixOS
    # nixvim.nixosModules.nixvim
    # for nix-darwin
    # nixvim.nixDarwinModules.nixvim

    (../vimAndNeovim/conf/barbar.nix)
    (../vimAndNeovim/conf/colorizer.nix)
    (../vimAndNeovim/conf/colorscheme.nix)
    (../vimAndNeovim/conf/comment.nix)
    (../vimAndNeovim/conf/copilot.nix)
    (../vimAndNeovim/conf/gitsigns.nix)
    (../vimAndNeovim/conf/lspsaga.nix)
    (../vimAndNeovim/conf/telescope.nix)
    (../vimAndNeovim/conf/treesitter.nix)
    (../vimAndNeovim/conf/trouble.nix)
    # (../vimAndNeovim/conf/workspace.nix)
    (../vimAndNeovim/lang/python.nix)
    (../vimAndNeovim/lang/go.nix)
  ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    options = {
      # Mouse support
      mouse = "a";

      # Background
      background = "dark";

      # Enable filetype indentation
      #filetype plugin indent on

      termguicolors = true;

      # Line Numbers
      number = true;
      relativenumber = true;

      # Spellcheck
      spelllang = "en_us";

      # Use X clipboard
      clipboard = "unnamedplus";

      # Some defaults
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
  };
};
}
