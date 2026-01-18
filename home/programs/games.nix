{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (prismlauncher.override {
        jdks = with pkgs.javaPackages.compiler; [
            openjdk8
            openjdk17
            openjdk21
            openjdk25
        ];
    })
    bottles
    osu-lazer-bin
    # (pkgs.callPackage ../../pkgs/etterna/package.nix {})
    etterna 
    mangohud
  ];
}
