#!/bin/bash

# cat configuration.dhall | dhall-to-bash --declare CONFIGURATION > configuration.sh  &&  cat configuration.sh
# cat configuration.dhall | dhall-to-bash | xargs echo -e > configuration.sh  &&  cat configuration.sh
cat configuration.dhall | dhall-to-bash | xargs echo -e > configuration.sh  &&  cat configuration.sh
