{ pkgs
, lib
, config
, specialArgs
, modulesPath
, options
}: 

# ref: https://github.dev/Smaug123/nix-dotfiles
{
  #home.packages = with pkgs; [
  #  pure-prompt
  #];

  programs.fish.enable = false;
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" "macos" "dircycle" "timer" "sudo" "web-search" "dirhistory" "jsontools" "history" 
        "copydir" "copyfile" "copybuffer"
      ];
      theme = "robbyrussell";
    };
    sessionVariables = {
      EDITOR = "vim";
      LC_ALL = "zh_CN.UTF-8";
      LC_CTYPE = "zh_CN.UTF-8";
      RUSTFLAGS = "-L ${pkgs.libiconv}/lib -L ${pkgs.libcxxabi}/lib -L ${pkgs.libcxx}/lib";
      RUST_BACKTRACE = "full";
      http_proxy = "127.0.0.1:7890";
      https_proxy = "127.0.0.1:7890";
    };
    shellAliases = {
      view = "vim -R";
      nix-upgrade = "sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'";
      hns="home-manager switch";
      send="curl -F 'c=@-' 'https://fars.ee'";
      chw="cd ~/.config/home-manager/";
      cos="cd ~/.config/NixOS-Config/";
      blog="cd ~/Documents/blog/";
    };
    localVariables = {
      TERM="xterm-256color";
    };
    plugins = [
      # using this it's not easy to compare the different nix-shell
      # {
      #   name = "zsh-nix-shell";
      #   file = "nix-shell.plugin.zsh";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "chisui";
      #     repo = "zsh-nix-shell";
      #     rev = "v0.5.0";
      #     sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
      #   };
      # }
    ];
    initExtra = ''
      # Enable Nix
      # . /home/jacky/.nix-profile/etc/profile.d/nix.sh
      # Enable Mvn
      # export NVM_DIR="$HOME/.nvm"
      # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
      export NIXPKGS_ALLOW_UNFREE=1
      any-nix-shell zsh --info-right | source /dev/stdin

      eval "$(direnv hook zsh)" # Direnv hooks
    '';
    # initExtra = ''
    #   # setopt no_nomatch # Compatible bash wildcard
    #   unsetopt correct  # Disable AutoCorrect

    #   # Promt themes
    #   # autoload -U promptinit; promptinit
    #   # PURE_PROMPT_SYMBOL=›
    #   # PURE_PROMPT_VICMD_SYMBOL=‹
    #   # prompt pure
    #   # source minimal.zsh
    #   source ${./oxide.zsh-theme}

    #   # Compatibility bash completion
    #   # autoload -U bashcompinit && bashcompinit
    #   # source ${../overlays/nixos-helper/ns.bash}

    #   # allow using nix-shell with zsh
    #   ${lib.getExe pkgs.any-nix-shell} zsh --info-right | source /dev/stdin

    #   # Completions
    #   zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive tab completion
    #   zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}" # Colored completion (different colors for dirs/files/etc)
    #   zstyle ':completion:*' menu select                        # Hit 'TAB' to select

    #   # Color man pages
    #   export LESS_TERMCAP_mb=$'\E[01;32m'
    #   export LESS_TERMCAP_md=$'\E[01;32m'
    #   export LESS_TERMCAP_me=$'\E[0m'
    #   export LESS_TERMCAP_se=$'\E[0m'
    #   export LESS_TERMCAP_so=$'\E[01;47;34m'
    #   export LESS_TERMCAP_ue=$'\E[0m'
    #   export LESS_TERMCAP_us=$'\E[01;36m'
    #   export LESS=-R

    #   # Bash-like navigation between words
    #   autoload -U select-word-style
    #   select-word-style bash

    #   # Keybindings
    #   bindkey -e                               # Emacs keybinding
    #   bindkey  "^[[3~"  delete-char            # Del key
    #   bindkey  "^[[H"   beginning-of-line      # Home key
    #   bindkey  "^[[F"   end-of-line            # End key
    #   bindkey '^[[5~' history-beginning-search-backward # Page up key
    #   bindkey '^[[6~' history-beginning-search-forward  # Page down key
    #   bindkey "\e[27;2;13~" accept-line        # Shift - enter
    #   bindkey "\e[27;5;13~" accept-line        # Ctrl - enter
    #   bindkey '^H' backward-kill-word          # Ctrl - backspace
    #   bindkey "^[[1;5C" forward-word           # Ctrl - ->
    #   bindkey "^[[1;5D" backward-word          # Ctrl - <-
    #   bindkey "^[[1;3C" forward-word           # Alt - ->
    #   bindkey "^[[1;3D" backward-word          # Alt - <-
    # '';
  };
}

