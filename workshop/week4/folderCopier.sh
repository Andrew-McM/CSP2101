#!/bin/bash

#prompt user to enter the folder they wish to copy
read -p "Enter the name of the folder that you wish to copy: " folderName

#check if folder already exists
if [ -d "$folderName" ]; then
    #code if true
    read -p "Enter the name of the new folder you wish to copy to: " newFolderName
    if ! [ -d "$newFolderName" ]; then
        cp -R "$folderName" "$newFolderName"
        echo "$folderName successfully copied to $newFolderName"
    else
        echo "Invalid input - that folder already exists."
    fi
else
    #code if false
    echo "Invalid input - that folder does not exist."
fi