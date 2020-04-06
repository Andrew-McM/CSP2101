#!/bin/bash


# Name: Andrew McMaster
# Student Num: 10364024


# Generate a random integer between 20-70 (inclusive).
myAge=$(( 20 + RANDOM % 50))

# Enter an endless loop which will break once the user guesses correctly.
while true
do

    # Prompt the user for a guess and store it under the variable 'ageGuess'.
    read -p "Guess my age! Hint - it is between 20-70... Enter a guess: " ageGuess

    # Check if ageGuess is not an integer, print an error message if so.
    if ! [[ "$ageGuess" =~ ^[0-9]+$ ]]; then
        echo "Invalid input! Try again."

    # If ageGuess is an integer, run the following...
    else

        # Check if myAge is greater than ageGuess, print appropriate message if so.
        if [ "$myAge" -gt "$ageGuess" ]; then
            echo "Too low! Try again."

        # Check if myAge is less than ageGuess, print apporpriate message if so.
        elif [ "$myAge" -lt "$ageGuess" ]; then
            echo "Too high! Try again."

        # Else ageGuess must be correct, print message and break from loop.
        else
            echo "Correct! My age is "$myAge" - well done :)"
            break

        fi

    fi

done