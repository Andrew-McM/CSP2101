#!/bin/bash

if ! [ $# -eq 3 ]; then
    echo "Incorrect number of arguments provided - exiting script."
    exit 1
fi

fileCnt=0
newestFile=""

for i; do

    if [[ -f $i ]]; then
        (( fileCnt++ ))
        echo "$i is a file."

        if [[ %fileCnt < 1 ]]; then
            newestFile=$i
        else
            
            if [[ $i -nt $newestFile ]]; then
                newestFile=$i
            fi
        
        fi

    else
        echo "$i is not a file."

    fi

done

echo "File count is set to $fileCnt."
echo "Arguments passed is set to $#."


if [[ (( $fileCnt -eq $# )) ]]; then
    echo "The newest file is $newestFile"
else
    echo "Insufficient files for comparison."
fi

exit 0