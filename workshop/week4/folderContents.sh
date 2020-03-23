#!/bin/bash

#identify root directory
rtDir=~/CSP2101/

while true; do

#display to user avaialble directories to choose from
echo "The available directories are: " 
ls $rtDir

#prompt user to select a directory
read -p 'Select a directory from the list above: ' selDir

if [ -d "${rtDir}${selDir}" ]; then
    #code if test is true
    echo "You have requested to see the contents of $selDir"

        if [ "$(ls -A ${rtDir}${selDir})" ]; then
            #code if test is true
            ls ${rtDir}${selDir}
        else
            #code if test is false
            echo "Error! There are no files in $selDir"
        fi
        break
else
    #code if test if false
    echo "Error! Directory does not exist."
fi

done