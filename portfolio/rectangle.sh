#!/bin/bash

echo "Welcome to the rectangle.txt formatting program!"

while true
do

    read -p "Enter the file path of your rectangle.txt file: " rectangleFile

    if [ -z "$rectangleFile" ]; then
        echo "Error - no input detected. Please enter a valid file path."

    elif ! [ -f $rectangleFile ]; then
        echo "Error - $rectangleFile does not exist. Please enter a valid file path."

    else
        sed -e '1d; s/^/Name: /g; s/,/\tHeight: /; s/,/\tWidth: /; s/,/\tArea: /; s/,/\tColour: /' $rectangleFile > rectangle_f.txt
        echo "Success! Your rectangle.txt data has been formatted and saved to rectangle_f.txt."
        break

    fi

done