#!/bin/bash

printError()
{
    echo -e "\033[31mERROR:\033[0m $1"
}

getNumber()
{
    read -p "$1: "
    while (( $REPLY < $2 || $REPLY > $3 )); do
        printError "Input must be between $2 and $3"
        read -p "$1: "
    done
}

getNumber "please type a number between 1 and 100" 1 100
if [ $REPLY -eq 42 ]; then
    echo "Correct!"
elif [ $REPLY -lt 42 ]; then
    echo "Too low!"
else
    echo "Too high!"
fi