self: super: {

installApplication = 
  { name, appname ? name, version, src, description, homepage, 
    postInstall ? "", sourceRoot ? ".", ... }:
  with super; stdenv.mkDerivation {
    name = "${name}-${version}";
    version = "${version}";
    src = src;
    buildInputs = [ undmg unzip ];
    sourceRoot = sourceRoot;
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      mkdir -p "$out/Applications/${appname}.app"
      cp -pR * "$out/Applications/${appname}.app"
    '' + postInstall;
    meta = with stdenv.lib; {
      description = description;
      homepage = homepage;
      maintainers = with maintainers; [ jwiegley ];
      platforms = platforms.darwin;
    };
  };

Anki = self.installApplication rec {
  name = "Anki";
  version = "2.1.5";
  sourceRoot = "Anki.app";
  src = super.fetchurl {
    url = "https://apps.ankiweb.net/downloads/current/anki-${version}-mac.dmg";
    sha256 = "0ca0sbfxvji6h9g6p3433c663i2kgp3nfgh8b262w1ganxygjfd2";
    # date = 2018-10-03T15:42:49-0800;
  };
  description = "Anki is a program which makes remembering things easy";
  homepage = https://apps.ankiweb.net;
};
