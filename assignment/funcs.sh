#!/bin/bash
#Name: Andrew McMaster
#Student ID: 10364024

downloadMessage()
{
    red='\033[31m'
    green='\033[32m'
    clear='\033[0m'
    cyan='\033[36m'

    #Retrieve file size of downloaded image (in bytes) ###########3######
    fileSize=$(stat -c %s ${$1}.jpg)
    #Convert file size to Kb ############################
    fileSizeKb=$(bc <<< "scale=2; $fileSize/1000")
    #Display required download message.
    echo -e "${cyan}\nDownloading ${1}, with the file name ${1}.jpg, with a file size of ${2}Kb...${clear}"
    echo -e "${green}\nFile downloaded!${clear}"

}