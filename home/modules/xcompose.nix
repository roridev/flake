{ config, lib, pkgs, ... }:

let
  composeLib = import ../../modules/emacs_compose.nix;
in
{
  options.programs.xcompose = {
    entries = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.str);
      default = [];
      description = "Custom XCompose key → output entries.";
    };

    includeDefault = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to prepend `include "%L"` to pull in the default XCompose.
      '';
    };
  };

  config = {
    home.file.".XCompose".text =
      let
        # Generate each line using the pure library
        renderEntry = e: composeLib.generateXCompose e.key e.out;

        header =
          if config.programs.xcompose.includeDefault
          then ''include "%L"'' + "\n\n"
          else "";
      in
        header
        + lib.concatStringsSep "\n"
            (map renderEntry config.programs.xcompose.entries)
        + "\n";
  };
}
