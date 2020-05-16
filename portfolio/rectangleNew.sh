#!/bin/bash

#Name: Andrew McMaster
#Student ID: 10364024

#Display a welcome message.
echo "Welcome to the rectangle.txt formatting program!"

#Enter a while true loop. This will enable the user to be continually prompted until a valid input is given.
while true
do

    #Prompt the user to enter the file path of their rectangle.txt file.
    read -p "Enter the file path of your rectangle.txt file: " rectangleFile

    #If the user doesn't provide an input, print the appropriate error message and re-prompt for input.
    if [ -z "$rectangleFile" ]; then
        echo "Error - no input detected. Please enter a valid file path."

    #Else if the user's input is not a valid path, print the appropriate error message and re-prompt for input.
    elif ! [ -f $rectangleFile ]; then
        echo "Error - $rectangleFile does not exist. Please enter a valid file path."

    #Else, if the path is valid then perform the following steps...
    else
        #sed - e to allow for multiple commands.
        #Delete the header.
        #Globally substitute the start of each line to start with 'Name: '.
        #Substitute the first comma of each line with 'Height: ' preceded by a tab for formatting.
        #Substitute the second comma of each line with 'Width: ' preceded by a tab for formatting.
        #Substitute the third comma of each line with 'Area: ' preceded by a tab for formatting.
        #Substitute the fourth comma of each line with 'Colour: ' preceded by a tab for formatting.
        sed -e '1d'\
            -e 's/^/Name: /g'\
            -e 's/,/\tHeight: /'\
            -e 's/,/\tWidth: /'\
            -e 's/,/\tArea: /'\
            -e 's/,/\tColour: /' $rectangleFile > rectangle_f.txt
        #Display a success message to the user.
        echo "Success! Your rectangle.txt data has been formatted and saved to rectangle_f.txt."
        #Break from endless loop.
        break

    fi

done
#Exit successfully
exit 0