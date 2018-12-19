##################################################
{ stdenv
, texlive
}:

##################################################
{ texFile
, clsFile      ? null
, xetexOptions ? [ "-file-line-error" "-interaction=nonstopmode" ]
}:

##################################################

assert (builtins.any (type: type == builtins.typeOf texFile) [ "string" "path"        ]);

assert (builtins.any (type: type == builtins.typeOf clsFile) [ "string" "path" "null" ]);

assert (builtins.isList xetexOptions && builtins.all builtins.isString xetexOptions);

##################################################
let

texPackages = {

  inherit (texlive)
          collection-fontsrecommended
          hyperref
          # fontspec
          # lastpage
          xetex
          chktex                      # http://www.nongnu.org/chktex/
          scheme-minimal;

};

# ^ « hyperref » provides clickable hyperlinks in PDFs.

# ^ Any « scheme-* » derivation provides the language toolchain,
# e.g. « tex ».

# ^ « collection-fontsrecommended » provides TexLive's "fallback fonts",
# e.g. « lmroman10-regular ».

##################################################

texlive-combined = texlive.combine texPackages;

# ^ « xelatex » is registered onto « $PATH »,
#   by being a « buildInput ».

in
##################################################

stdenv.mkDerivation {

  name = ''resume'';

  src = ./.;

  buildInputs = [
    texlive-combined
  ];

  buildPhase = ''
    xelatex ${builtins.toString xetexOptions} ${texFile}
  '';

  installPhase = ''
    mkdir -p "$out"
    cp -v "*.pdf" "$out/"
  '';

}

##################################################