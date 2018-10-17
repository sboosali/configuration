



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

 # #######################################
 # # Emacs-27.0
 # #######################################
 
 # emacs27PackagesNg = mkEmacsPackages self.emacs27;

 # #######################################
 
 # emacs27 = with pkgs; stdenv.lib.overrideDerivation
 #   (pkgs.emacs26.override { srcRepo = true; }) (attrs:

 #  rec {
 #   name = "emacs-${version}${versionModifier}";
 #   version = "27.0";
 #   versionModifier = "";
 
 #   buildInputs = emacs27.buildInputs ++
 #     [ git libpng.dev libjpeg.dev libungif libtiff.dev librsvg.dev
 #       imagemagick.dev ];
 
 #   CFLAGS = "-Ofast -momit-leaf-frame-pointer -DMAC_OS_X_VERSION_MAX_ALLOWED=101200";
 
 #   src = fetchgit {
 #     url = https://git.savannah.gnu.org/git/emacs.git;
 #     rev = "ec79bdc53fd75ea48c1451b0d83b0b41a0345bc6";
 #     sha256 = "1g2jjpvwlzpvk49fds0w9m0rjh372i4qpv3p6qxlxydiyjqpa5f6";
 #   };
 
 #   postPatch = ''
 #     rm -fr .git
 #   '';
 
 #   postInstall = ''
 #     mkdir -p $out/share/emacs/site-lisp
 #     cp ${./emacs/site-start.el} $out/share/emacs/site-lisp/site-start.el
 #     $out/bin/emacs --batch -f batch-byte-compile $out/share/emacs/site-lisp/site-start.el
 #     rm -rf $out/var
 #     rm -rf $out/share/emacs/${version}/site-lisp
 #     for srcdir in src lisp lwlib ; do
 #       dstdir=$out/share/emacs/${version}/$srcdir
 #       mkdir -p $dstdir
 #       find $srcdir -name "*.[chm]" -exec cp {} $dstdir \;
 #       cp $srcdir/TAGS $dstdir
 #       echo '((nil . ((tags-file-name . "TAGS"))))' > $dstdir/.dir-locals.el
 #     done
 #   '' + lib.optionalString stdenv.isDarwin ''
 #     mkdir -p $out/Applications
 #     mv nextstep/Emacs.app $out/Applications
 #   '';
 
 #  });
 
 #######################################
 
}
########################################