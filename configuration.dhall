--   let map = http://prelude.dhall-lang.org/List/map 
   let concatMapSep = http://prelude.dhall-lang.org/Text/concatMapSep
in let bash-link = (λ(l : ./Link ) → "ln -sf ${l.i} ${l.o}") -- "ln -sf '${l.i}' '${l.o}'"
in let links = 
   [ { o = "~/.bashrc" ,		i = "./.bashrc" }
   , { o = "~/.gitconfig" ,		i = "./.gitconfig" }
   , { o = "~/.stack/config.yaml" ,	i = "./stack/config.yaml" }
   , { o = "~/.nixpkgs/config.nix" ,	i = "./nix/config.nix" }
   , { o = "~/.xbindkeysrc.scm" ,	i = "./xbindkeys/.xbindkeysrc.scm" }
   ] : List ./Link 
in (concatMapSep
    "\n"
    ./Link 
    bash-link
    links)

-- intercalate
-- ./concatMapSep ", " Integer Integer/show [0, 1, 2] = "0, 1, 2"
