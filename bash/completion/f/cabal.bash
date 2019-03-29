#!/bin/env bash

##################################################

# cabal command line completion
#
# Copyright 2007-2008 "Lennart Kolmodin" <kolmodin@gentoo.org>
#                     "Duncan Coutts"    <dcoutts@gentoo.org>
#                     "Sam Boosalis"     <samboosalis@gmail.com>
#

# Compatibility — Bash 3.
#
# OSX won't update Bash 3 (last updated circa 2009) to Bash 4,
# and we'd like this completion script to work on both Linux and Mac.
#
# For example, OSX Yosemite (released circa 2014) ships with Bash 3:
#
#  $ echo $BASH_VERSION
#  3.2
#
# While Ubuntu LTS 14.04 (a.k.a. Trusty, also released circa 2016)
# ships with the latest version, Bash 4 (updated circa 2016):
#
#  $ echo $BASH_VERSION
#  4.3
#

# Testing
#
# (1) Invoke « shellcheck »
#
#     * source: « https://github.com/koalaman/shellcheck »
#     * run:    « shellcheck ./cabal-install/bash-completion/cabal »
#
# (2) Interpret via Bash 3
#
#     * source: « https://ftp.gnu.org/gnu/bash/bash-3.2.tar.gz »
#     * run:    « bash --noprofile --norc ./cabal-install/bash-completion/cabal »
#
# 

##################################################
# Dependencies:

command -v cabal  >/dev/null
command -v grep   >/dev/null
command -v sed    >/dev/null

##################################################

#TODO#...

# _cabal_list_all_targets()
# _cabal_list_library_targets()
# _cabal_list_executable_targets()
# _cabal_list_test_targets()
# _cabal_list_bench_targets()

##################################################

# List cabal targets by type, pass:
#
#   - ‹test-suite› for test suites
#   - ‹benchmark› for benchmarks
#   - ‹executable› for executables
#   - ‹library› for the library (and for internal libraries)
#   - ‹foreign-library› for foreign libraries
#   - nothing for all components.
#

_cabal_list_targets()

(
    shopt -s nullglob

    # ^ NOTE « _cabal_list_targets » must be a subshell to temporarily enable « nullglob ».
    #        hence, « function _ () ( ... ) » over « function _ () { ... } ».
    #        without « nullglob », if a glob-pattern fails, it becomes a literal
    #        (i.e. the string with an asterix, rather than an empty string).

    local CabalComponents
    CabalComponents=${1:-library|executable|test-suite|benchmark|foreign-library}

    # ^ default argument to all components.

    #--------------------------#

    local ArgumentList
    { IFS="|" read -r -a ArgumentList <<< "$CabalComponents"; }

    # ^ Split « $@ » into Bash array on « | » delimiter.

    local CabalFiles
    CabalFiles=( ./*.cabal ./*/*.cabal ./*/*/*.cabal )

    # ^ look for « .cabal » files in the current directory, subdirectories, and sub-subdirectories.

    #--------------------------#

    local FILE
    for FILE in "${CabalFiles[@]}"
    do

        grep -E -i "^[[:space:]]*($CabalComponents)[[:space:]]" "$FILE" 2>/dev/null  |  sed -e "s/.* \([^ ]*\).*/\1/"  |  sed -e '/^$/d'

    done | sort | uniq

    #--------------------------#

    local ComponentType
    local Package
    local Components
    local Component

    for ComponentType in "${ArgumentList[@]}"
    do

        case "$ComponentType" in

            library)
                
                for FILE in "${CabalFiles[@]}"
                do

                    Package=$(_cabal_get_package_from_file "$(grep -l -i "^library[[:space:]]*" "$FILE" 2>/dev/null)")

                    if [ -n "$Package" ]
                    then
                        echo "$Package"
                        echo "lib:$Package"
                    fi

                done

                # ^ non-internal libraries are named as the basename of the « .cabal » file they're in.
                #   but not all « .cabal » files have a « library » stanza.

                ;;

            executable|test-suite|benchmark|foreign-library)

                for FILE in "${CabalFiles[@]}"
                do

                    Components=$(grep -E -i "^[[:space:]]*${ComponentType}[[:space:]]" "$FILE" 2>/dev/null  |  sed -e "s/.* \([^ ]*\).*/\1/"  |  sed -e '/^$/d')

                    for Component in ${Components}
                    do

                        if [ -n "$Component" ]
                        then
                            echo "$Component"
                            echo "$(_cabal_abbreviate_component_type "$ComponentType"):$Component"
                        fi
                    done

                done

                # ^ non-internal libraries are named as the basename of the « .cabal » file they're in.
                #   but not all « .cabal » files have a « library » stanza.

                ;;

        esac

    done | sort | uniq

    #--------------------------#



    #--------------------------#

)

# NOTES
#
# (1) in « sed '/^$/d' »:
#
#     * « d » is the sed command to delete a line.
#     * « ^$ » is a regular expression matching only a blank line
#       (i.e. a line start followed by a line end).
#
#     dropping blank lines is necessary to ignore public « library » stanzas,
#     while still matching private « library _ » stanzas.
#
# (2) in « grep -l »:
#
#     * the « -l » options prints only the filename (not the match).
#
# (3) in « »:
#
#     * duplicates the stream (each line of stdin becomes two lines of stdout)
#
# (3) in « printf '%s\n' »:
#
#     * prints each element of a bash array on a separate line.

#TODO#
# grep -l -i "^library[[:space:]]*" "$FILE" 2>/dev/null  |  sed -e 's/^/lib:/'

#TODO# rm duplicate components and qualify with « PACKAGE: » (from basename):
#
# $ .. | sort | uniq

#TODO# don't output these:
# lib:          library  

##################################################

# Abbreviate a component: from the stanza in a « .cabal » file
# to the abbreviation on the commandline.
#
# e.g.:
#
#  $ _cabal_abbreviate_component_type "foreign-library" 
#  flib
#

_cabal_abbreviate_component_type()

{

    Component=${1:-""}

    local Abbreviation

    case $Component in

        "library")
            Abbreviation="lib"
            ;;
        "executable")
            Abbreviation="exe"
            ;;
        "test-suite")
            Abbreviation="test"
            ;;
        "benchmark")
            Abbreviation="bench"
            ;;
        "foreign-library")
            Abbreviation="flib"
            ;;
        *)
            Abbreviation=""
            ;;
    esac

    [ -n "$Abbreviation" ] && echo "$Abbreviation"

}

##################################################

# Extract the package name from a « .cabal » file.
#
# e.g.:
#
#  $ _cabal_get_package_from_file "./cabal-install/cabal-install.cabal"
#  cabal-install
#
#  $ _cabal_get_package_from_file cabal-install
#  cabal-install
#

_cabal_get_package_from_file()

{
    local PACKAGE
    local BASENAME

    BASENAME=$(basename "$1")
    PACKAGE="${BASENAME%.cabal}"

    echo "$PACKAGE"
}

# NOTES
#
# (1) « "${string%suffix}" » strips « suffix » from « string »,
#     in pure Bash.
#
# (2) « basename » and « "${_%.cabal}" »:
#
#     * extracts the filename, without directory or extension.
#

##################################################

# List project-specific (/ internal) packages:
#

_cabal_list_packages()

(
    shopt -s nullglob

    local CabalFiles
    CabalFiles=( ./*.cabal ./*/*.cabal ./*/*/*.cabal )

    for FILE in "${CabalFiles[@]}"
    do

        _cabal_get_package_from_file "$FILE"

    done | sort | uniq
)

# NOTES
#
# (1) « ... done | sort | uniq » removes duplicates from the output of the for-loop.
#

##################################################

# List known (/ external) packages:
#

_cabal_list_external_packages()

{

    cabal list --simple-output  |  cut -d " " -f1  |  uniq
}

##################################################

# List known repositories:
#

_cabal_list_repositories()

(
    shopt -s nullglob

    #--------------------------#

    local ProjectFiles
    ProjectFiles=( ./*.project )

    # ^ look for « .project » files in the current directory.

    #--------------------------#
    # builtin repositores:
    
    echo "hackage.haskell.org"

    #--------------------------#
    # custom repositores:

    local FILE
    for FILE in "${ProjectFiles[@]}"
    do

        grep -E -i "^repository[[:space:]]" "$FILE" 2>/dev/null  |  sed -e "s/.* \([^ ]*\).*/\1/"  |  sed -e '/^$/d'

    done | sort | uniq

    #--------------------------#
)

# NOTES
#
# (1) « *.project » files may have « repository ... » stanzas
#
# (2)
#

##################################################

# List possible targets depending on the command supplied as parameter.  The
# ideal option would be to implement this via --list-options on cabal directly.
# This is a temporary workaround.
#

_cabal_targets()

{
    local Word
    for Word in "$@"
    do

        [ "$Word" == new-build   ] && _cabal_list_targets              && break
        [ "$Word" == new-repl    ] && _cabal_list_targets              && break
        [ "$Word" == new-run     ] && _cabal_list_targets "executable" && break
        [ "$Word" == new-test    ] && _cabal_list_targets "test-suite" && break
        [ "$Word" == new-bench   ] && _cabal_list_targets "benchmark"  && break
        [ "$Word" == new-haddock ] && _cabal_list_targets              && break

        [ "$Word" == new-update ]  && _cabal_list_repositories         && break

      # [ "$Word" == new-install ] && _cabal_list_external_packages    && break
      # [ "$Word" == new-exec ]    && _cabal_list_delegatable_programs && break

        [ "$Word" == build       ] && _cabal_list_targets "executable|test-suite|benchmark" && break
        [ "$Word" == repl        ] && _cabal_list_targets "executable|test-suite|benchmark" && break
        [ "$Word" == run         ] && _cabal_list_targets "executable"                      && break
        [ "$Word" == test        ] && _cabal_list_targets            "test-suite"           && break
        [ "$Word" == bench       ] && _cabal_list_targets                       "benchmark" && break

    done
}

# NOTES
#
# (1) « $@ » will be the full command-line (so far).
#
# (2)
#

##################################################

# List possible subcommands of a cabal subcommand.
#
# In example "sandbox" is a cabal subcommand that itself has subcommands. Since
# "cabal --list-options" doesn't work in such cases we have to get the list
# using other means.
#

_cabal_subcommands()

{
    local word
    for word in "$@"; do
        case "$word" in
          sandbox)
            # Get list of "cabal sandbox" subcommands from its help message.
            "$1" help sandbox |
            sed -n '1,/^Subcommands:$/d;/^Flags for sandbox:$/,$d;/^ /d;s/^\(.*\):/\1/p'
            break  # Terminate for loop.
            ;;
        esac
    done
}

##################################################

_cabal_has_doubledash()

{
    local c=1
    # Ignore the last word, because it is replaced anyways.
    # This allows expansion for flags on "cabal foo --",
    # but does not try to complete after "cabal foo -- ".
    local n=$((${#COMP_WORDS[@]} - 1))
    while [ $c -lt $n ]; do
        if [ "--" = "${COMP_WORDS[c]}" ]; then
            return 0
        fi
        ((c++))
    done
    return 1
}

##################################################

# shellcheck disable=SC2207
_cabal()

{
    # no completion past cabal arguments.
    _cabal_has_doubledash && return

    #--------------------------#

    local CompletionsString
    local CompletionsArray

    {

        CompletionsString="${COMP_WORDS[*]}"
        CompletionsString="${CompletionsString// : /:}"

        { IFS=" " read -r -a CompletionsArray <<< "$CompletionsString"; }

        # ^ merge colon-separated tokens.
        #
        #   e.g. « ( "cabal" "new-test" "spiros" ":" "test" ":" "unit" ) » becomes
        #        « ( "cabal" "new-test" "spiros:test:unit" ) ».
        #
    }

    #--------------------------#

    local COMP_WORDS_LENGTH
    local CompletionsLength
    local LengthDifference
    local CurrentIndex

    {

        COMP_WORDS_LENGTH="${#COMP_WORDS[@]}"
        CompletionsLength="${#CompletionsArray[@]}"

        LengthDifference=$(( COMP_WORDS_LENGTH - CompletionsLength ))

        CurrentIndex=$(( COMP_CWORD - LengthDifference ))

        # ^ adjust index:
        #
        #   e.g. the last index in « ( "cabal" "new-test" "Cabal" ":" "test" ":" ) », i.e. « 5 »,
        #        becomes « 2 » in « ( "cabal" "new-test" "Cabal:test:" ) ». but,
        #        the first index in « ( "cabal" "new-test" "Cabal" ":" "test" ":" ) », i.e. « 0 »,
        #        remains « 0 » in « ( "cabal" "new-test" "Cabal:test:" ) ».
        #
    }

    #--------------------------#

    # get the word currently being completed:
    local CurrentWord

    CurrentWord=${CompletionsArray[$CurrentIndex]}
    #CurrentWord=${COMP_WORDS[$COMP_CWORD]}

    #DEBUGGING# (mkdir -p  ~/.cache/cabal; for COMP_WORD in "${COMP_WORDS[@]}"; do printf '%s\n' "$COMP_WORD"; done >> ~/.cache/cabal/COMP_WORDS.txt)

    #--------------------------#

    # create a « cabal ... --list-options » command line to « eval »:
    local CommandLine

    # copy all words the user has entered:
    CommandLine=( "${CompletionsArray[@]}" )

    # replace the current word with « --list-options »:
    CommandLine[${CurrentIndex}]="--list-options"

    #--------------------------#

    # register completions via the « COMPREPLY » array:

    COMPREPLY=( $( compgen -W "$( eval "${CommandLine[@]}" 2>/dev/null ) $( _cabal_targets "${CompletionsArray[@]}" ) $( _cabal_subcommands "${CompletionsArray[@]}" )" -- "$CurrentWord" ) )

    #TODO#
    # COMPREPLY=()
    # while IFS='' read -r line; do array+=("$line"); done < <( compgen -W "$( eval "${CommandLine[@]}" 2>/dev/null ) $( _cabal_targets "${CommandLine[@]}" ) $( _cabal_subcommands "${COMP_WORDS[@]}" )" -- "$CurrentWord" )

    #--------------------------#
}

# NOTES
#
# (1) e.g.:
#
#       $ abc="a b c"
#       $ { IFS=" " read -r -a ExampleArray <<< "$abc"; echo ${ExampleArray[@]}; echo ${!ExampleArray[@]}; }
#       a b c
#       0 1 2
#
# (2) e.g. « compgen -W »:
#
#       $ compgen -W "build run new-build new-run" -- new
#       new-build
#       new-run
#
# (3) TODO «  »:
#
#     * by default, in « cabal new-build lib:<TAB> »,
#       « ${COMP_WORDS[$COMP_CWORD]} » is « : » (not « lib: »),
#       which prevents correctly completing it.
#     * e.g. the « ${COMP_WORDS[@]} » of « cabal new-test spiros:test:unit » is
#       « ( "cabal" "new-test" "spiros" ":" "test" ":" "unit" ) », but should be
#       « ( "cabal" "new-test" "spiros:test:unit" ) ».
# 
# (4) « ${var//xxx/yyy} »:
#
#     * Replaces all substrings « xxx » with string « yyy » in variable « $var ».
#

##################################################

# register the completion script via the « complete » builtin:

complete -F _cabal -o default cabal