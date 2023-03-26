{
  programs.nixvim.plugins.startify = {
    enable = true;
    filesNumber = 5;
    bookmarks = [
      { c="~/.config/nixpkgs/"; }
      { ch= "~/.config/nixpkgs/home.nix"; }
    ];
    changeToDir = true;
    changeToVcsRoot = true; # When opening a file or bookmark, change to the root directory of the VCS
    sessionAutoload = true;
# https://www.ascii-art-generator.org/
    customHeader = [
"    ____  _     _  __   __            ____  _             _         _   _               _   _____         _            ___  "
"   |  _ \\(_) __| | \\ \\ / /__  _   _  / ___|| |_ _   _  __| |_   _  | | | | __ _ _ __ __| | |_   _|__   __| | __ _ _   |__ \\ "
"   | | | | |/ _` |  \\ V / _ \\| | | | \\___ \\| __| | | |/ _` | | | | | |_| |/ _` | '__/ _` |   | |/ _ \\ / _` |/ _` | | | |/ / "
"   | |_| | | (_| |   | | (_) | |_| |  ___) | |_| |_| | (_| | |_| | |  _  | (_| | | | (_| |   | | (_) | (_| | (_| | |_| |_|  "
"   |____/|_|\\__,_|   |_|\\___/ \\__,_| |____/ \\__|\\__,_|\\__,_|\\__, | |_| |_|\\__,_|_|  \\__,_|   |_|\\___/ \\__,_|\\__,_|\\__, (_)  "
"                                                            |___/                                                 |___/     " 
    ];
  };         # 新标签页
}
