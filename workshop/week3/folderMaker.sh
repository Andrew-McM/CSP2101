#!/bin/bash

#prompt user to enter name for new directory
read -p "Enter a name for the new directory: " directoryName

#create a new directory
mkdir "$directoryName"