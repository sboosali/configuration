##################################################
{ self }:

##################################################

with self; 

##################################################
let
#------------------------------------------------#

#------------------------------------------------#
in
##################################################
[

  npm                           # JS Package Manager
  webpack                       # JS Build Tool
  webpack-cli                   # JS Build Tool
  eslint                        # JS Linter
  jshint                        # JS Linter
  prettier                      # JS Formatter
  uglify-js                     # JS Minifier
  typescript                    # JS Type System
  jsonlint                      # JSON Linter
  htmlhint                      # HTML Linter
  textlint                      # Markdown Linter
  react-tools                   # React.js
  react-native-cli              # React.js
  create-react-app              # React.js
  create-react-native-app       # React.js

  (self.markdown-link-check or null) # Markdown Linter

]
##################################################

# npm                           # JS Package Manager
# webpack                       # JS Build Tool
# webpack-cli                   # JS Build Tool
# eslint                        # JS Linter
# jshint                        # JS Linter
# prettier                      # JS Formatter
# uglify-js                     # JS Minifier
# typescript                    # JS Type System
# jsonlint                      # JSON Linter
# htmlhint                      # HTML Linter
# textlint                      # Markdown Linter
# markdown-link-check           # Markdown Linter
# react-tools                   # React.js
# react-native-cli              # React.js
# create-react-app              # React.js
# create-react-native-app       # React.js
