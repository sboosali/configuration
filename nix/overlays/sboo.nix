self: super:

/* USAGE

Bootstrap:

   nix-env -f '<nixpkgs>' -iA sboo.pkgs

Installation: 

    # safe
    nix-home-install
    
    # "unsafe" (may require `nix-rollback` if you corrupt your user-environment)
    nix-home-rebuild

Testing:

    nix-home-test

*/

/* BOOTSTRAPPING NOTES

Bootstrap with:

    nix-env -f '<nixpkgs>' -iA lnl

Warning:

`nix-rebuild-pure` (it differs from `nix-rebuild` by adding the `-r` option)
provides user environment management that is completely/"actually" declarative: 
it nukes the rest of your path. i.e.

    $ nix-env -f '<nixpkgs>' -r -iA lnl
    $ find .nix-profile/bin/
    # everything you nix-installed (`nix-env -i`)
    ...
    $ nix-env -f '<nixpkgs>'    -iA lnl
    $ find .nix-profile/bin/
    # only those executables from packages in `lnl` (a package set)
    .nix-profile/bin/
    .nix-profile/bin/nix-rebuild
    .nix-profile/bin/hello

This nuked `nix-env` itself, so I need to manually rollback with:

    $ PREVIOUS_PROFILE=182 # (see below)
    $ /nix/var/nix/profiles/default-"$PREVIOUS_PROFILE"-link/bin/nix-env --rollback

Confirmed with the following (and obviously by running the restored commands in a terminal):

    # "$BAD_SLASH_CURRENT_PROFILE" # (see below)
    $ readlink -f /nix/var/nix/profiles/default-183-link
    /nix/store/8n14ayqq0yqmccdvlr173k8mcklyblg5-user-environment
    
    # "$GOOD_SLASH_PREVIOUS_PROFILE" # (see below)
    $ readlink -f /nix/var/nix/profiles/default-182-link 
    /nix/store/6m0pjlvxkp9b79cn3i66iagixwiic9kv-user-environment
    
    $ readlink -f ~/.nix-profile
    /nix/store/8n14ayqq0yqmccdvlr173k8mcklyblg5-user-environment

    $ nix-env --rollback
    nix-env: command not found
    # ^ lol

    $ /nix/var/nix/profiles/default-182-link/bin/nix-env --rollback
    switching from generation 183 to 182

    $ readlink -f ~/.nix-profile
    /nix/store/6m0pjlvxkp9b79cn3i66iagixwiic9kv-user-environment

    $ nix-env --help

And now we can install these declaratively listed packages 
alongside the other imperatively installed ones:

    # sans `-r`
    $ nix-env -f '<nixpkgs>' -iA lnl
    installing ‘hello-2.10’
    installing ‘nix-rebuild’
    installing ‘nix-rebuild-pure’
    ...
    created 4382 symlinks in user environment

    # "safe"
    $ nix-rebuild
    replacing old ‘hello-2.10’
    replacing old ‘nix-rebuild’
    replacing old ‘nix-rebuild-pure’
    installing ‘hello-2.10’
    installing ‘nix-rebuild’
    installing ‘nix-rebuild-pure’

Some details about nix profiles and the nix store:

    $ ls /nix/store/ | grep user-environment | wc -l
    376

    # but which?

    $ ls ~/.nix-profile/
    # nearly empty

    $ ls /nix/var/nix/profiles/per-user/$USER 
    channels
    channels-1-link 
    channels-2-link 
    ...
    
    $ ls /nix/var/nix/profiles/ | wc -l
    185
    
    $ ls /nix/var/nix/profiles/
    per-user
    default
    default-1-link/ 
    ...
    default-183-link/ 
    
    # sort numerically on the second "field" (not lexicographically on the whole)
    $ find /nix/var/nix/profiles/ -maxdepth 1 | grep -E 'default-[0-9]+-link' | sort -n -t'-' -k 2,2
    default-1-link/ 
    ...
    default-183-link/ 
    
    # get the two most recent generations
    $ find /nix/var/nix/profiles/ -maxdepth 1 | grep -E 'default-[0-9]+-link' | sort -n -t'-' -k 2,2 | tail -n2
    /nix/var/nix/profiles/default-182-link
    /nix/var/nix/profiles/default-183-link
    
    # confirm that the previous generation is correct...
    
    ~$ find /nix/var/nix/profiles/default-183-link/ | wc -l
    6
    
    ~$ find /nix/var/nix/profiles/default-182-link/ | wc -l
    4337
    
    GOOD_SLASH_PREVIOUS_PROFILE=/nix/var/nix/profiles/default-182-link
    BAD_SLASH_CURRENT_PROFILE=/nix/var/nix/profiles/default-183-link
    
    $ ls "$BAD_SLASH_CURRENT_PROFILE/bin" | wc -l
    2
    
    $ ls "$BAD_SLASH_CURRENT_PROFILE/bin"
    hello  
    nix-rebuild
    
    ~$ ls "$GOOD_SLASH_PREVIOUS_PROFILE/bin" | wc -l
    505
    
    ~$ ls "$GOOD_SLASH_PREVIOUS_PROFILE/bin"
    2to3
    2to3-3.6
    7z
    7za
    7zr
    aapt
    aapt2
    aarch64-linux-android-ld
    acpi
    adb
    adbfs
    aidl
    android
    animate
    APEv2
    api-startup
    apksigner
    arm-linux-androideabi-ld
    atsa
    audacity
    autoexpect
    autopasswd
    bcc_compat
    bench_cli_ipfs_add
    bin2c
    bq
    cabal
    cabal2nix
    caffe
    cargo
    caudec
    cheese
    chromium
    chromium-browser
    cjpeg
    classification
    clusterdb
    compare
    composite
    compute_image_mean
    computeprof
    conjure
    convert
    convert_cifar_data
    convert_imageset
    convert_mnist_data
    convert_mnist_siamese_data
    createdb
    createuser
    crt
    cryptdir
    cs
    csanalyze
    csb64enc
    csbeats
    csdebugger
    csound
    ctags
    cudafe
    cudafe++
    cuda-gdb
    cuda-gdbserver
    cuda-memcheck
    cuobjdump
    cvanal
    cvlc
    cvs
    cvsbug
    dconf
    dconf-editor
    ddms
    decaude
    decryptdir
    device_query
    dexdump
    dhall
    dhall-format
    dhall-hash
    dhall-to-bash
    dhall-to-json
    dhall-to-nix
    dhall-to-yaml
    dislocate
    display
    djpeg
    dmtracedump
    dnoise
    draw9patch
    dropdb
    dropuser
    dx
    ebrowse
    ecpg
    electron
    elpa2nix
    emacs
    emacs-25.3
    emacsclient
    emulator
    emulator64-arm
    emulator64-crash-service
    emulator64-mips
    emulator64-x86
    emulator-check
    envext
    etags
    etc1tool
    expect
    exrenvmap
    exrheader
    exrmakepreview
    exrmaketiled
    exrmultipart
    exrmultiview
    exrstdattr
    extract
    extract_features
    extractor
    fastboot
    fatbinary
    faust
    faust2alsa
    faust2csound
    faust2firefox
    faust2svg
    faustbench
    faustoptflags
    faustpath
    finetune_net
    firefox
    flac
    fltk-config
    fluid
    fswatch
    ftp-rfc
    function_grep.pl
    funzip
    gcloud
    ghc
    ghc-8.2.2
    ghci
    ghci-8.2.2
    ghcid
    ghc-pkg
    ghc-pkg-8.2.2
    git
    git-credential-gcloud.sh
    git-credential-netrc
    git-cvsserver
    git-http-backend
    gitk
    git-radar
    git-receive-pack
    git-shell
    git-upload-archive
    git-upload-pack
    google-chrome-stable
    go-sleep
    go-timeout
    gpu-library-advisor
    gsutil
    haddock
    haddock-ghc-8.2.2
    het_export
    het_import
    hetro
    hierarchyviewer
    hp2ps
    hpack
    hpc
    hprof-conv
    hsc2hs
    HsColour
    htop
    i686-linux-android-ld
    identify
    idle
    idle3
    idle3.6
    idris
    import
    initdb
    inotifywait
    inotifywatch
    ipfs
    ipfswatch
    ipget
    ivshmem-client
    ivshmem-server
    jobb
    jpegtran
    jq
    kibitz
    lint
    llvm-rs-cc
    lpanal
    lpc_export
    lpc_import
    lpunlock
    mainDexClasses
    makecsd
    ma-pipe-unidir
    mdb_copy
    mdb_dump
    mdb_load
    mdb_stat
    melpa2nix
    metaflac
    mipsel-linux-android-ld
    mixer
    mkpasswd
    mksdcard
    mogrify
    monitor
    monkeyrunner
    montage
    mount.vboxsf
    msiexec
    multixterm
    net_speed_benchmark
    nix-build
    nix-channel
    nix-collect-garbage
    nix-copy-closure
    nix-daemon
    nix-env
    nix-generate-patches
    nix-hash
    nix-install-package
    nix-instantiate
    nix-log2xml
    nix-prefetch-git
    nix-prefetch-url
    nix-pull
    nix-push
    nix-repl
    nix-shell
    nix-store
    notepad
    notify-send
    nox
    nox-review
    nox-update
    nsight
    nsight_ee_plugins_manage.sh
    ntk-chtheme
    ntk-fluid
    nvcc
    nvcc.profile
    nvdisasm
    nvlc
    nvlink
    nvprof
    nvprune
    nvvp
    ocrad
    offline_add
    oid2name
    onboard
    onboard-settings
    pandoc
    passmass
    pat2ppm
    patextract
    pdb
    pdb2.7
    pg_archivecleanup
    pg_basebackup
    pgbench
    pgcli
    pg_config
    pg_controldata
    pg_ctl
    pg_dump
    pg_dumpall
    pg_isready
    pg_receivewal
    pg_recvlogical
    pg_resetwal
    pg_restore
    pg_rewind
    pg_standby
    pg_test_fsync
    pg_test_timing
    pg_upgrade
    pg_waldump
    play
    png2pat
    pocketsphinx_batch
    pocketsphinx_continuous
    pocketsphinx_mdef_convert
    pollEndpoint
    postgres
    postmaster
    psql
    ptxas
    pvanal
    pv_export
    pv_import
    pvlook
    pydoc
    pydoc3
    pydoc3.6
    python
    python2
    python2.7
    python2.7-config
    python2-config
    python3
    python3.6
    python3.6-config
    python3.6m
    python3.6m-config
    python3-config
    python-config
    pyvenv
    pyvenv-3.6
    qbittorrent
    qemu-aarch64
    qemu-alpha
    qemu-arm
    qemu-armeb
    qemu-cris
    qemu-ga
    qemu-hppa
    qemu-i386
    qemu-img
    qemu-io
    qemu-kvm
    qemu-m68k
    qemu-microblaze
    qemu-microblazeel
    qemu-mips
    qemu-mips64
    qemu-mips64el
    qemu-mipsel
    qemu-mipsn32
    qemu-mipsn32el
    qemu-nbd
    qemu-nios2
    qemu-or1k
    qemu-ppc
    qemu-ppc64
    qemu-ppc64abi32
    qemu-ppc64le
    qemu-pr-helper
    qemu-s390x
    qemu-sh4
    qemu-sh4eb
    qemu-sparc
    qemu-sparc32plus
    qemu-sparc64
    qemu-system-aarch64
    qemu-system-alpha
    qemu-system-arm
    qemu-system-cris
    qemu-system-i386
    qemu-system-lm32
    qemu-system-m68k
    qemu-system-microblaze
    qemu-system-microblazeel
    qemu-system-mips
    qemu-system-mips64
    qemu-system-mips64el
    qemu-system-mipsel
    qemu-system-moxie
    qemu-system-nios2
    qemu-system-or1k
    qemu-system-ppc
    qemu-system-ppc64
    qemu-system-ppcemb
    qemu-system-s390x
    qemu-system-sh4
    qemu-system-sh4eb
    qemu-system-sparc
    qemu-system-sparc64
    qemu-system-tricore
    qemu-system-unicore32
    qemu-system-x86_64
    qemu-system-xtensa
    qemu-system-xtensaeb
    qemu-tilegx
    qemu-x86_64
    qvlc
    rcs2log
    rdjpgcom
    rec
    redshift
    redshift-gtk
    regedit
    regsvr32
    reindexdb
    rftp
    rgb2pat
    rlogin-cwd
    runghc
    runghc-8.2.2
    runhaskell
    rvlc
    scale
    scot
    screenshot2
    scsort
    sdif2ad
    seccat
    shellcheck
    smtpd.py
    smtpd.pyc
    smtpd.pyo
    sndinfo
    sound2faust
    sound2file
    sound2reader
    sox
    soxi
    split-select
    sqlite3
    src_conv
    srconv
    stack
    stream
    styx
    svlc
    test_net
    timed-read
    timed-run
    tknewsbiff
    tkpasswd
    traceview
    train_net
    tree
    uiautomatorviewer
    unbuffer
    unzip
    unzipsfx
    upgrade_net_proto_binary
    upgrade_net_proto_text
    upgrade_solver_proto_text
    vacuumdb
    vacuumlo
    VBoxClient
    VBoxClient-all
    VBoxControl
    VBoxService
    virtfs-proxy-helper
    visgrep
    vlc
    vlc-wrapper
    weather
    widl
    wine
    wineboot
    winebuild
    winecfg
    wineconsole
    winecpp
    winedbg
    winedump
    winefile
    wineg++
    winegcc
    winemaker
    winemine
    winepath
    wine-preloader
    wineserver
    wmc
    wmctrl
    wrc
    wrjpgcom
    x86_64-linux-android-ld
    xbacklight
    xbindkeys
    xbindkeys_show
    xbrightness
    xcalib
    xclip
    xclip-copyfile
    xclip-cutfile
    xclip-pastefile
    xdg-desktop-icon
    xdg-desktop-menu
    xdg-email
    xdg-icon-resource
    xdg-mime
    xdg-open
    xdg-screensaver
    xdg-settings
    xdotool
    xinput
    xkibitz
    xmacroplay
    xmacrorec2
    xmodmap
    xmousepos
    xprop
    xpstat
    xrandr-invert-colors
    xte
    xtitle
    xvkbd
    youtube-dl
    zipalign
    zipgrep
    zipinfo

    $ readlink -f "$GOOD_SLASH_PREVIOUS_PROFILE" 
    /nix/store/6m0pjlvxkp9b79cn3i66iagixwiic9kv-user-environment

Testing the environment (before installing it):

    # a package
    $ nix-shell --pure -p lnl.hello

    # the package set
    $ nix-shell --pure -p lnl

*/

########################################
let

inherit (super.lib) attrValues;

# my username
sboo = pkgs // { inherit pkgs env; };

/* i.e.

sboo = {

 hello = _;

 ... 

 pkgs = {
   hello = _ 
   ...             # no `pkgs`
 }; 

 env = buildEnv {
   paths = [
     hello 
     ...           # no `env`
   ]
 };

}

*/

env = super.buildEnv {
  name  = "sboo";
  paths = attrValues pkgs;
};

pkgs = {

 # add these packages to the user-environment
 nix-home-install = super.writeScriptBin "nix-home-install"
  ''
    #! ${self.stdenv.shell}
    exec nix-env -f '<nixpkgs>' -iA sboo.pkgs
  '';

 # replace the user-environment with these packages
 nix-home-rebuild = super.writeScriptBin "nix-home-rebuild"
  ''
    #! ${self.stdenv.shell}
    exec nix-env -f '<nixpkgs>' -r -iA sboo.pkgs
  '';

 # test the user-environment before installation
 # (i.e. what would happen under the strict nix-home-rebuild-pure)

 nix-home-test = super.writeScriptBin "nix-home-test"
  ''
    #! ${self.stdenv.shell}
    nix-shell --pure -p sboo.env
  '';

 #NOTE Add Your Packages Either Here...

 hello = self.hello;
 /*NOTE `self` is correct and not recursive:
 `self.hello` is `nixpkgs.hello` (not `nixpkgs.sboo.hello`)
 */
} // namesakes;

 #NOTE ... Or Here

# namesakes = with self; [ 
#   cabal-install
# ];
#NOTE `self` is safe, just don't call `sboo` itself?

/* same names as `nixpkgs`

*/
namesakes = {
 inherit (self)
  cabal-install
 ;
};

in
########################################
{
 inherit sboo;
}
########################################
