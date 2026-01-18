{ pkgs, lib, outputs, ... }:

let username = "alikindsys";

in {

# Define a user account. 
users.users.alikindsys = {
  isNormalUser = true;
  description = "Alice Isabel";
  extraGroups = [ "networkmanager" "wheel" "docker" "navidrome" ];
  shell = pkgs.fish;
};

# Add myself to the trusted users
nix.settings.trusted-users = [ username ];

nix.settings = {
  # Enable flakes globally.
  experimental-features = [ "nix-command" "flakes" ];
};

# Garbage collection settings
nix.gc = {
  automatic = lib.mkDefault true;
  dates = lib.mkDefault "weekly";
  options = lib.mkDefault "--delete-older-than 7d";
};

system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos";
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
};

# Allow unfree software
nixpkgs.config.allowUnfree = true;

# Audio
# sound.enable = true;
# hardware.pulseaudio.enable = false;
security.polkit.enable = true;
security.rtkit.enable = true;

services.pipewire = {
  enable = true;
  alsa = {
    enable = true;
    support32Bit = true;
  };
  pulse.enable = true;
  jack.enable = true;
};

# Docking
virtualisation.docker.enable = true;

# Latest Linux Kernel
boot.kernelPackages = pkgs.linuxPackages_latest;

services.power-profiles-daemon.enable = true;

fonts = {
  packages = with pkgs; [
    material-design-icons
    hermit

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji  

    atkinson-hyperlegible-mono
    
    recursive 
    ocr-a

    hanken-grotesk
  ] ++ ( with pkgs.nerd-fonts; [ jetbrains-mono monaspace iosevka recursive-mono space-mono] );
};

environment.systemPackages = with pkgs; [
  neovim
  ripgrep
  fzf
  btop
  zsh
];

programs.zsh.enable = true;
programs.fish.enable = true;
programs.gamemode.enable = true;

}
