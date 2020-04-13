#!/bin/bash

if [ $2 = "+" ]; then
    let sum=$1+$3
    echo -e "\033[34m$sum"

elif  [ $2 = '-' ]; then
    let sum=$1-$3
    echo -e "\033[32m$sum"

elif [ $2 = 'x' ]; then
    let sum=$1*$3
    echo -e "\033[31m$sum"

elif [ $2 = '/' ]; then
    let sum=$1/$3
    echo -e "\033[35m$sum"

else
    echo "Invalid input."

fi