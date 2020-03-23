#!/bin/bash

#identify root directory
rtDir=~/CSP2101/

while true; do

    #display avaialable files
    echo "You may save your password file to one of the following directories:"
    ls "$rtDir"

    #prompt user to select a directory
    read -p "Select a directory from the list above: " selDir

        if [ -d "${rtDir}${selDir}" ]; then
            #code if true
            echo "You have selected the $selDir directory."
            break
        else
            #code if false
            echo "Error! That directory does not exist"
        fi

done

while true; do

    read -s -p 'Enter a new password for future use: ' password
        if ! [ -z "$password" ]; then
            echo "Thank you, password accepted"
            break
        else
            echo "No password provided - please try again."
        fi

done

#Write password to text file in chosen directory
if ! [ -f "${rtDir}${selDir}/secret.txt" ]; then
    #code if true
    #create the secret.txt file
    touch ${rtDir}${selDir}/secret.txt
    echo "$password" > "${rtDir}${selDir}/secret.txt"
    echo "Password succesfully written to secret.txt."
    cat "${rtDir}${selDir}/secret.txt"
else
    #code if false
    echo "The file secret.txt already exists. Password being written to it now."
    echo "$password" > "${rtDir}${selDir}/secret.txt"
    echo "Password succesfully written to secret.txt."
    cat "${rtDir}${selDir}/secret.txt"
fi

exit 0