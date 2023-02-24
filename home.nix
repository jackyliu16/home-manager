{ config, pkgs, ... }:

let 
  # shell color: diff typr of file will have diff color
  b = pkgs.callPackage ./src/b {};
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
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
    pkgs.python3

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


  # terminal 
  programs = {
    bat = {
      enable = true;
      config = {
        # theme = "ansi-dark";
        theme = "base16-256";
      };
    };
    # Ref on https://github.com/cmacrae/config/blob/master/modules/macintosh.nix
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      sessionVariables = { RPROMPT = ""; };

      shellAliases = {
        hws="home-manager switch --flake . --option substituters 'https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store'";
      };

      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [
        "git"
        "git-prompt"
        "branch"
        "fzf"
      ];
      plugins = [
        {
          name = "k";
          file = "k.sh";
          src = pkgs.fetchFromGitHub {
            owner = "supercrabtree";
            repo = "k";
            rev = "e2bfbaf3b8ca92d6ffc4280211805ce4b8a8c19e";
            sha256 = "sha256-32rJjBzqS2e6w/L78KMNwQRg4E3sqqdAmb87XEhqbRQ=";
          };
        } 
        {
          name = "zsh-completions";
          file = "zsh-completions.plugin.zsh";
          src = pkgs.zsh-completions;
        }
        {
          name = "autopair";
          file = "autopair.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "hlissner";
            repo = "zsh-autopair";
            rev = "4039bf142ac6d264decc1eb7937a11b292e65e24";
            sha256 = "02pf87aiyglwwg7asm8mnbf9b2bcm82pyi1cj50yj74z4kwil6d1";
          };
        }
        {
          name = "fast-syntax-highlighting";
          file = "fast-syntax-highlighting.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zdharma";
            repo = "fast-syntax-highlighting";
            rev = "v1.28";
            sha256 = "106s7k9n7ssmgybh0kvdb8359f3rz60gfvxjxnxb4fg5gf1fs088";
          };
        }
        {
          name = "z";
          file = "zsh-z.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "agkozak";
            repo = "zsh-z";
            rev = "41439755cf06f35e8bee8dffe04f728384905077";
            sha256 = "1dzxbcif9q5m5zx3gvrhrfmkxspzf7b81k837gdb93c4aasgh6x6";
          };
        }
      ];

      initExtra = ''
          ZSH_THEME="robbyrussell"
          PROMPT='%{$fg_bold[blue]%}$(get_pwd)%{$reset_color%} $(git_super_status) ''${prompt_suffix}'
          local prompt_suffix="%(?:%{$fg_bold[green]%}❯ :%{$fg_bold[red]%}❯%{$reset_color%} "
          function get_pwd(){
              git_root=$PWD
              while [[ $git_root != / && ! -e $git_root/.git ]]; do
                  git_root=$git_root:h
              done
              if [[ $git_root = / ]]; then
                  unset git_root
                  prompt_short_dir=%~
              else
                  parent=''${git_root%\/*}
                  prompt_short_dir=''${PWD#$parent/}
              fi
              echo $prompt_short_dir
          }
          vterm_printf(){
              if [ -n "$TMUX" ]; then
                  # Tell tmux to pass the escape sequences through
                  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
                  printf "\ePtmux;\e\e]%s\007\e\\" "$1"
              elif [ "''${TERM%%-*}" = "screen" ]; then
                  # GNU screen (screen, screen-256color, screen-256color-bce)
                  printf "\eP\e]%s\007\e\\" "$1"
              else
                  printf "\e]%s\e\\" "$1"
              fi
        }
      '';
    };
  };
}
