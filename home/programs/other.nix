{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
    # tmux
    keepassxc
    zathura
    sublime-merge
    vscode
#    typst
    gimp3-with-plugins
    qbittorrent
#    obsidian  
    libreoffice
    easyeffects
#    aegisub
#    obs-studio
    nss
#    anvil-editor
#    zed-editor
    nh
    nixfmt-rfc-style
#    quodlibet
    bespokesynth
    nicotine-plus
    inkscape
	krita
	anki
];
  fonts.fontconfig.enable = true;
}
