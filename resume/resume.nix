##################################################
{ stdenv
, texlive
}:

##################################################
let

in
##################################################
stdenv.mkDerivation
{

  name = "resume";

  src = ./.;

  buildInputs = [
    (texlive.combine {
      inherit (texlive) scheme-basic xetex setspace fontspec
                        chktex enumitem xifthen ifmtarg filehook
                        upquote tools ms geometry graphics oberdiek
                        fancyhdr lastpage xcolor etoolbox unicode-math
                        ucharcat sourcesanspro tcolorbox pgf environ
                        trimspaces parskip hyperref url euenc
                        collection-fontsrecommended;
     # Each attribute corresponds to a TeX Live package.
    })
  ];

  buildPhase = ''
    xelatex -file-line-error -interaction=nonstopmode resume.tex
  '';

  # ^ These options make it easier to debug xelatex when something goes wrong and makes sure we don’t get xelatex doesn’t require any user input. It will produce a file called resume.pdf that we can use as a résumé.

  installPhase = ''
    mkdir -p $out
    cp resume.pdf $out
  '';

  # ^ Copy the PDF into the « ./result » directory.

}
##################################################