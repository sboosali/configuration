########################################

self: pkgs:

########################################
let
########################################

myEmacsPackageOverrides =
  import ./overrides.nix pkgs;

########################################



########################################
in
########################################
{

 #######################################
 # Aliases
 #######################################
 
 emacs           = self.emacs26;
 emacsPackagesNg = self.emacs26PackagesNg;
 
 #######################################
 # Emacs-26.1
 #######################################
 
 emacs26PackagesNg = mkEmacsPackages self.emacs26;

 #######################################
 
 emacs26 = with pkgs;
 
   stdenv.lib.overrideDerivation
   
     (pkgs.emacs26.override {
     })
     
     (attributes: rec 

       name            = "${attributes.name}${versionModifier}";
       versionModifier = "-sboosali";
       
       postInstall = ''
       mkdir -p $out/share/emacs/site-lisp
       cp ${./emacs/site-start.el} $out/share/emacs/site-lisp/site-start.el
       $out/bin/emacs --batch -f batch-byte-compile $out/share/emacs/site-lisp/site-start.el
       rm -rf $out/var
       rm -rf $out/share/emacs/${attributes.version}/site-lisp
       for srcdir in src lisp lwlib ; do
         dstdir=$out/share/emacs/${attributes.version}/$srcdir
         mkdir -p $dstdir
         find $srcdir -name "*.[chm]" -exec cp {} $dstdir \;
         cp $srcdir/TAGS $dstdir
         echo '((nil . ((tags-file-name . "TAGS"))))' > $dstdir/.dir-locals.el
       done
       '' + lib.optionalString stdenv.isLinux  ''
       '' + lib.optionalString stdenv.isDarwin ''
         mkdir -p $out/Applications
         mv nextstep/Emacs.app $out/Applications
       '';

     });
 
 #######################################
 
}
########################################