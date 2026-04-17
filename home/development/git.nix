{ config, pkgs, ... }:

{

  programs.delta = {
    enable = true;
    enableGitIntegration = true;	
  };
  
  programs.git = {
    enable = true;

    signing = {
      key = "511CB44BC7522A89";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "alikindsys";
        email = "alice@blocovermelho.org"; 
      };

      init = {
        # As per alphaflow~ the default branch usually is named "unstable". 	
      	defaultBranch = "unstable";
      };

      alias = {
		seidr = "rebase --interactive --rebase-merges=rebase-cousins --committer-date-is-author-date";
        "can-merge" = "merge-tree --quiet HEAD";
        mybranch = "!git log --oneline --graph main..";
        track = "add";
        untrack = "rm --cached";
        unstage = "reset HEAD -- ";
        reject = "restore --source=HEAD --staged --worktree -- ";
        discard = "restore -- ";
        staged = "diff --cached";
        unstaged = "diff";
        peek = "switch --detach";
        detach = "switch --detach HEAD^0";
        back = "switch \"-\"";
        unpulled = "range-diff @...@{u}";
        unpushed = "range-diff @{push}...@";
        trunklog = "log --oneline --graph --first-parent";
        branchlog = "!git log --oneline --graph $1^-";
      };

     rebase.missingCommitCheck = "error";
     rerere = {
       enabled = true;
       autoUpdate = true;
     };

     diff.algorithm = "histogram";
     pull.ff = "only";
     merge = {
       ff = false;
       conflictStyle = "zdiff3";
     };
     commit = {
       verbose = true;
     };

	 pluralgit.pk-export-path = "/home/alikindsys/Downloads/export.json";

    };
  };
}
