#!/bin/bash

# 
cd;

# find cloned file and add path to `.bashrc` file
clonnedFilePath=$(find /home/ -type f -iname .commands.sh)
# echo ${clonnedFilePath}

# # add util command to 
[ -f .bashrc ] &&
echo "\n# util commands \nsource ${clonnedFilePath}\n" | cat >> .bashrc ||
echo ".bashrc FILE does not exist"

# # restart the current shell process
exec bash;
