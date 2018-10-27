#!/usr/bin/bash

##################################################

RawSuggestions=('.emacs.d' '.emacs.d-windows' '.xmonad' '1001-Haskell-Examples' 'agda' 'amazonka-example' 'attack' 'automation' 'basilisk' 'bricki-reflex' 'cabal2nix' 'capabilities' 'card-search' 'cards' 'cfg' 'chart-parsers' 'chrome-extensions' 'clipboard-history' 'clojure' 'code-by-voice' 'commands' 'commands-backends-osx9' 'commands-core' 'commands-frontend-DragonNaturallySpeaking' 'commands-frontend-NSSpeechRecognizer' 'commands-frontends-dragon13' 'commands-hari' 'commands-osx' 'commands-quickstart' 'commands-server' 'commands-server-featured' 'commands-server-simple' 'commands-server-types' 'commands-servers' 'commands-spiros' 'commands-windows' 'CommandsWindows' 'company-cabal' 'compiler' 'composite' 'config' 'configuration' 'coq' 'd3' 'data-reify' 'deepart-stuff' 'derive-monoid' 'desktop-entry-files' 'diagrams-example' 'dictation' 'dragon-naturally-speaking' 'Earley' 'eight' 'electron-quick-start' 'elm' 'emacs-module' 'emacs-native' 'Emacs-SPDX' 'emacs-web-server' 'emacs_chrome' 'enumerate' 'enumerate-function' 'etc' 'example-Haskell-NSSpeechRecognizer' 'Example-LightTable-Plugin' 'example-nix' 'example-reified-bindings' 'examples-ghc-eight' 'export' 'Expresso' 'fltkhs' 'fltkhs-demos' 'fltkhs-reflex-host' 'fltkhs2' 'frisby' 'genovation-control-pad' 'ghc' 'google-cloud-speech' 'google2ubuntu' 'grpc-haskell' 'guide' 'haddock' 'haskelisp-0.1.1.0-MIRROR' 'haskell' 'Haskell-DragonNaturallySpeaking' 'haskell-emacs' 'haskell-emacs-module' 'haskell-from-python' 'haskell-functional-parsing' 'haskell-ide-engine' 'Haskell-Memoize' 'Haskell-NSSpeechRecognizer' 'haskell-project-mode' 'haskell-project-nix' 'Haskell-Server-Generic-Library' 'haskellProject' 'haxml' 'HaXml2' 'haxr' 'helm' 'hnix' 'hnotes' 'hpmor' 'hs-msgpack' 'hs-msgpack-rpc' 'idioms-plugins' 'Iosevka' 'joymacs' 'kbd' 'lens' 'lens-cabal' 'lighttable-settings' 'lts6' 'magic-card-editor' 'magic-card-search' 'magic-card-search-OLD' 'mana-cost' 'mandimus' 'melpa' 'MemoTrie' 'microphone' 'MiniKanrenT' 'mtg' 'much-of-hackage' 'music' 'my-reflex-example' 'NatLink' 'natlink-uniiform2-dns15' 'nix' 'nix-config' 'nix-packages' 'nixpkgs' 'nixpkgs-stackage' 'notes' 'NSSpeechRecognizer' 'NSSpeechRecognizer-workflow' 'NSTypes' 'options-monoid' 'Palimpsest' 'PGM' 'pipes-process' 'plugins' 'polyparse' 'project-euler' 'project2nix' 'proto-lens' 'python-notes' 'radix-tree' 'rank2' 'recursion-schemes' 'refined' 'refined-extra' 'reflex' 'reflex-audio' 'reflex-basic-host' 'reflex-dom' 'reflex-dom-widgets' 'reflex-fltk' 'reflex-host' 'reflex-jsx' 'reflex-native' 'reflex-platform' 'reflex-vinyl' 'reified-bindings' 'rl' 's-expression' 'sapi' 'sboo-blog' 'sboo-nix' 'sboosali.github.io' 'scala' 'schematic' 'simple-plugins' 'skeletor' 'speech-recognition' 'spiros' 'stable-maps' 'stack' 'stackage' 'stuff' 'styx' 'TBS' 'truthiness' 'validation-warning' 'Vinyl' 'vinyl-class' 'vinyl-contrib' 'vinyl-effects' 'vinyl-fields' 'vinyl-generics' 'vinyl-sum' 'wagon-challenge' 'wave' 'windows-playground' 'workflow' 'workflow-extra' 'workflow-osx' 'workflow-pure' 'workflow-types' 'workflow-windows' 'workflow-x11' 'workflow-x11-shell' 'WorkflowObjC' 'wreq' 'wxHaskell' 'X11' 'xmlrpc')

# ^ Space-Separated Values
# (« github-repositories-sboosali.txt » holds Line-Separated Values.)

##################################################

_sboo-github-clone-sboosali_completions() {

    # if [ "${#COMP_WORDS[@]}" != "2" ]; then
    #     return
    # fi
    # # ^ TODO why?

    CurrentPrefix="${COMP_WORDS[${COMP_CWORD}]:-''}"

    # ^ « $COMP_WORDS »: all words that have been entered (after the program name); an array.
    # ^ « $COMP_CWORD »: the current word; an index into « $COMP_WORDS ».

    SuffixSuggestions_String="$(compgen -W "${RawSuggestions[*]}" "$CurrentPrefix" | tr '\n' ' ')"

    # ^ NOTE « compgen » returns a Bash-String,
    # **not** a Bash-Array, like « RawSuggestions » is.

    # ^ Tokenizes by « $IFS »; the default is any whitespace (spaces, tabs, or lines).

    # ^ NOTE « ${A[*]} », not « ${A[@]} ».

    IFS=' ' read -r -a SuffixSuggestions <<< "${SuffixSuggestions_String}"

    # #DEBUGGING:
    # echo -e '\n----------------------------------------\n'
    # echo "${SuffixSuggestions[*]}"
    # echo -e '\n----------------------------------------\n'

    # ^ Parse a Bash-String into a Bash-Array, splitting upon any character in « $IFS ».

    if [ "${#SuffixSuggestions[@]}" == "1" ]
    then # if only one suggestion exists, complete it.

        local Suggestion="${SuffixSuggestions[0]/%\ */}"
        COMPREPLY=("$Suggestion")

    else # if multiple suggestions exist (or if none do), print one per line.

        for i in ${!SuffixSuggestions[*]}
        do

            PaddedSuggestions[$i]="$(printf '%*s' "-${COLUMNS:-80}" "${SuffixSuggestions[$i]}")"

        done

        # ^ NOTE « ${!A[*]} » is a new Bash-Array, whose values are:
        # * the **indices** of a Bash-Array « A »;
        # * the **keys** of a Bash-Mapping « A »;

        # ^ `printf '%*s' -<N> ...`  is equivalent to `printf '%<N>s' ...`

        # ^ Pad by Terminal Emulator's current width,
        # as a "hack", to pretty-print one suggestion per line.

        # #DEBUGGING:
        # echo -e '\n----------------------------------------\n'
        # echo "${PaddedSuggestions[*]}"
        # echo -e '\n----------------------------------------\n'

        # #DEBUGGING:
        # echo -e '\n----------------------------------------\n'
        # echo "${#PaddedSuggestions[0]}"
        # echo -e '\n----------------------------------------\n'

        COMPREPLY=("${PaddedSuggestions[@]}") 

        # ^ « COMPREPLY » is a Bash-Array.

        # ^ NOTE « B=("${A[@]}") » copies Bash-Array `A` into (a new) Bash-Array `B`
        # (both the parentheses and the quotation are necessary).

    fi
}

# ^ test with (for example):
#
# $ (echo -e '\n----------------------------------------\n' && export COMP_WORDS=(com work) && _sboo-github-clone-sboosali_completions && declare -p COMPREPLY && echo -e '\n----------------------------------------\n' && echo "${COMPREPLY[*]}" && echo -e '\n----------------------------------------\n' && (for completion in ${COMPREPLY[*]}; do echo "${completion}"; done) && echo -e '\n----------------------------------------\n')
#

##################################################

complete -F _sboo-github-clone-sboosali_completions sboo-github-clone-sboosali

##################################################

# #!/usr/bin/bash
# set -e
# #set -u
# set -m

# RawSuggestions=$(sboo-github-list-repositories)
# RawSuggestions=$(sboo-github-list-repositories)

# echo "${SuffixSuggestions_String}" | tr '\n' ' ' 

# NumberOfSuggestions=${#SuffixSuggestions[*]}
# # ^ NOTE « ${#A[*]} » gets the length of array « A ».

# SuffixSuggestions=$(IFS=$'\n' compgen -W "${RawSuggestions}" "$CurrentPrefix")

 # declare -p SuffixSuggestions
 # echo ${SuffixSuggestions[*]}

# TerminalWidth="${COLUMNS:-80}"

##################################################