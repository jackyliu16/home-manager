{ pkgs, lib, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/pta2002/nixvim";
  });
in
{
  imports = [
    # For home-manager
    nixvim.homeManagerModules.nixvim
    # For NixOS nixvim.nixosModules.nixvim
    # For nix-darwin nixvim.nixDarwinModules.nixvim
    ./colorscheme.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    options = {
      mouse = "a";
      spelllang = "en_us";
      clipboard = "unnamedplus";

      wrap = true;
      smartindent = true;

      number = true;
      relativenumber = true;
      expandtab = true;
      copyindent = true;

      shiftwidth = 2;
      tabstop = 2;

      background = "dark";
    };

    extraPlugins = with pkgs.vimPlugins; [
      # (vim-wakatime.overrideAttrs (old: {
      #   patchPhase = ''
      #     # Move the BufEnter hook from the InitAndHandleActivity call
      #     # to the common HandleActivity call. This is necessary because
      #     # InitAndHandleActivity prompts the user for an API key if
      #     # one is not found, which breaks the remote plugin manifest
      #     # generation.
      #     substituteInPlace plugin/wakatime.vim \
      #       --replace 'autocmd BufEnter,VimEnter' \
      #                 'autocmd VimEnter' \
      #       --replace 'autocmd CursorMoved,CursorMovedI' \
      #                 'autocmd CursorMoved,CursorMovedI,BufEnter'
      #     '';
      # }))
      # language support
      vim-lsp
      # # asyncomplete-vim
      # # jedi-vim
      vim-nix
      rust-vim
      vim-toml
      # YouCompleteMe   # 自动补全

      # UI
      vim-gitgutter   # status in gitter
      vim-airline     # vim-devicons
      (nvim-treesitter.withPlugins (p: [ p.c p.java p.rust p.python p.go ]))
      vim-bufferline  # 标签页
      nvim-gdb
      
      ## colocscheme
      # gruvbox
      # vim-devicons    

      # Tools
      auto-pairs
      LeaderF         # 模糊查找
      nerdcommenter   # 多行注释支持
      Vundle-vim      # plug-in manager for Vim
      # lightline     # tabline customization
      vim-startify    # 最近打开的文件
      vim-fugitive    # Git Support

      # NERDTree
      nerdtree
      vim-nerdtree-tabs
      vim-nerdtree-syntax-highlight
      nerdtree-git-plugin
    ];
  };
}