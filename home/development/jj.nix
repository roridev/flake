{ config, pkgs, home, ... }:

{

  home.packages = with pkgs; [gg-jj];
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "alikindsys";
        email = "alice@blocovermelho.org"; 
      };
      ui = {
        diff-formatter = ":git";
        conflict-marker-style = "git";
        pager = "delta";
        editor = "nano";
        default-command = ["log"];
      };
      signing = {
        behaviour = "own";
        backend = "gpg";
        key = "511CB44BC7522A89";
      };
      git = {
        sign-on-push = true;
        "auto-local-bookmark" = true;
        # Private Commits. Don't push "broken:", "test:" or "wip:" commits.
        private-commits = "description(glob:'broken:*') | description(glob:'test:*') | description(glob:'wip:*')";
      };
      aliases = {
        bm = ["bookmark" "move"];
      };
    };
  };
}
