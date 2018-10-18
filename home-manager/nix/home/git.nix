##################################################
{ pkgs

, sboo
}:
##################################################
{

  userName  = sboo.name;
  userEmail = sboo.email;

      # signing = {
      #   key = "C144D8F4F19FE630";
      #   signByDefault = true;
      # };

      # aliases = {
      #   amend      = "commit --amend -C HEAD";
      #   authors    = "!\"${pkgs.git}/bin/git log --pretty=format:%aN"
      #              + " | ${pkgs.coreutils}/bin/sort"
      #              + " | ${pkgs.coreutils}/bin/uniq -c"
      #              + " | ${pkgs.coreutils}/bin/sort -rn\"";
      #   b          = "branch --color -v";
      #   ca         = "commit --amend";
      #   changes    = "diff --name-status -r";
      #   clone      = "clone --recursive";
      #   co         = "checkout";
      #   cp         = "cherry-pick";
      #   dc         = "diff --cached";
      #   dh         = "diff HEAD";
      #   ds         = "diff --staged";
      #   from       = "!${pkgs.git}/bin/git bisect start && ${pkgs.git}/bin/git bisect bad HEAD && ${pkgs.git}/bin/git bisect good";
      #   ls-ignored = "ls-files --exclude-standard --ignored --others";
      #   nb         = "!${pkgs.git}/bin/git checkout --track $(${pkgs.git}/bin/git config branch.$(${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD).remote)/$(${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD) -b";
      #   pr         = "!${pkgs.git}/bin/git push $(${pkgs.git}/bin/git config branch.$(${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD).remote) HEAD:$(${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD) && ${pkgs.git-pull-request}/bin/git-pull-request --target-branch $(${pkgs.git}/bin/git config branch.$(${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD).merge) --target-remote $(${pkgs.git}/bin/git config branch.$(${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD).remote) --no-rebase --no-comment-on-update";
      #   rc         = "rebase --continue";
      #   rh         = "reset --hard";
      #   ri         = "rebase --interactive";
      #   rs         = "rebase --skip";
      #   ru         = "remote update --prune";
      #   snap       = "!${pkgs.git}/bin/git stash"
      #              + " && ${pkgs.git}/bin/git stash apply";
      #   snaplog    = "!${pkgs.git}/bin/git log refs/snapshots/refs/heads/"
      #              + "\$(${pkgs.git}/bin/git rev-parse HEAD)";
      #   spull      = "!${pkgs.git}/bin/git stash"
      #              + " && ${pkgs.git}/bin/git pull"
      #              + " && ${pkgs.git}/bin/git stash pop";
      #   su         = "submodule update --init --recursive";
      #   undo       = "reset --soft HEAD^";
      #   w          = "status -sb";
      #   wdiff      = "diff --color-words";
      #   l          = "log --graph --pretty=format:'%Cred%h%Creset"
      #              + " —%Cblue%d%Creset %s %Cgreen(%cr)%Creset'"
      #              + " --abbrev-commit --date=relative --show-notes=*";
      # };

      # extraConfig = {
      #   core = {
      #     editor            = "${pkgs.emacs26}/bin/emacsclient -s /tmp/emacs501/server";
      #     trustctime        = false;
      #     fsyncobjectfiles  = true;
      #     pager             = "${pkgs.less}/bin/less --tabs=4 -RFX";
      #     logAllRefUpdates  = true;
      #     precomposeunicode = false;
      #     whitespace        = "trailing-space,space-before-tab";
      #   };

      #   branch.autosetupmerge = true;
      #   commit.gpgsign        = true;
      #   github.user           = "jwiegley";
      #   credential.helper     = "${pkgs.pass-git-helper}/bin/pass-git-helper";
      #   ghi.token             = "!${pkgs.pass}/bin/pass api.github.com | head -1";
      #   hub.protocol          = "${pkgs.openssh}/bin/ssh";
      #   mergetool.keepBackup  = true;
      #   pull.rebase           = true;
      #   rebase.autosquash     = true;
      #   rerere.enabled        = true;

      #   "merge \"ours\"".driver   = true;
      #   "magithub \"ci\"".enabled = false;

      #   http = {
      #     sslCAinfo = "${ca-bundle_crt}";
      #     sslverify = true;
      #   };

      #   color = {
      #     status      = "auto";
      #     diff        = "auto";
      #     branch      = "auto";
      #     interactive = "auto";
      #     ui          = "auto";
      #     sh          = "auto";
      #   };

      #   push = {
      #     default = "tracking";
      #     recurseSubmodules = "check";
      #   };

      #   "merge \"merge-changelog\"" = {
      #     name = "GNU-style ChangeLog merge driver";
      #     driver = "${pkgs.git-scripts}/bin/git-merge-changelog %O %A %B";
      #   };

      #   merge = {
      #     conflictstyle = "diff3";
      #     stat = true;
      #   };

      #   "color \"sh\"" = {
      #     branch      = "yellow reverse";
      #     workdir     = "blue bold";
      #     dirty       = "red";
      #     dirty-stash = "red";
      #     repo-state  = "red";
      #   };

      #   annex = {
      #     backends = "SHA512E";
      #     alwayscommit = false;
      #   };

      #   "filter \"media\"" = {
      #     required = true;
      #     clean = "${pkgs.git}/bin/git media clean %f";
      #     smudge = "${pkgs.git}/bin/git media smudge %f";
      #   };

      #   submodule = {
      #     recurse = true;
      #   };

      #   diff = {
      #     ignoreSubmodules = "dirty";
      #     renames = "copies";
      #     mnemonicprefix = true;
      #   };

      #   advice = {
      #     statusHints = false;
      #     pushNonFastForward = false;
      #   };

      #   "filter \"lfs\"" = {
      #     clean = "${pkgs.git-lfs}/bin/git-lfs clean -- %f";
      #     smudge = "${pkgs.git-lfs}/bin/git-lfs smudge --skip -- %f";
      #     required = true;
      #   };

      #   "url \"git://github.com/ghc/packages-\"".insteadOf
      #     = "git://github.com/ghc/packages/";
      #   "url \"http://github.com/ghc/packages-\"".insteadOf
      #     = "http://github.com/ghc/packages/";
      #   "url \"https://github.com/ghc/packages-\"".insteadOf
      #     = "https://github.com/ghc/packages/";
      #   "url \"ssh://git@github.com/ghc/packages-\"".insteadOf
      #     = "ssh://git@github.com/ghc/packages/";
      #   "url \"git@github.com:/ghc/packages-\"".insteadOf
      #     = "git@github.com:/ghc/packages/";
      # };

  ignores = [
    "gitignored.txt"
    "gitignored.d/"
    "*.elc"
    "*.vo"
    "*.aux"
    "*.v.d"
    "*.o"
    "*.a"
    "*.la"
    "*.so"
    "*.dylib"
    "*~"
    "#*#"
    ".#*"
    "#*"
    ".makefile"
    ".clean"
    ".envrc"
    ".direnv"
    "*.glob"
    ".virtualenv"
    ".hsenv"
    ".DS_Store"
    "*.hi"
    "*.chi"
    "*.chi.h"
    "dist/"
    "dist-*/"
    ".stack-work/"
    ".cabal-sandbox/"
  ];

}
##################################################
# Notes ##########################################
##################################################
# 
# 
# 
##################################################