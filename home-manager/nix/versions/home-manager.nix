
{
    # Local:

    submodule = builtins.toString ../../../submodules/home-manager;
    fork      = builtins.toString ~/src/sboo/home-manager;

    # Remote:

    v19_03 = builtins.toString https://github.com/rycee/home-manager/archive/release-19.03.tar.gz;
    v18_09 = builtins.toString https://github.com/rycee/home-manager/archive/release-18.09.tar.gz;

#    fork   = builtins.toString ~/src/sboo/home-manager/xbindkeys/home-manager;
}