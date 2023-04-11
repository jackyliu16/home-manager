{ pkgs
, config
, lib
, ... }:

let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/pta2002/nixvim";
    rev = "7f50b54bfb999671778f17192d75b8c23c6d75b9";
  });
  # nixvim = import (builtins.fetchGit {
  #   url = "https://github.com/pta2002/nixvim";
  # });
in
{
  imports = [
    # For home-manager
    nixvim.homeManagerModules.nixvim
    # For NixOS nixvim.nixosModules.nixvim
    # For nix-darwin nixvim.nixDarwinModules.nixvim
    ./colorscheme.nix
    ./status_bar.nix
    ./lang.nix
    ./terminal.nix
    ./autocomplete.nix
    ./file_explorers.nix
    ./highlight.nix
    ./startify.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    maps = {
      normal = {
        # using for Bufferline
        "<C-h>" = ":BufferLineCyclePrev<CR>";
        "<C-l>" = ":BufferLineCycleNext<CR>";     # move to prev, next buffer
        "<C-w>x" = ":bdelete %";                  # delete current buffer
        # Markdown-preview
        "<C-p>" = "<Plug>MarkdownPreviewToggle";
        # Fold
        "<Space>" = "za";
        # Leader Operation
        "<leader>1" = { action = ":BufferLineGoToBuffer 1<CR>"; silent = true; };
        "<leader>2" = { action = ":BufferLineGoToBuffer 2<CR>"; silent = true; };
        "<leader>3" = { action = ":BufferLineGoToBuffer 3<CR>"; silent = true; };
        "<leader>4" = { action = ":BufferLineGoToBuffer 4<CR>"; silent = true; };
        "<leader>5" = { action = ":BufferLineGoToBuffer 5<CR>"; silent = true; };
        "<leader>bp"= { action = ":BufferLinePickClose<CR>"; silent = true; };
        "<leader>bdl"= { action = ":BufferLineCloseLeft<CR>"; silent = true; };
        "<leader>bdr"= { action = ":BufferLineCloseRight<CR>"; silent = true; };
        "<f5>" = ":UndotreeToggle<CR>"; 
        # Windows
        "<M-Left>"  = { action = ":vertical res -5<CR>"; silent = true; };
        "<M-Right>" = { action = ":vertical res +5<CR>"; silent = true; };
        "<M-Up>"    = { action = ":res -5<CR>"; silent = true; };
        "<M-Down>"  = { action = ":res +5<CR>"; silent = true; };
      };
      insert = {
        "jk" = "<ESC>";
      };
    };

    plugins = {
      surround.enable = true;       # 括号操作
      nvim-autopairs.enable = true; # 括号补全
      comment-nvim = {
        enable = true;
        opleader = {line = "<C-m>";};
        toggler = {line = "<C-m>";};
      };
      commentary.enable = true;  # 代码注释
      undotree.enable = true;    # TODO list
      # code_runner 
      markdown-preview = {
        enable = true;
        autoClose = true;
      };
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
          # help
          latex
          python
          rust
        ];
      };
      # change in different buffer
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
      # smartindent = true;

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
      # splitbelow = true; # A new window is put below the current one
      # splitright = true; # A new window is put right of the current one

      swapfile = false; # Disable the swap file
      # modeline = true; # Tags such as 'vim:ft=sh'
      # modelines = 100; # Sets the type of modelines
      # undofile = true; # Automatically save and restore undo history
      incsearch = true; # Incremental search: show match for partly typed search command
      ignorecase = true; # When the search query is lower-case, match both lower and upper-case
      #   patterns
      # smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper
      # #   case characters
      # scrolloff = 8; # Number of screen lines to show around the cursor
      # cursorline = false; # Highlight the screen line of the cursor
      # cursorcolumn = false; # Highlight the screen column of the cursor
      # signcolumn = "yes"; # Whether to show the signcolumn
      # colorcolumn = "100"; # Columns to highlight
      # laststatus = 3; # When to use a status line for the last window
      # termguicolors = true; # Enables 24-bit RGB color in the |TUI|
      # spell = false; # Highlight spelling mistakes (local to window)

      # textwidth = 0; # Maximum width of text that is being inserted.  A longer line will be
      # #   broken after white space to get this width.

      # # Folding
      # foldlevel = 99; # Folds with a level higher than this number will be closed
    };

    extraPlugins = with pkgs.vimPlugins; [
      # vim-wakatime
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

      # UI
      vim-gitgutter     # status in gitter
      # nvim-gdb
      # vim-devicons    

      # Tools
      LeaderF         # 模糊查找
      # nerdcommenter   # 多行注释支持
      # Vundle-vim      # plug-in manager for Vim
      # lightline     # tabline customization
      vim-fugitive    # Git Support
      which-key-nvim
    ];
    extraConfigVim = ''
      autocmd TermOpen * setlocal nonumber norelativenumber
      " Leader
      let mapleader = ","
      let leader = ","
      
      " LeaderF https://retzzz.github.io/dc9af5aa/
      let g:Lf_WorkingDirectoryMode = 'AF'
      let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.project', '.root']
    '';
    extraConfigLua = ''
    '';
  };
}
