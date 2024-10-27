#!/bin/bash

DEFAULT_INDEX_FILENAME="index.md"
INDEX_FILENAME=""

RESULT_PATH="result"
SEARCH_PATH="/home/rtoscano/projects/mybok"

function setIndexFileName(){ 
    # Prompt the user to enter a filename with a default value
    read -p "Generating index. Enter filename (default: $DEFAULT_INDEX_FILENAME): " INDEX_FILENAME

    # Set a default value if the user presses Enter without typing anything
    if [[ -z "$INDEX_FILENAME" ]]; then       
        INDEX_FILENAME=$DEFAULT_INDEX_FILENAME
        echo "No filename entered. Using default: $INDEX_FILENAME"
    else
        echo "Filename entered: $INDEX_FILENAME"
    fi
}

setIndexFileName

if [[ ! -d "$RESULT_PATH" ]]; then
    mkdir $RESULT_PATH
fi

touch $RESULT_PATH/$INDEX_FILENAME


echo "Generating... Ignored files in /docs/ subfolder"
find "$SEARCH_PATH" -path "$SEARCH_PATH/.*" -prune -o -path "*/docs/*" -prune -o -print | while read filename; do
        relative_filename="${filename#$SEARCH_PATH/}"
        echo "$relative_filename"

    depth=$(echo "$relative_filename" | tr -cd '/' | wc -c)

    if [[ $depth == 0 ]]; then
        index.md > echo "## "$relative_filename"\n"
    fi
    
    # Print the relative filename and its depth
    echo "Depth $depth: $relative_filename"

    done










    


