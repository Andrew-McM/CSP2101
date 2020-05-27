#!/bin/bash
#Name: Andrew McMaster
#Student ID: 10364024

#Create colour code variables to refer to later.
red='\033[31m'
green='\033[32m'
clear='\033[0m'
cyan='\033[36m'

echo -e "\nWelcome to the ECU Cyber Security Image Downloader Program!\n"

#Create endless loop until a valid input is given.
while true
do
    read -p "Specify the location you wish your images to be downloaded to: " saveDir
    #If saveDir does not exist - re-prompt for input.
    if [[ ! -d "$saveDir" ]]; then
        echo -e "${red}\nThat directory does not exist - please specify a valid directory.\n${clear}"
        continue
    #If saveDir exists - change directory to saveDir and break from loop.
    else
        echo -e "${green}\nThank you - your images will be downloaded to $saveDir.${clear}"
        cd $saveDir
        break
    fi
done

#Enter endless loop to continuously prompt user for an action.
while true
do

    echo -e "\n1) Download a specific image.
2) Download all images.
3) Download images in a range.
4) Download a chosen number of random images.
5) Exit the program.\n"

    read -p "Please enter an input (1-5) corresponding to the action you wish to execute from above: " action

    case $action in

        #If the user enters '1', run the following code.
        "1")
            #Enter endless loop.
            while true
            do
                read -p "Enter the name of the image you wish to download (or type 'Cancel' to return): " imageName
                #If user enters 'CANCEL' break from loop (^^ used to make input case insensitive).
                if [[ ${imageName^^} == 'CANCEL' ]]; then
                    break
                #Else, if imageName is already downloaded, re-prompt for input.    
                elif [[ -f "${imageName^^}.jpg" ]]; then
                    echo -e "${red}\nError: ${imageName^^}.jpg is already downloaded - please enter a different image.\n${clear}"
                    continue
                #Else, check if URL exists.
                else
                    #If URL exists, then run the following code. Reference: https://unix.stackexchange.com/questions/474805/verify-if-a-url-exists.
                    if wget -q --method=HEAD https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/${imageName^^}.jpg; then
                        #Download image from the followingURL. -q to hide output.
                        wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/${imageName^^}.jpg
                        fileSize=$(stat -c %s ${imageName^^}.jpg)
                        fileSizeKb=$(bc <<< "scale=2; $fileSize/1000")
                        echo -e "${cyan}\nDownloading ${imageName^^}, with the file name ${imageName^^}.jpg, with a file size of ${fileSizeKb}Kb...${clear}"
                        echo -e "${green}\nFile downloaded!${clear}"
                        break
                    else
                        echo -e "${red}\nError: ${imageName^^}.jpg does not exist - please enter a different image.\n${clear}"
                        continue
                    fi
                fi
            done;;

        "2")
            echo -e "${cyan}\nDownloading all images to $saveDir, please wait one moment...\n${clear}"
            for i in {1533..2042}; do
                if [[ -f "DSC0$i.jpg" ]]; then
                    echo -e "${red}DSC0$i.jpg is already downloaded.\n${clear}"
                    continue
                else
                    if wget -q --method=HEAD https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0${i}.jpg; then
                        wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0${i}.jpg
                        fileSize=$(stat -c %s DSC0$i.jpg)
                        fileSizeKb=$(bc <<< "scale=2; $fileSize/1000")
                        echo -e "${cyan}Downloading DSC0$i, with the file name DSC0$i.jpg, with a file size of ${fileSizeKb}Kb...${clear}"
                        echo -e "${green}File downloaded!\n${clear}"
                    else
                        continue
                    fi
                fi
            done
            echo -e "${green}All images are downloaded!${clear}";;

        "3")
            i=0
            echo -e "${cyan}\nPlease specify a range within the range of 1533-2042 (inclusive).\n${clear}"
            while true
            do
                read -p "Enter the starting number (the last 4 numbers of the image name) for the range of images you wish to download: " startNum
                read -p "Enter the finishing number (the last 4 numbers of the image name) for the range of images you wish to download: " finishNum
                if [[ $startNum =~ ^-?[0-9]+$ || $finishNum =~ ^-?[0-9]+$ ]]; then
                    if [[ $startNum -lt 1533 || $startNum -gt 2042 ]]; then
                        echo -e "${red}\nError: Invalid input - please enter numbers within the range of 1533-2042 (inclusive).\n${clear}"
                        continue
                    elif [[ $finishNum -lt 1533 || $finishNum -gt 2042 ]]; then
                        echo -e "${red}\nError: Invalid input - please enter numbers within the range of 1533-2042 (inclusive).\n${clear}"
                        continue
                    elif [[ $startNum -gt $finishNum ]]; then
                        echo -e "${red}\nError: Invalid input - starting number must be less than finishing number.\n${clear}"
                        continue
                    else
                        for (( i=$startNum; i<=$finishNum; i++ )); do
                            if [[ -f "DSC0$i.jpg" ]]; then
                                echo -e "${red}DSC0$i.jpg is already downloaded.\n${clear}"
                                continue
                            else
                                wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0${i}.jpg
                                fileSize=$(stat -c %s DSC0$i.jpg)
                                fileSizeKb=$(bc <<< "scale=2; $fileSize/1000")
                                echo -e "${cyan}Downloading DSC0$i, with the file name DSC0$i.jpg, with a file size of ${fileSizeKb}Kb...${clear}"
                                echo -e "${green}File downloaded!\n${clear}"
                                ((i++))
                                
                            fi
                        done
                        if [ $i == 0 ]; then
                            echo -e "${red}Error: Image range already downloaded.${clear}"
                            break
                        else
                            echo -e "${green}Image range successfully downloaded!${clear}"
                            echo $i
                            break
                        fi
                    fi
                else
                    echo -e "${red}\nError: Invalid input - please enter valid integers.\n${clear}"
                    continue
                fi
            done;;
                
        "4")
            i=1
            ranNum=$(shuf -i 1533-2042 -n 510)
            while true
            do
                read -p "Enter the number of random images (between 1-75) you wish to download: " imgNum
                if [[ $imgNum =~ ^-?[0-9]+$ ]]; then
                    if [ ! $imgNum -ge 1 ] || [ ! $imgNum -le 75 ]; then
                        echo -e "${red}\nError: Invalid input - please enter a number between 1-75.\n${clear}"
                        continue
                    else
                        break
                    fi
                else
                    echo -e "${red}\nError: Invalid input - please enter a valid integer.\n${clear}"
                fi
            done
            echo -e "${cyan}\nSearching for $imgNum random images to download - please wait one moment...\n${clear}"
            for c in $ranNum; do
                if [[ -f "DSC0$c.jpg" ]]; then
                    continue
                else
                    if wget -q --method=HEAD https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0${c}.jpg; then
                        wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0${c}.jpg
                        fileSize=$(stat -c %s DSC0$c.jpg)
                        fileSizeKb=$(bc <<< "scale=2; $fileSize/1000")
                        echo -e "${cyan}Downloading DSC0$c, with the file name DSC0$c.jpg, with a file size of ${fileSizeKb}Kb...${clear}"
                        echo -e "${green}File downloaded!\n${clear}"
                        ((i++))
                        if [ $i -le $imgNum ]; then
                            continue
                        else
                            break
                        fi
                    else
                        continue
                    fi
                fi
            done
            if [ $i -le $imgNum ]; then
                ((i--))
                echo -e "${red}Error: Unable to find $imgNum non-duplicate images, $i random images were downloaded.${clear}"
            else
                echo -e "${green}$imgNum random images successfully downloaded!${clear}"
            fi;;

        "5")
            echo -e "${green}\nExiting program, goodbye...\n${clear}"
            break;;

        *)
            echo -e "${red}\nError: Invalid input - please enter an input within the range of 1-5.${clear}"
            continue;;
    esac

done