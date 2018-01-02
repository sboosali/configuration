#!/bin/bash

MY_WATCHED_FILE=links.dhall

while inotifywait -e modify "$MY_WATCHED_FILE"; do
   source ./compile-dhall-configuration.sh
done
