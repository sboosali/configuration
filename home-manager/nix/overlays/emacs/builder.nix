########################################
{ stdenv

, emacs
, name
, src

, buildInputs ? []
, patches     ? []

}:
########################################
let

site-lisp-of-paths = paths:
  stdenv.lib.concatStringsSep " "
    (builtins.map site-lisp-of-path
      paths);

site-lisp-of-path = path: 
  path + "/share/emacs/site-lisp"

in
########################################
let

environment = {

  ######################################
  SiteLispDirectories = site-lisp-of-paths buildInputs;

  # ^ a custom derivation-attribute: all attributes of {{ stdenv.mkDerivation }}
  # become environment-variables exported to the `builder`.

  ######################################

};

in
########################################
stdenv.mkDerivation (environment // {

  inherit name src patches;

  buildInputs = [ emacs ] ++ buildInputs;

  ######################################
  unpackCmd = ''
    test -f "${src}" && mkdir el/ && cp -p ${src} el/${name}
  '';

  # ^ {{ test -f }} means: ensure that the (given) path:
  # * exists, and
  # * is a regular file.

  # ^ {{ cp -p }} means: preserve the permissions and timestamps of the original.
  # 
  # {{ $ man cp }} says: {{ -p }} is the same as
  # {{ --preserve=mode,ownership,timestamps }}.

  ######################################
  buildPhase = ''
    EmacsLoadPath=$(find $SiteLispDirectories -type d -exec echo '-L' {} \;)

    ${emacs}/bin/emacs -Q -nw -L . $EmacsLoadPath --batch -f batch-byte-compile *.el
  '';

  # ^ NOTE {{ echo -L <path>}} is not a option of echo;
  # it's printed verbatim, as a option for emacs.

  # ^ {{ emacs -L <path>}} means: add {{ <path> }} to the emacs `load-path`.

  # ^ NOTE in {{ find $SiteLispDirectories }},
  # our environment-variable `$SiteLispDirectories` gets passed unquoted. as do 
  # the {{ $EmacsLoadPath }} options in {{ emacs $EmacsLoadPath }}.

  # ^ {{ emacs -L . }} adds the current directory to the emacs `load-path`.

  ######################################
  installPhase = ''
    mkdir -p $out/share/emacs/site-lisp
    install *.el* $out/share/emacs/site-lisp
  '';

  # ^ {{ *.el* }} means: all `.el` and `.elc` files.

  ######################################
  meta = {
    homepage    = http://www.emacswiki.org;
    platforms   = stdenv.lib.platforms.all;
    description = "Emacs projects from the Internet or from your filesystem (just compiled .el files).";
  };

  ######################################
})

########################################
# Notes ################################
########################################
# 
# See:
# * <https://github.com/jwiegley/nix-config/blob/master/overlays/emacs/builder.nix emacs/builder.nix (jwiegley/nix-config)>
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
########################################