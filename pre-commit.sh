#!/bin/sh
#from gist https://gist.github.com/fluxrad/2361452
echo 'Trying to parse the puppet script'
exec 1>&2

for file in `git diff --name-only --cached | grep -E '\.(pp)'`
do
    if [[ -f $file ]] 
    then
        puppet parser validate --mode user $file
        if [[ $? -ne 0 ]]
        then
            echo "ERROR: puppet parser failed at: $file"
            syntax_is_bad=1
        else
            echo "OK: $file looks valid"
        fi
    fi
done
echo ""
 
if [[ $syntax_is_bad -eq 1 ]]
then
    echo "FATAL: Syntax is bad. See above errors"
    echo "Bailing"
    exit 1
else
    echo "Everything looks good."
fi
