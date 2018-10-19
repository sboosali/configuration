########################################

self: super:

########################################
let

installApplication =

  { name, appname ? name, version, src, 
  description, homepage, 
    postInstall ? "", sourceRoot ? ".", doCheck ? false,
 ... }:

  with super; stdenv.mkDerivation {

    name = "${name}-${version}";
    inherit src version;


    buildInputs = [ unzip ];
     ++ (lib.optionals doCheck [ dex ]);

    sourceRoot = sourceRoot;


    phases = [ "unpackPhase" "installPhase" ]
      ++ (lib.optionals doCheck [ "checkPhase" ]);


  checkPhase = ''
    "${dex}/bin/dex" ...
  '';

    installPhase = ''
      mkdir -p "$out/Applications/${appname}.app"
      cp -pR * "$out/Applications/${appname}.app"
    '' + postInstall;


    meta = with stdenv.lib; {
      description = description;
      homepage = homepage;
      maintainers = with maintainers; [ sboosali ];
      platforms = platforms.linux;
    };
  };

in
########################################

applications = {



};

########################################

applications

########################################
# Notes ################################
########################################
/*

 APPLICATION = self.installApplication rec {
   name = "APPLICATION";
 };

*/