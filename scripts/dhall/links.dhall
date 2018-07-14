   let map = ./Prelude/List/map 
in let quote = λ(t : Text) → "\"${t}\""
in let link-to-string = λ(l : ./Link) → "${quote l.i}:${quote l.o}"

-- input `i` (i.e. the source w.r.t ln)
-- output `o` (i.e. the link w.r.t ln)
in let links = 
   [ { o = "~/.bashrc" ,                                 i = "./bash/.bashrc"                           }
   , { o = "~/.aliases" ,                                i = "./bash/.aliases"                          }
   , { o = "~/.profile" ,                                i = "./bash/.profile"                          }
   , { o = "~/.bash_definitions.sh" ,                       i = "./bash/.bash_definitions.sh"                 }
   , { o = "~/.bash_settings.sh" ,                          i = "./bash/.bash_settings.sh"                    }
   , { o = "~/.bash_logout" ,                            i = "./bash/.bash_logout"                      }

   , { o = "~/.gitconfig" ,                              i = "./git/.gitconfig"                         }
   , { o = "~/.git-prompt.sh" ,                          i = "./bash/.git-prompt.sh"                    }

   , { o = "~/.config/nixpkgs/config.nix" ,                     i = "./nix/config.nix"                         }
   , { o = "~/.nix-channels" ,                           i = "./nix/nix-channels.txt"                   }
--   , { o = "~/.config/nixpkgs/overlays.nix" ,                     i = "./nix/overlays.nix"                         }
--  , { o = "~/.config/nixpkgs/overlays/haskell.nix" ,                     i = "./nix/overlays/haskell.nix"                         } 
--  , { o = "/etc/nix/nix.conf" ,                     i = "./nix/global-nix.conf"                      --  , { o = "~/.config/nixpkgs/overlays/" ,                     i = "./nix/overlays/haskell.nix"                         } 
   }


   , { o = "~/.xbindkeysrc.scm" ,                        i = "./xbindkeys/.xbindkeysrc.scm"             }

   , { o = "~/.Xmodmap" ,                                i = "./xmodmap/.Xmodmap"                       }

--   , { o = "~/.xprofile" ,                                i = "./x11/.xprofile"                       }

   , { o = "~/.ghci" ,                                   i = "./ghci/ghci.conf"                         }
   , { o = "~/.cabal/config" ,                           i = "./cabal/config.yaml"                      }
   , { o = "~/.stack/config.yaml" ,                      i = "./stack/config.yaml"                      }
   , { o = "~/.stack/templates/spirosboosalis.hsfiles" , i = "./stack/templates/spirosboosalis.hsfiles" }

   ] : List ./Link

in map ./Link Text link-to-string links
