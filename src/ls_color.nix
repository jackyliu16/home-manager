let 
  pkgs = import <nixpkgs> {};
  LS_COLORS = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    rev = "09dab448207002624d17f01ed7cbf820aa048063";
    sha256 = "sha256-hQTT/yNS9UIDZqHuul0xmknnOh6tOtfotQIm0SY5TTE=";
  };
  # LS_COLORS = pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/trapd00r/LS_COLORS/2baa6677b6d1491076059169d52b4021bd9be348/LS_COLORS";
  #   sha256 = "sha256-U9ivaC2JbZ5wOwZyQbbSa3AZxDsGguifqjho6lTmC+Y=";
  # };
in
  pkgs.runCommand "ls-colors" {} ''
    mkdir -p $out/bin $out/share
    ln -s ${pkgs.coreutils}/bin/ls          $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors   $out/bin/dircolors
    cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
  ''
