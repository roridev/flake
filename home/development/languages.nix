{ config, pkgs, ... }:

{
  imports = [ ./lang/rust.nix ./lang/typst.nix ];

  home.packages = with pkgs; [
    # Rust
    rustup
    # gcc
    cargo-bloat
    cargo-deny
    cargo-machete
    # Java
    jdk21
    # devenv
    # haskellPackages.ghcup
  ];
}
