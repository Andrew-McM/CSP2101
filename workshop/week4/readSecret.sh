#!/bin/bash

#attempt to read a file
read -p "Enter the file name or part of the name that you are looking for: " reqFile

    for i in $( find ~/CSP2101 -name $reqFile\* ) ; do

        if [ -s "$i" ]; then
            #code if true
            echo "The content of $i are as follows: "
            cat $i
        else
            #code if false
            echo "The $i file is empty."
        fi

    done
