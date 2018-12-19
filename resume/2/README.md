# resume

## Building

```sh
nix-shell ./shell.nix

xelatex ./SamBoosalis.tex
```

## Files

## Notes

### HyperLinks via the `hyperref` package

Load the package in the preamble:

    \usepackage{hyperref}

and keep using `\label` & `\ref` (automatically become clickable hyperlinks).

`hyperref` defines `\url`:

`\url{<my_url>}` will show the URL using a mono-spaced font and, if you click on it, your browser will be opened pointing at it.

`hyperref` supports the `mailto:` protocol:

    \href{mailto:my_address@wikibooks.org}{my\_address@wikibooks.org}

### `chktex`

`chktex` is a linter for LaTex.

the warning `"Command terminated with space."` is motivated by: 
TeX gobbles spaces directly following a control word.

e.g. absent braces:

``` tex
\LaTeX is great.
```

renders as `"LaTeXis great."`.

while trailing braces:

``` tex
\LaTeX{} is great.
```

renders (correctly) as `"LaTeX is great."`.

## 

