let 
  pkgs = import <nixpkgs> {};
in
  pkgs.runCommand "ls-colors" {} ''
    mkdir -p $out/bin $out/share
    ln -s ${pkgs.coreutils}/bin/ls          $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors   $out/bin/dircolors
    cp ${./LS_COLORS} $out/share/LS_COLORS
  ''
