{ config, pkgs, ... }:

{
   programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        format = ''
           $username[ @ ](bg:#F5A9B8 fg:#333333)$hostname | ($nix_shell )$directory 
          ( $git_commit $git_branch ($git_state )($git_status )$git_metrics
          )❯ '';
        username = {
          format = "[$user ]($style)";
          style_user = "bg:#5BCEFA fg:#333333";
          style_root = "bg:#C9510C fg:#FAFAFA";
          show_always = true;
        };
        directory = {
          format = "([$read_only]($read_only_style) )[ $path]($style)";
          style = "#F5A9B8";
          before_repo_root_style = "#FAFAFA";
          repo_root_style = "#5BCEFA";
          read_only_style = "#C9510C";
          read_only = "";
          truncation_symbol = "<many>/";
        };
        hostname = {
          format = "[$ssh_symbol $hostname ]($style)";
          style = "bg:#FFFFFF fg:#333333";
          ssh_only = false;
          ssh_symbol = "";
        };
        git_commit = {
          format = "[ $hash]($style)";
          style = "#4078C0";
          commit_hash_length = 7;
          only_detached = false;
        };
        git_state = {
          disabled = false;
          format = "$state [$progress_current](#4078C0) of [$progress_total](#6CC644)";
          rebase = "[ REBASING](bg:#c9510c fg:#fafafa)";
          merge = "[ MERGING](#c9510c)";
          cherry_pick = "[ CHERRY](#D2042D)";
          revert = "[REVERTING](#4078c0)";
          bisect = "[BISECTING](#4078c0)";
        };
        git_branch = {
          format = " $branch";
          style = "#4078C0";
        };
        git_status = {
          format = "( ($conflicted )$ahead_behind)";
          conflicted = "[](bg:#C9510C fg:#fafafa)";
          ahead = "[$count](bg:#6cc644 fg:#fafafa)";
          behind = "[$count](bg:#4078c0 fg:#fafafa)";
          diverged = "[$ahead_count](bg:#6cc644 fg:#fafafa) [$behind_count](bg:#4078c0 fg:#fafafa)";
          up_to_date = "[OK](fg:#6cc644)";
        };
        git_metrics = {
          disabled = false;
          added_style = "#5BCEFA";
	};
      

         ## JJ Custom Module
         custom."jj_refs" = {
            ignore_timeout = true;
            description = "Jujutsu VCS Refs";
            detect_folders = [".jj"];
            command = '' jj log --revisions @ --no-graph --color always --template 'separate(" ", change_id.shortest(8), commit_id.shortest(8))'
	              '';
        };

        custom."jj_immutable" = {
            ignore_timout = true;
            description = "Jujutsu VCS Immutable";
            detect_folders = [".jj"];
            style = "fg:grey";
            command = '' jj log --revisions @ --no-graph --color never --template 'if(immutable,"")'
                      '';
        };
      };
    };
}
