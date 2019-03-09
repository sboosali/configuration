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


{

emacs = self.emacs26;

emacsPackagesNg = self.emacs26PackagesNg;
emacs26PackagesNg = mkEmacsPackages self.emacs26;

emacs26DebugPackagesNg = mkEmacsPackages self.emacs26debug;
emacsHEADPackagesNg = mkEmacsPackages self.emacsHEAD;

emacs26 = with pkgs; stdenv.lib.overrideDerivation
  (pkgs.emacs26.override { srcRepo = true; }) (attrs: rec {
  name = "emacs-${version}${versionModifier}";
  version = "26.1";
  versionModifier = ".92";

  doCheck = false;

  buildInputs = (attrs.buildInputs or []) ++
    [ git libpng.dev libjpeg.dev libungif libtiff.dev librsvg.dev
      imagemagick.dev ];

  patches = lib.optionals stdenv.isDarwin
    [ ./emacs/tramp-detect-wrapped-gvfsd.patch
      ./emacs/patches/at-fdcwd.patch
      ./emacs/patches/emacs-26.patch ];

  CFLAGS = "-Ofast -momit-leaf-frame-pointer -DMAC_OS_X_VERSION_MAX_ALLOWED=101200";

  src = fetchgit {
    url = https://git.savannah.gnu.org/git/emacs.git;
    rev = "emacs-${version}${versionModifier}";
    sha256 = "0v6nrmf0viw6ahf8s090hwpsrf6gjpi37r842ikjcsakfxys9dmc";
    # date = 2019-02-20T07:33:53-08:00;
  };

  postPatch = "rm -fr .git";
});

emacs26debug = pkgs.stdenv.lib.overrideDerivation self.emacs26 (attrs: rec {
  name = "emacs-26.1-debug";
  doCheck = true;
  CFLAGS = "-O0 -g3 -DMAC_OS_X_VERSION_MAX_ALLOWED=101200";
  configureFlags = [ "--with-modules" ] ++
   [ "--with-ns" "--disable-ns-self-contained"
     "--enable-checking=yes,glyphs"
     "--enable-check-lisp-object-type" ];
});

emacsHEAD = with pkgs; stdenv.lib.overrideDerivation self.emacs26debug (attrs: rec {
  name = "emacs-${version}${versionModifier}";
  version = "27.0";
  versionModifier = ".50";

  patches = (attrs.patches or []) ++
    (lib.optionals stdenv.isDarwin
      [ ./emacs/patches/at-fdcwd.patch
        # ./emacs/patches/emacs-26.patch
      ]);

  buildInputs    = attrs.buildInputs    ++ [ harfbuzz.dev ];
  configureFlags = attrs.configureFlags ++ [ "--enable-harfbuzz" ];

  src = ~/src/emacs;
});

convertForMac = drv: pkgs.stdenv.lib.overrideDerivation drv (attrs: rec {
  postInstall = (attrs.postInstall or "") + ''
    mkdir -p $out/Applications
    mv nextstep/Emacs.app $out/Applications
  '';
});

convertForERC = drv: pkgs.stdenv.lib.overrideDerivation drv (attrs: rec {
  appName = "ERC";
  bundleName = "nextstep/ERC.app";

  iconFile = ./emacs/Chat.icns;

  version = "26.1";

  postPatch = (attrs.postPatch or "") + ''
    sed -i 's|/usr/share/locale|${pkgs.gettext}/share/locale|g' \
      lisp/international/mule-cmds.el
    sed -i 's|nextstep/Emacs\.app|${bundleName}|' configure.ac
    sed -i 's|>Emacs<|>${appName}<|' nextstep/templates/Info.plist.in
    sed -i 's|Emacs\.app|${appName}.app|' nextstep/templates/Info.plist.in
    sed -i 's|org\.gnu\.Emacs|org.gnu.${appName}|' nextstep/templates/Info.plist.in
    sed -i 's|Emacs @version@|${appName} @version@|' nextstep/templates/Info.plist.in
    sed -i 's|EmacsApp|${appName}App|' nextstep/templates/Info.plist.in
    if [ -n "${iconFile}" ]; then
      sed -i 's|Emacs\.icns|${appName}.icns|' nextstep/templates/Info.plist.in
    fi
    sed -i 's|Name=Emacs|Name=${appName}|' nextstep/templates/Emacs.desktop.in
    sed -i 's|Emacs\.app|${appName}.app|' nextstep/templates/Emacs.desktop.in
    sed -i 's|"Emacs|"${appName}|' nextstep/templates/InfoPlist.strings.in
    rm -fr .git
    sh autogen.sh
  '';

  installPhase = (attrs.installPhase or "") + ''
    if [ -d "$emacs/Applications/ERC.app" ]; then
      mkdir -p $out/Applications/ERC.app/Contents/MacOS
      cp -r $emacs/Applications/ERC.app/Contents/Info.plist \
            $emacs/Applications/ERC.app/Contents/PkgInfo \
            $emacs/Applications/ERC.app/Contents/Resources \
            $out/Applications/ERC.app/Contents
      makeWrapper $emacs/Applications/ERC.app/Contents/MacOS/ERC \
                  $out/Applications/ERC.app/Contents/MacOS/ERC \
                  --suffix EMACSLOADPATH ":" "$deps/share/emacs/site-lisp:"
    fi
  '';

  postInstall = ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${./emacs/site-start.el} $out/share/emacs/site-lisp/site-start.el
    $out/bin/emacs --batch -f batch-byte-compile $out/share/emacs/site-lisp/site-start.el

    rm -rf $out/var
    rm -rf $out/share/emacs/${version}/site-lisp

    for srcdir in src lisp lwlib ; do
      dstdir=$out/share/emacs/${version}/$srcdir
      mkdir -p $dstdir
      find $srcdir -name "*.[chm]" -exec cp {} $dstdir \;
      cp $srcdir/TAGS $dstdir
      echo '((nil . ((tags-file-name . "TAGS"))))' > $dstdir/.dir-locals.el
    done

    mkdir -p $out/Applications
    if [ "${appName}" != "Emacs" ]; then
        mv ${bundleName}/Contents/MacOS/Emacs ${bundleName}/Contents/MacOS/${appName}
    fi
    if [ -n "${iconFile}" ]; then
      cp "${iconFile}" ${bundleName}/Contents/Resources/${appName}.icns
    fi
    mv ${bundleName} $out/Applications
  '';
});

emacsHEADEnv = myPkgs: pkgs.myEnvFun {
  name = "emacsHEAD";
  buildInputs = [
    # (self.convertForERC (self.emacsHEADPackagesNg.emacsWithPackages myPkgs))
    (self.convertForERC (self.emacs26PackagesNg.emacsWithPackages myPkgs))
  ];
};

emacs26Env = myPkgs: pkgs.myEnvFun {
  name = "emacs26";
  buildInputs = [
    (self.convertForMac (self.emacs26PackagesNg.emacsWithPackages myPkgs))
  ];
};

emacs26DebugEnv = myPkgs: pkgs.myEnvFun {
  name = "emacs26debug";
  buildInputs = [
    (self.convertForMac (self.emacs26DebugPackagesNg.emacsWithPackages myPkgs))
  ];
};

}