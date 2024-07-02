#!/bin/bash

# Create the count function
count_file_types() {

    # $1 represent the first argument given to the function
    local dir="$1"
    
    # initialize the variables
    local dirs_count=0
    local files_count=0
    local links_count=0
    
    #Check if the given directory exists
    if [ ! -d "$dir" ]; then 
        echo "Error: Directory '$dir' not found."
        return 1
    fi
    
    # loop through each item in the directory
    while IFS= read -r item; do
        #Get the type of the item 
        if [ -d "$item" ]; then
            ((dirs_count++))
        elif [ -f "$item" ]; then
            ((files_count++)) 
        elif [ -L "$item" ]; then
            ((links_count++))
        fi
    done < <(find "$dir" -mindepth 1 -maxdepth 1)
    
    #Display results
    echo "Directories: $dirs_count"
    echo "Regular files: $files_count"
    echo "Symbolic links: $links_count"
}

# check if script recieved exactly one argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# sets the directory variable to be equal to the recieved argument
directory="$1"

# Call the function
count_file_types "$directory"
