{ config, pkgs, ... }:

{
  imports = [
    ../modules/xcompose.nix
  ];

  programs.xcompose = {
    includeDefault = true;

    entries = [
      { key = "<>zh"; out = "ʒ"; }
    ];
  };
}
