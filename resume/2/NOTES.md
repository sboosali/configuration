# Notes (about `TeX`)


## Programs

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


## LaTeX

### HyperLinks via the `hyperref` package

Load the package in the preamble:

    \usepackage{hyperref}

and keep using `\label` & `\ref` (automatically become clickable hyperlinks).

`hyperref` defines `\url`:

`\url{<my_url>}` will show the URL using a mono-spaced font and, if you click on it, your browser will be opened pointing at it.

`hyperref` supports the `mailto:` protocol:

    \href{mailto:my_address@wikibooks.org}{my\_address@wikibooks.org}

### `\newcommand` & `\renewcommand`

the definition commands (`\new{command,environment,...}`) define *macros*.

the syntax is:

``` tex
\newcommand{name}[arity]{definition}
```

e.g. a definiton: 

``` tex
\newcommand*{\https}[1]{
  \href{https://#1}
}
```

e.g. an invocation:

``` tex
\https{sboosali.github.io}
```

which expands into

``` tex
\href{https://sboosali.github.io} {sboosali.github.io}
```

the redefinition commands (`\renew{command,environment,...}`) *re*define macros.

### Lines & Pages

<http://www.emerson.emory.edu/services/latex/latex_toc.html>

*   `\\`
*   `\-`
*   `\cleardoublepage`
*   `\clearpage`
*   `\hyphenation`
*   `\linebreak`
*   `\newline`
*   `\newpage`
*   `\nolinebreak`
*   `\nopagebreak`
*   `\pagebreak `

### Paragraphs

*   `\indent`
*   `\noindent`
*   `\par `

### `\href`

the `\href` command is defined by the `hyperref` package.

e.g. a Wikipedia command, for convenient and standard Wikipedia links:

``` tex
% definiton:

\newcommand{\Wikipedia}[1]{%
    \href{http://en.wikipedia.org/wiki/#1}{#1}%
}

% usage:

\Wikipedia{LaTeX}
```

### Typefaces

> a typeface is specified by giving the "size" and "style". A typeface is also called a "font". 

the default (typeface) styles in LaTeX are:

* `\rm`
    Roman. 
* `\it`
    Italics. 
* `\em`
    Emphasis (toggles between \it and \rm). 
* `\bf`
    Boldface. 
* `\sl`
    Slanted. 
* `\sf`
    Sans serif. 
* `\sc`
    Small caps. 
* `\tt`
    Typewriter. 
    
the default (typeface) styles in LaTeX are:

* `\tiny`
* `\scriptsize`
* `\footnotesize`
* `\small`
* `\normalsize`
    the default.
* `\large`
* `\Large`
    (N.B. capital "L").
* `\LARGE`
    (N.B. all caps).
* `\huge`
* `\Huge`
    (N.B. capital "H").

### `\symbol`

the `\symbol` command inputs a Unicode-codepoint in Hexadecimal, outputting the Unicode character.

### `\enumerate` (& `\item`)

syntax:

``` tex
\begin{enumerate}

  \item First item
  \item Second item

\end{enumerate}
```

e.g.:

``` tex
\begin{enumerate}

  \item First item
  \item Second item

\end{enumerate}
```

> The enumerate environment produces a numbered list. Enumerations can be nested within one another, up to four levels deep. They can also be nested within other paragraph-making environments.

> Each item of an enumerated list begins with an \item command. There must be at least one \item command within the environment.

### `\list` (& `\item`)

syntax:

``` tex
\begin{list}{label}{spacing}

  \item First item
  \item Second item

\end{list}
```

e.g.:

``` tex
\begin{list}{∙}{}

  \item First item
  \item Second item

\end{list}
```

> The {label} argument specifies how items should be labelled. This argument is a piece of text that is inserted in a box to form the label. This argument can and usually does contain other LaTeX commands.

> The {spacing} argument contains commands to change the spacing parameters for the list. This argument will most often be null, i.e., {}. This will select all default spacing which should suffice for most cases. 

### the `\picture` environment

syntax:

``` tex
\begin{picture}(width,height)(x offset,y offset)
 .
 <picture_commands>
 .
\end{picture}
```

> The picture environment allows you to create just about any kind of picture you want containing text, lines, arrows and circles. You tell LaTeX where to put things in the picture by specifying their coordinates. A coordinate is a number that may have a decimal point and a minus sign - a number like 5, 2.3 or -3.1416. A coordinate specifies a length in multiples of the unit length \unitlength, so if \unitlength has been set to 1cm, then the coordinate 2.54 specifies a length of 2.54 centimeters. You can change the value of \unitlength anywhere you want, using the \setlength command, but strange things will happen if you try changing it inside the picture environment.

`picture` commands include:

* `\circle`:

     `\circle[*]{diameter}`

     > The \circle command produces a circle of the specified diameter. If the *-form of the command is used, LaTeX draws a solid circle. 

### the `\quotation` environment

syntax:

``` tex
\begin{quotation}

  Don't eat gabagool, Grandma, it's nothing but fat and nitrates.

\end{quotation}
```

### `\newcommand` vs `\newcommand*`

<https://tex.stackexchange.com/questions/1050/whats-the-difference-between-newcommand-and-newcommand>

`\newcommand*` is recommended.

`\newcommand` wraps `\long` (in particular, it wraps `\long\def`), and thus may contain "paragraphs", including `\par` and `{`.

`\newcommand*` wraps `\def` only, and thus cannot contain `\par`.

### 


## Packages

### 

### 


