#!/bin/bash

while IFS='\n' read file
do
    if [ -d $file ]; then
        echo "$file is a directory!"
    elif [ -f $file ]; then
        echo "$file is a file!"
    else
        echo "$file I dont know what that is!"
    fi
done < fileNames.txt

