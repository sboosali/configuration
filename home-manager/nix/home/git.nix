##################################################
{ pkgs

, sboo
}:

##################################################
{

  userName  = sboo.name;
  userEmail = sboo.email;

  aliases = import ./git-aliases.nix { inherit pkgs; };

      # signing = {
      #   key = "C144D8F4F19FE630";
      #   signByDefault = true;
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