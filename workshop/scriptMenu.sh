#!/bin/bash

echo "1. Create a folder.
2. List files in a folder.
3. Copy a folder.
4. Save a password.
5. Read a password.
6. Print newest file."

read -p "Enter a number corresponding to the scripts listed above: " selScript

case $selScript in
    "1")
        ~/CSP2101/workshop/week3/folderMaker.sh 
        ;;
    "2")
        ~/CSP2101/workshop/week3/folderContents.sh
        ;;
    "3")
        ~/CSP2101/workshop/week4/folderCopier.sh
        ;;
    "4")
        ~/CSP2101/workshop/week4/secretPass.sh
        ;;
    "5")
        ~/CSP2101/workshop/week4/readSecret.sh
        ;;
    "6")
        cd ~/CSP2101/workshop/week4
        read -p "Enter the first file you wish to compare: " firFile
        read -p "Enter the second file you wish to compare: " secFile
        read -p "Enter the third file you wish to compare: " thirdFile
        ~/CSP2101/workshop/week4/checkArg.sh "$firFile" "$secFile" "$thirdFile"
        ;;
    *)
        echo "Invalid input!"
        ;;

esac
exit 0