#!/usr/bin/bash

# TODO
# 1. Ask for the directory to sort
# 2. List files, their extensions, and proposed sorting behaviour
# 3. Ask for confirmation
# 4. Sort
# 5. Complete

E_NO_ARG=1

# Exit if more than 1 arg is given

if [ $# -gt $E_NO_ARG ]; then
    echo "ERROR:"
    echo "Only 1 arg permitted."
    exit $E_NO_ARG
fi

echo "Which directory would you like to sort?"
echo -ne "> "
read DIRECTORY
echo

# Find directories

DIRECTORIES=(`find ~/*/ -name "*$DIRECTORY*" -type d 2> /dev/null`)

# List directories

echo "Found:"

COUNT=1
for DIR in ${DIRECTORIES[@]}; do
    echo "[$COUNT] $DIR"
    COUNT=$((COUNT+=1))
done

echo "[$COUNT] Try again."
echo

# Ask directory to sort

echo "Which directory do you want to sort?"
echo -ne "> "
read DIR_NUMBER
echo

# Confirm choice

echo "You chose: [$DIR_NUMBER] ${DIRECTORIES[$((DIR_NUMBER-1))]}"
echo "Is that correct? y/n"
echo -ne "> "
read CHOICE
echo

case $CHOICE in
    "y")
        # Confirmed
        cd ${DIRECTORIES[$((DIR_NUMBER-1))]}

        if [ `find . -maxdepth 1 -type f | wc -l` -eq 0 ]; then
            echo "Directory is empty."
        else
            for FILE_EXTENSION in `find . -type f -name '[^.]*.*' | sed 's|.*\.||' | sort -u`; do
                echo $FILE_EXTENSION
                mkdir $FILE_EXTENSION
                mv *.$FILE_EXTENSION $FILE_EXTENSION
            done
        fi
    ;;
    "n")
        # Denied
        echo "Incorrect"
    ;;
    "")
        # Default
        echo "Not a choice."
    ;;
esac

