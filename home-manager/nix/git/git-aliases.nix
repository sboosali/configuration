##################################################
{ pkgs

#, sboo
}:

##################################################
let

git = "${pkgs.git}/bin/git";

sort = "${pkgs.coreutils}/bin/sort";
uniq = "${pkgs.coreutils}/bin/uniq";

in
##################################################
{
  ######################################
  amend      = "commit --amend -C HEAD";
  authors    = "!\"${git} log --pretty=format:%aN"
             + " | ${sort}"
             + " | ${uniq} -c"
             + " | ${sort} -rn\"";

  ######################################
  a            = "add";
  au           = "add -u";
  ap           = "add -p";

  ######################################
  b          = "branch --color -v";

  ######################################


  ######################################
  p      = "push";
  pf     = "push -f";

  ######################################


  ######################################
  ca         = "commit --amend";

  ######################################
  changes    = "diff --name-status -r";

  ######################################
  clone      = "clone --recursive";
  co         = "checkout";
  cp         = "cherry-pick";

  ######################################
  dc         = "diff --cached";
  dh         = "diff HEAD";
  ds         = "diff --staged";

  ######################################
  from       = "!${git} bisect start && ${git} bisect bad HEAD && ${git} bisect good";

  ######################################
  ls-ignored = "ls-files --exclude-standard --ignored --others";

  ######################################
  nb         = "!${git} checkout --track $(${git} config branch.$(${git} rev-parse --abbrev-ref HEAD).remote)/$(${git} rev-parse --abbrev-ref HEAD) -b";

  ######################################
##pr         = ""
##pr         = "!${git} push $(${git} config branch.$(${git} rev-parse --abbrev-ref HEAD).remote) HEAD:$(${git} rev-parse --abbrev-ref HEAD) && ${pkgs.git-pull-request}/bin/git-pull-request --target-branch $(${git} config branch.$(${git} rev-parse --abbrev-ref HEAD).merge) --target-remote $(${git} config branch.$(${git} rev-parse --abbrev-ref HEAD).remote) --no-rebase --no-comment-on-update";

  ######################################
  rc         = "rebase --continue";
  ri         = "rebase --interactive";
  rs         = "rebase --skip";

  ######################################
  ru         = "remote update --prune";

  ######################################
  rh         = "reset --hard";

  ######################################
  s          = "status";
  sp         = "status --porcelain";

  ######################################
  snap       = "!${git} stash"
             + " && ${git} stash apply";
  snaplog    = "!${git} log refs/snapshots/refs/heads/"
             + "\$(${git} rev-parse HEAD)";
  spull      = "!${git} stash"
             + " && ${git} pull"
             + " && ${git} stash pop";

  ######################################
  su         = "submodule update --init --recursive";

  ######################################
  undo       = "reset --soft HEAD^";
  w          = "status -sb";
  wdiff      = "diff --color-words";

  ######################################
  l          = "log --graph --pretty=format:'%Cred%h%Creset"
             + " —%Cblue%d%Creset %s %Cgreen(%cr)%Creset'"
             + " --abbrev-commit --date=relative --show-notes=*";

  ######################################
  unedit       = "checkout --";
  unstage      = "reset HEAD --";
  uncommit     = "reset --soft HEAD~1";
  recommit     = "commit -c ORIG_HEAD";

  ######################################

  upstream-set    = "remote add upstream";

  # ^ e.g.:
  #
  # $ git remote add upstream https://github.com/NixOS/nixpkgs.git
  #

  upstream-get    = "remote -v show upstream";

  # ^ e.g.:
  #
  # $ git remote -v
  # origin	https://github.com/sboosali/nixpkgs (fetch)
  # origin	https://github.com/sboosali/nixpkgs (push)
  # upstream	https://github.com/NixOS/nixpkgs.git (fetch)
  # upstream	https://github.com/NixOS/nixpkgs.git (push)
  #
  # $ git remote -v show upstream
  # * remote upstream
  #   Fetch URL: https://github.com/NixOS/nixpkgs.git
  #   Push  URL: https://github.com/NixOS/nixpkgs.git
  #   HEAD branch: master
  #   Remote branches:
  #     ...
  #     release-18.09                    new (next fetch will store in remotes/upstream)
  #     ...
  #   Local ref configured for 'git push':
  #     master pushes to master (local out of date)
  #

  upstream-rebase = "pull --rebase upstream master";

  # ^ for updating a fork (rebase master onto upstream).

  ######################################


  ######################################
}