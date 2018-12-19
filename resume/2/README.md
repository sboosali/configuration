# resume


## Building

```sh
make build open
```

## Features

Hyperlinks (in `.pdf`):

* `\https` — Opens a new tab in your Default Browser, with the given URL.
* `\mailto` — Opens the Mail Client, with the given email as the recipient.
* `\tel` — On mobile, opens the Phone App, with the given phone number.

Implemented via `hyperref`'s `\href`. 
(It's trivial, see `./sboosali.sty` if you're interested for your own resume.)


## Requirements

* `nix` (version 2.0+)

which then provisions:

* the `xelatex` compiler (supporting the `LaTeX2e` language)
* the `hyperref` LaTex package


## Files

Tex:

* `./SamBoosalis.tex` — my resume.
* `./resume.cls` — the resume look&feel (layout, fonts, margins, etc).
* `./sboosali.sty` — (some personal utilities and re-exports.)

Make:

* `./Makefile`
* `./build.sh` — run by `make build`

Nix:

* `./nixpkgs.nix` — pinned `nixpkgs`
* `./shell.nix`
* `./resume.nix`

docs:

* `./README.md`
* `./NOTES.md` — (terse notes and copy-pasted posts for myself to reference in the future.)


## 

