   let map = ./Prelude/List/map 
in let link-to-list = (λ(l : ./Link) → [l.o, l.i]) -- "${l.i} ${l.o}"

-- input `i` (i.e. the source w.r.t ln)
-- output `o` (i.e. the link w.r.t ln)
in let links = 
   [ { o = "~/.bashrc" ,                                 i = "./bash/.bashrc"                           }
   , { o = "~/.profile" ,                                i = "./bash/.profile"                          }
   , { o = "~/.bash_definitions" ,                       i = "./bash/.bash_definitions"                 }
   , { o = "~/.bash_settings" ,                          i = "./bash/.bash_settings"                    }

   , { o = "~/.gitconfig" ,                              i = "./git/.gitconfig"                         }

   , { o = "~/.nixpkgs/config.nix" ,                     i = "./nix/config.nix"                         }
   , { o = "~/.nix-channels" ,                           i = "./nix/nix-channels.txt"                   }

   , { o = "~/.xbindkeysrc.scm" ,                        i = "./xbindkeys/.xbindkeysrc.scm"             }

   , { o = "~/.Xmodmap" ,                                i = "./xmodmap/.Xmodmap"                       }

   , { o = "~/.ghci" ,                                   i = "./ghci/ghci.conf"                         }
   , { o = "~/.cabal/config" ,                           i = "./cabal/config.yaml"                      }
   , { o = "~/.stack/config.yaml" ,                      i = "./stack/config.yaml"                      }
   , { o = "~/.stack/templates/spirosboosalis.hsfiles" , i = "./stack/templates/spirosboosalis.hsfiles" }

   ] : List ./Link 

in map ./Link (List Text) link-to-list links

--   let map = http://prelude.dhall-lang.org/List/map in

-- intercalate
-- ./concatMapSep ", " Integer Integer/show [0, 1, 2] = "0, 1, 2"

-- Only primitive values can be translated from Dhall to a Bash
expression
