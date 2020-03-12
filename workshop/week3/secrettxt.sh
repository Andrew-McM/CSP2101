#!/bin/bash

#User specifies the folder to save their file to
read -p "type the folder name you wish to save your text file to:" folderName

#Prompts the user to enter their secret password
read -p "type your secret password:" secretPassword

#Save the password to a text file within the specified folder
~/CSP2101/workshop/"$folderName" echo "$secretPassword" > secret.txt 