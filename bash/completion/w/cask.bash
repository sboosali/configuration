#!/bin/env bash

##################################################

# « cask » command-line completion
#
# GPL-3.0-or-later © 2019 "Sam Boosalis" <samboosalis@gmail.com>

##################################################
# Notes:

# $ cask --help
#
# USAGE: cask [COMMAND] [OPTIONS]
#
# Emacs dependency management made easy
#
# COMMANDS:
#
#  pkg-file                                Write a ‘define-package’ file.
#
#                                          The file is written to the Cask project root path with name
#                                          {project-name}-pkg.el.
#  install                                 Install all packages specified in the Cask-file.
#
#                                          The dependencies to packages are also installed.  If a package
#                                          already is installed, it will not be installed again.
#  update                                  Update package versions.
#
#                                          All packages that are specified in the Cask-file will be updated
#                                          including their dependencies.
#  upgrade                                 Upgrade Cask itself and its dependencies.
#
#                                          This command requires that Cask is installed using Git and that
#                                          Git is available in ‘exec-path’.
#  upgrade-cask                            Upgrade Cask itself and its dependencies.
#
#                                          This command requires that Cask is installed using Git and that
#                                          Git is available in ‘exec-path’.
#  exec [*]                                Execute ARGS with correct ‘exec-path’ and ‘load-path’.
#  init                                    Initialize the current directory with a Cask-file.
#
#                                          By default, the created Cask-file will be for an Emacs
#                                          configuration.  If the --dev option is specified, the Cask-file
#                                          will be for an Emacs package.
#  version                                 Print version for the current project.
#  list                                    List this package dependencies.
#  info                                    Show info about the current package.
#  help [command]                          Display usage information or documentation for COMMAND-NAME.
#  load-path                               Print ‘load-path’ for all packages and dependencies.
#
#                                          The output is formatted as a colon path.
#  exec-path                               Print ‘exec-path’ for all packages and dependencies.
#
#                                          A dependency will be included in this list of the package has a
#                                          directory called bin in the root directory.
#
#                                          The output is formatted as a colon path.
#  eval <form>                             Eval FORM with the ‘load-path’ set according to the project.
#  path                                    Print ‘exec-path’ for all packages and dependencies.
#
#                                          A dependency will be included in this list of the package has a
#                                          directory called bin in the root directory.
#
#                                          The output is formatted as a colon path.
#  package-directory                       Print current package installation directory.
#  outdated                                Print list of outdated packages.
#
#                                          That is packages that have a more recent version available for
#                                          installation.
#  files                                   Print list of files specified in the files directive.
#
#                                          If no files directive or no files, do nothing.
#  build                                   Build all Elisp files in the files directive.
#  clean-elc                               Remove all byte compiled Elisp files in the files directive.
#  link [*]                                Manage links.
#
#                                          A link is just that, a symbolic link.  The purpose of the link
#                                          command is that you should be able to work with local
#                                          dependencies.
#
#                                          For example, let’s say you are developing an Emacs package that
#                                          depends on f.el. Consider what happens if you need to extend f.el
#                                          with some function that your package requires.
#
#                                          With the link command, you can checkout f.el locally, add it as a
#                                          link in your local package.  That means that when you require
#                                          f.el, you will require the local package instead of the one
#                                          fetched from the ELPA mirror.  Now you add the desired function
#                                          to f.el and use your library to try it out.
#
#                                          COMMAND-OR-NAME can be one of: delete, list or a link name.
#                                          ARG is sent to some of the commands.
#
#                                          Commands:
#
#                                           $ cask link list
#
#                                            List all project links.
#
#                                           $ cask link name path
#
#                                            Add local link with NAME to PATH.
#
#                                           $ cask link delete name
#
#                                            Delete local link with NAME.
#  package [target-dir]                    Build package and put in TARGET-DIR or dist if not specified.
#  emacs [*]                               Execute emacs with the appropriate environmment.
#
# OPTIONS:
#
#  --proxy <host>                          Set Emacs proxy for HTTP and HTTPS to HOST.
#  --http-proxy <host>                     Set Emacs proxy for HTTP to HOST.
#  --https-proxy <host>                    Set Emacs proxy for HTTPS to HOST.
#  --no-proxy <host>                       Set Emacs no-proxy to HOST.
#  --version                               Print Cask’s version.
#  -h [command], --help [command]          Display usage information or documentation for COMMAND-NAME.
#  --dev                                   Run in dev mode.
#  --debug                                 Turn on debug output.
#  --path <path>                           Run command in this PATH instead of in ‘default-directory’.
#  --verbose                               Be verbose and do not hide output.
#

##################################################
# Code:

_cask_subcommands=( )

_cask_subcommands+=( "pkg-file" )
_cask_subcommands+=( "install" )
_cask_subcommands+=( "update" )
_cask_subcommands+=( "upgrade" )
_cask_subcommands+=( "upgrade-cask" )
_cask_subcommands+=( "exec" )
_cask_subcommands+=( "init" )
_cask_subcommands+=( "version" )
_cask_subcommands+=( "list" )
_cask_subcommands+=( "info" )
_cask_subcommands+=( "help" )
_cask_subcommands+=( "load-path" )
_cask_subcommands+=( "exec-path" )
_cask_subcommands+=( "eval" )
_cask_subcommands+=( "path" )
_cask_subcommands+=( "package-directory" )
_cask_subcommands+=( "outdated" )
_cask_subcommands+=( "files" )
_cask_subcommands+=( "build" )
_cask_subcommands+=( "clean-elc" )
_cask_subcommands+=( "link" )
_cask_subcommands+=( "package" )
_cask_subcommands+=( "emacs" )

#------------------------------------------------#

_cask_options=( )

_cask_options+=( "-h" "--help" )
_cask_options+=(      "--version" )
_cask_options+=(      "--proxy" )
_cask_options+=(      "--http-proxy" )
_cask_options+=(      "--https-proxy" )
_cask_options+=(      "--no-proxy" )
_cask_options+=(      "--dev" )
_cask_options+=(      "--debug" )
_cask_options+=(      "--path" )
_cask_options+=(      "--verbose" )

#------------------------------------------------#

complete -W "${_cask_subcommands[*]} ${_cask_options[*]}" cask
