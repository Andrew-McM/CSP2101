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
                #Else, if imageName is not already downloaded, run the following code...
                else
                    #If URL is retrieved, then... (-q to hide wget output).
                    if wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/${imageName^^}.jpg; then
                        #Retrieve file size of downloaded image (in bytes). Reference: https://unix.stackexchange.com/questions/405601/how-do-i-store-the-human-friendly-size-of-a-file-in-a-variable
                        fileSize=$(stat -c %s ${imageName^^}.jpg)
                        #Convert file size to Kb. Reference: https://stackoverflow.com/questions/12722095/how-do-i-use-floating-point-division-in-bash
                        fileSizeKb=$(bc <<< "scale=2; $fileSize/1000")
                        #Display required download message.
                        echo -e "${cyan}\nDownloading ${imageName^^}, with the file name ${imageName^^}.jpg, with a file size of ${fileSizeKb}Kb...${clear}"
                        echo -e "${green}\nFile downloaded!${clear}"
                        #Break from endless loop.
                        break
                    #Else, if URL cannot be retreived...
                    else
                        #Print error message stating that image does not exist. Re-prompt for a new image name.
                        echo -e "${red}\nError: ${imageName^^}.jpg does not exist - please enter a different image.\n${clear}"
                        continue
                    fi
                fi
            done;;
        
        #If the user enters '2', run the following code.
        "2")
            #Set count to zero.
            count=0
            echo -e "${cyan}\nDownloading all images to $saveDir, please wait one moment...\n${clear}"
            #For each instance of a number 1533-2042 (i), do the following...
            for i in {1533..2042}; do
                #If image number 'i' is already downloaded, display the appropriate error code and move to the next number.
                if [[ -f "DSC0$i.jpg" ]]; then
                    echo -e "${red}DSC0$i.jpg is already downloaded.\n${clear}"
                    continue
                #If image number 'i' is not already downloaded, do the following...
                else
                    #If wget successfully retrieves URL, do the following... (-q to hide wget ouput).
                    if wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0${i}.jpg; then
                        #Save size of the file (in bytes) to the variable fileSize. Reference: https://unix.stackexchange.com/questions/405601/how-do-i-store-the-human-friendly-size-of-a-file-in-a-variable
                        fileSize=$(stat -c %s DSC0$i.jpg)
                        #Convert fileSize to Kb. Reference: https://stackoverflow.com/questions/12722095/how-do-i-use-floating-point-division-in-bash
                        fileSizeKb=$(bc <<< "scale=2; $fileSize/1000")
                        echo -e "${cyan}Downloading DSC0$i, with the file name DSC0$i.jpg, with a file size of ${fileSizeKb}Kb...${clear}"
                        echo -e "${green}File downloaded!\n${clear}"
                        #Increment count by 1.
                        ((count++))
                    #Else, if wget fails to retrieve URL, move to next number.
                    else
                        continue
                    fi
                fi
            done
            #IF 'count' is equal to zero, display appropriate error message.
            if [ $count == 0 ]; then
                echo -e "${red}Error: All images already downloaded - no new images downloaded.${clear}"
            #Else, if 'count' is not zero, display success message.
            else
                echo -e "${green}All images are downloaded!${clear}"
            fi;;

        #If user input enters '3', run the following code.
        "3")
            #Initialise count to zero.
            count=0
            echo -e "${cyan}\nPlease specify a range within the range of 1533-2042 (inclusive).\n${clear}"
            #Enter an endless loop.
            while true
            do  
            #Prompt user for a starting and finishing number.
                read -p "Enter the starting number (the last 4 numbers of the image name) for the range of images you wish to download: " startNum
                read -p "Enter the finishing number (the last 4 numbers of the image name) for the range of images you wish to download: " finishNum
                #If startNum and finishNum are both integers, run the following code...
                if [[ $startNum =~ ^-?[0-9]+$ && $finishNum =~ ^-?[0-9]+$ ]]; then
                    #If startnum is less than 1533 or finishNum is greater than 2042, print appropriate error message and re-prompt for input.
                    if [[ $startNum -lt 1533 || $startNum -gt 2042 ]]; then
                        echo -e "${red}\nError: Invalid input - please enter numbers within the range of 1533-2042 (inclusive).\n${clear}"
                        continue
                    #Else, if finishNum is less than 1533 and startNum is greater than 2042, print appropriate error message and re-prompt for input.
                    elif [[ $finishNum -lt 1533 || $finishNum -gt 2042 ]]; then
                        echo -e "${red}\nError: Invalid input - please enter numbers within the range of 1533-2042 (inclusive).\n${clear}"
                        continue
                    #Else, if startNum is greater than finishNum, print appropriate error message and re-prompt for input.
                    elif [[ $startNum -gt $finishNum ]]; then
                        echo -e "${red}\nError: Invalid input - starting number must be less than finishing number.\n${clear}"
                        continue
                    #Otherwise, run the following code...
                    else
                        #For the range of numbers from startNum to finishNum, do the following...
                        for (( i=$startNum; i<=$finishNum; i++ )); do
                            #If image number 'i' is already downloaded, print appropriate message and move to next number.
                            if [[ -f "DSC0$i.jpg" ]]; then
                                echo -e "${red}DSC0$i.jpg is already downloaded.\n${clear}"
                                continue
                            #Else, if image number 'i' is not downloaded, run the following code...
                            else
                                #If wget successfully retrieves the URL, run the following... (-q to hide wget ouput).
                                if wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0${i}.jpg; then
                                    #Save the size of the file (in bytes) to the fileSize variable. Reference: https://unix.stackexchange.com/questions/405601/how-do-i-store-the-human-friendly-size-of-a-file-in-a-variable
                                    fileSize=$(stat -c %s DSC0$i.jpg)
                                    #Convert fileSize to Kb. Reference: https://stackoverflow.com/questions/12722095/how-do-i-use-floating-point-division-in-bash
                                    fileSizeKb=$(bc <<< "scale=2; $fileSize/1000")
                                    #Display appropriate download message.
                                    echo -e "${cyan}Downloading DSC0$i, with the file name DSC0$i.jpg, with a file size of ${fileSizeKb}Kb...${clear}"
                                    echo -e "${green}File downloaded!\n${clear}"
                                    #Increment count by 1.
                                    ((count++))
                                #Else, if wget fails to retrieve URL, move to the next number.
                                else
                                    continue
                                fi
                            fi
                        done
                        #If count is equal to zero, print error message nd break from while true loop.
                        if [ $count == 0 ]; then
                            echo -e "${red}Error: Image range already downloaded - no new images downloaded.${clear}"
                            break
                        #Else, if count is not equal to zero, print success message and break from while true loop.
                        else
                            echo -e "${green}Image range successfully downloaded!${clear}"
                            break
                        fi
                    fi
                #Else, if startNum and finishNum are not both integers, print error message and re-prompt for input.
                else
                    echo -e "${red}\nError: Invalid input - please enter valid integers.\n${clear}"
                    continue
                fi
            done;;

        #If the user enters '4', run the following code.      
        "4")
            #Initiate count to one.
            count=0
            #Create a list of the numbers 1533-2042 in a random order.
            ranNum=$(shuf -i 1533-2042 -n 510)
            #Enter endless loop
            while true
            do
                #Prompt user to enter the number of random images they wish to download.
                read -p "Enter the number of random images (between 1-75) you wish to download: " imgNum
                #If imgNum is a valid integer, run the following...
                if [[ $imgNum =~ ^-?[0-9]+$ ]]; then
                    #If imgNum is not greater or equal to 1 , or not less than or equal to 75, run the following code...
                    if [[ ! $imgNum -ge 1 || ! $imgNum -le 75 ]]; then
                        #Print appropriate error message and re-prompt for input.
                        echo -e "${red}\nError: Invalid input - please enter a number between 1-75.\n${clear}"
                        continue
                    #Else, if imgNum is greater or equal to 1, and less than or equal to 75, break from while true loop.
                    else
                        break
                    fi
                #Else, if imgNum is not a valid integer, print error message and re-prompt for input.
                else
                    echo -e "${red}\nError: Invalid input - please enter a valid integer.\n${clear}"
                fi
            done
            echo -e "${cyan}\nSearching for $imgNum random images to download - please wait one moment...\n${clear}"
            #For each number (c) in ranNum, do the following...
            for c in $ranNum; do
                #If that image number is already downloaded, move to the next number.
                if [[ -f "DSC0$c.jpg" ]]; then
                    continue
                #Else, if that image number is not already downloaded, run the following code...
                else
                    #If wget successfully retrieves URL, run the following code... (-q to hide wget output).
                    if wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0${c}.jpg; then
                        #Save the size of the file (in bytes) to fileSize. Reference: https://unix.stackexchange.com/questions/405601/how-do-i-store-the-human-friendly-size-of-a-file-in-a-variable
                        fileSize=$(stat -c %s DSC0$c.jpg)
                        #Convert fileSize to Kb. Reference: https://stackoverflow.com/questions/12722095/how-do-i-use-floating-point-division-in-bash
                        fileSizeKb=$(bc <<< "scale=2; $fileSize/1000")
                        #Print appropriate download message.
                        echo -e "${cyan}Downloading DSC0$c, with the file name DSC0$c.jpg, with a file size of ${fileSizeKb}Kb...${clear}"
                        echo -e "${green}File downloaded!\n${clear}"
                        #Increment count by 1.
                        ((count++))
                        #If count is less than or equal to the number of random images wanted, continue to next number.
                        if [ $count -lt $imgNum ]; then
                            continue
                        #Else, if number of images downloaded is sufficient, break from for loop.
                        else
                            break
                        fi
                    #Else, if wget fails to retrieve URL, move to next number in ranNum.
                    else
                        continue
                    fi
                fi
            done
            #If count is less than or equal to the number of random images wanted, print appropriate error message.
            if [ $count -lt $imgNum ]; then
                echo -e "${red}Error: Unable to find $imgNum non-duplicate images, $count random images were downloaded.${clear}"
            #Else, if required number of random images were downloaded, print success message.
            else
                echo -e "${green}$imgNum random images successfully downloaded!${clear}"
            fi;;

        #If the user enters '5', run the following code.
        "5")
            #Print exiting program message, break from while true loop, thus ending program.
            echo -e "${green}\nExiting program, goodbye...\n${clear}"
            break;;

        #If the user enters anything other than 1-5, run the following code.
        *)
            #Print appropriate error message, and re-prompt for input.
            echo -e "${red}\nError: Invalid input - please enter an input within the range of 1-5.${clear}"
            continue;;

    #Close case statement.
    esac

#Close while true loop.
done