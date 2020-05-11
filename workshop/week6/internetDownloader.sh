#!/bin/bash
ping -q -c 1 -W 1 8.8.8.8

if [ $? eq- 0 ]; then
    echo "success"
else
    echo "fail"
fi

read -p "Enter a website: " website
wget $website

