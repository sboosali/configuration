##################################################
{ stdenv
, texlive
}:

##################################################
{ resume
}:

##################################################
let
##################################################

latexPackages = {

  inherit (texlive)
          chktex                      # 
          collection-fontsrecommended # 
          enumitem                    # 
          environ                     # 
          etoolbox                    # 
          euenc                       # 
          fancyhdr                    # 
          filehook                    # 
          fontspec                    # 
          geometry                    # 
          graphics                    # 
          hyperref                    # « hyperref » provides hyperlinks in PDFs.
          ifmtarg                     # 
          lastpage                    # 
          ms                          # 
          oberdiek                    # 
          parskip                     # 
          pgf                         # 
          scheme-basic                # 
          setspace                    # 
          sourcesanspro               # 
          tcolorbox                   # 
          tools                       # 
          trimspaces                  # 
          ucharcat                    # 
          unicode-math                # 
          upquote                     # 
          url                         # 
          xcolor                      # 
          xetex                       # 
          xifthen                     # 
          ;
};

# ^ Each attribute corresponds to a TeX Live package.

##################################################
in
##################################################
stdenv.mkDerivation
rec {

  name = "sam_boosalis";

  src = ../tex;                    # TODO

  buildInputs = [
    (texlive.combine latexPackages)
    # xelatex
  ];
  #inherit xelatex;

  # inherit resume;
  # passAsFile = [ "resume" ];

  buildPhase = ''
    # mv $resume "${name}.tex" 
    xelatex -file-line-error -interaction=nonstopmode "${name}.tex"
  '';

  # ^ These options make it easier to debug xelatex when something goes wrong and makes sure we don’t get xelatex doesn’t require any user input. It will produce a file called resume.pdf that we can use as a résumé.

  installPhase = ''
    mkdir -p $out
    cp "${name}.pdf" $out
  '';

  # ^ Copy the PDF into the « ./result » directory.

}
##################################################