{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
        glog = "git log --oneline --graph";
        gloga = "git log --oneline --graph --all";
        gss = "git status --short";
        rebuild = "sudo nixos-rebuild switch";
        cat = "bat";
        ls = "eza";
	ll = "eza -l";
	tree = "eza --tree";
	nano = "micro";
    };
  };

  programs.direnv.enableFishIntegration = true;
  programs.starship.enableFishIntegration = true;
  programs.zoxide.enableFishIntegration = true;
  programs.nix-your-shell.enableFishIntegration = true; 
  programs.eza.enableFishIntegration = true;
}
