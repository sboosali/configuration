# "Reproducible Resumes"

## Links

<https://matthewbauer.us/blog/resume.html>

<https://github.com/matthewbauer/resume>

## LaTex

### LaTex syntax:

* everything is made up of commands.
* each command starts with a `\`, followed by its command name.
* each command can take a variable number of arguments, specified with braces (`{` and `}`).

> LaTeX is made up a series of packages that provide these commands and do most of the work of typography automatically.

> Every LaTeX document has a document class. Think of it like the CSS to the Résumé’s HTML.

### LaTex: `resume.cls`

```latex

```

### LaTex: Header

> Every LaTeX document has a document class. For this document, I will use a custom resume class:

```latex
\documentclass[11pt]{resume}
```

### LaTex: Body

```latex

```

### LaTex: Footer

```latex

```

## Building

```nix
stdenv.mkDerivation {
  name = "resume";
  src = ./.;

# We’ll name this derivation resume and tell it to use the files in the current directory as source.

buildInputs = [
  (texlive.combine {
    inherit (texlive) scheme-basic xetex xetex-def setspace fontspec
                      chktex enumitem xifthen ifmtarg filehook
                      upquote tools ms geometry graphics oberdiek
                      fancyhdr lastpage xcolor etoolbox unicode-math
                      ucharcat sourcesanspro tcolorbox pgf environ
                      trimspaces parskip hyperref url euenc
                      collection-fontsrecommended;
  })
];


# Inputs in Nix are similar to dependencies in other package managers. Here, we list only one dependency which provides our LaTeX distribution. texlive.combine is a function that produces a derivation which will provide the xetex binary. Each attribute listed in between { and } will be passed as LaTeX packages to TeX Live. The inherit keyword tells Nix to pass everything after (texlive) as attributes of texlive to texlive.combine. Each one of those names listed should correspond to TeX Live packages that are needed to build the résumé PDF.

# In the future, I’d like to get Tex Live to actually recognize the packages we are using within LaTeX, but nothing seems to exist to do this.

buildPhase = ''
  xelatex -file-line-error -interaction=nonstopmode resume.tex
'';


# Here we actually build the xelatex file. These options make it easier to debug xelatex when something goes wrong and makes sure we don’t get xelatex doesn’t require any user input. It will produce a file called resume.pdf that we can use as a résumé.

installPhase = ''
  cp resume.pdf $out
'';


# Finally, we copy this résumé to $out where the derivation will live.

}
```

## 