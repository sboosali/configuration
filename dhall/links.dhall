   let map = ./Prelude/List/map 
in let quote = λ(t : Text) → "\"${t}\""
in let link-to-string = λ(l : ./Link) → "${quote l.i}:${quote l.o}"

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

in map ./Link Text link-to-string links
