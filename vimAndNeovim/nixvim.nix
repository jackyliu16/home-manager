{ pkgs
, config
, lib
, ... }:
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
    # ./lightline.nix
    # ./airline.nix
    # ./lang.nix
    # ./autocomplete.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    maps = {
      normal = {
        # using for Neo-Tree
        "<C-e>" = ":NvimTreeToggle<CR>";
        # "<C-e>" = ":Neotree<CR>";
        # using for Bufferline
        "<C-h>" = ":BufferLineCyclePrev<CR>";
        "<C-l>" = ":BufferLineCycleNext<CR>";     # move to prev, next buffer
        "<C-w>" = ":bdelete %";                   # delete current buffer
        # Terminal(floaterm)
        "<A-1>" = ":FloatermNew --with-type=split --height=0.4<CR>";
        "<A-2>" = ":FloatermNew --with-type=vsplit --width=0.4<CR>";
        "<A-3>" = ":FloatermNew<CR>";
        "<C-j>" = ":FloatermShow<CR>";
        # Leader Operation
        mapleader = "<Space>";
        "<leader>1" = { action = ":BufferLineGoToBuffer 1<CR>"; silent = true; };
        "<leader>2" = { action = ":BufferLineGoToBuffer 2<CR>"; silent = true; };
        "<leader>3" = { action = ":BufferLineGoToBuffer 3<CR>"; silent = true; };
        "<leader>4" = { action = ":BufferLineGoToBuffer 4<CR>"; silent = true; };
        "<leader>5" = { action = ":BufferLineGoToBuffer 5<CR>"; silent = true; };
        "<leader>bp"= { action = ":BufferLinePickClose<CR>"; silent = true; };
        "<leader>bdl"= { action = ":BufferLineCloseLeft<CR>"; silent = true; };
        "<leader>bdr"= { action = ":BufferLineCloseRight<CR>"; silent = true; };
      };
      insert = {
        "jk" = "<ESC>";
      };
      terminal = {
        # floaterm
        "<C-j>" = "<C-\\><C-n>:FloatermHide<CR>";
        "<C-w>" = "<C-\\><C-n>:FloatermKill<CR>";
      };
    };

    plugins = {
      markdown-preview.enable = true;
      telescope = {
        enable = true;
        # keymaps = {
        #   "<leader>ff" = "find_files";    # Find File
        #   "<leader>gg" = "live_grep";     # find words 
        #   "<leader>fm" = "marks";         
        #   "<leader>fj" = "jumplist";        
        #   "<leader>fh" = "oldfiles";      # Recently opened files 
        #   "<leader>fb" = "file_browser";  # File Browser  
        # };
      };
      # neo-tree.enable = true;
      treesitter = {
        enable = true;
        indent = true;
        ensureInstalled = [ "rust" "python" "c" "cpp" "toml" "nix" "go" "java" ];
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          c
          go
          cpp
          nix
          bash
          html
          help
          latex
          python
          rust
        ];
      };
      startify.enable = true;         # 新标签页
      # floaterm = {
      #   enable = true;
      #   width = 0.8;
      #   height = 0.8;
      # };
      nvim-tree = {
        enable = true;
        filters = {
          dotfiles = false;
          exclude = [                 # include in nvim-tree
            ".gitignore"
          ];
          custom = [                  # exclude in nvim-tree
            "^\\.git"
          ];
        };    
      };
      lualine.enable = true;
      bufferline = {
        enable = true;
        diagnostics = "nvim_lsp";
        numbers = "ordinal";
      };  
    };
    
    options = {
      mouse = "a";
      spelllang = "en_us";
      clipboard = "unnamedplus";

      wrap = true;
      syntax = "enable";
      number = true;
      relativenumber = true;
      expandtab = true;
      autoindent = true;
      copyindent = true;
      smartindent = true;

      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;

      background = "dark";
      encoding = "utf-8";
      termencoding = "utf-8";
      fileencoding = "chinese";
      fileencodings = [
        "utf-8"
        "chinese"
      ];
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
      # vim-lsp
      # # asyncomplete-vim
      # # jedi-vim
      # vim-nix
      # rust-vim
      # vim-toml
      # YouCompleteMe   # 自动补全

      # UI
      vim-gitgutter     # status in gitter
      # vim-airline     # vim-devicons
      # (nvim-treesitter.withPlugins (p: [ p.c p.cpp p.java p.rust p.python p.go p.toml ]))
      # vim-bufferline  # 标签页
      # nvim-gdb
      
      # vim-devicons    

      # Tools
      auto-pairs
      LeaderF         # 模糊查找
      # nerdcommenter   # 多行注释支持
      # Vundle-vim      # plug-in manager for Vim
      # lightline     # tabline customization
      vim-fugitive    # Git Support

      which-key-nvim
    ];
    extraConfigVim = ''
      autocmd TermOpen * setlocal nonumber norelativenumber
    '';
  };
}
