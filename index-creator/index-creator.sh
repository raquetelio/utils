#!/bin/bash

DEFAULT_INDEX_FILENAME="index.md"
INDEX_FILENAME=""

result_file=$RESULT_PATH/$INDEX_FILENAME

RESULT_PATH="result"
SEARCH_PATH=".../projects/mybok"

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
find "$SEARCH_PATH" -path "$SEARCH_PATH/.*" -prune -o -path "*/docs/*" -prune -o -print | sort | while read filename; do
    
    relative_filename="${filename#$SEARCH_PATH/}" 



    depth=$(echo "$relative_filename" | tr -cd '/' | wc -c)

    # echo "$relative_filename - Depth: $depth"

    if [[ $depth == 0 ]]; then
        echo "- [$relative_filename]($relative_filename)" >> $RESULT_PATH/$INDEX_FILENAME
    
    else
        # Append the file/subfolder name to the result file with tabs
        tabs=$(printf '\t%.0s' $(seq 1 $depth))
        # echo -e "${tabs}- [$relative_filename]($relative_filename)" >> $RESULT_PATH/$INDEX_FILENAME

         # Check if the file has a .md extension
        if [[ "$relative_filename" == *.md ]]; then
            # Get the first line of the .md file
            first_line=$(head -n 1 "$filename" | sed 's/^# *//')
            echo -e "${tabs}- [${first_line}]($relative_filename)" >> $RESULT_PATH/$INDEX_FILENAME
        else
            # For other files, write the relative filename
            echo -e "${tabs}- [${relative_filename}]($relative_filename)" >> $RESULT_PATH/$INDEX_FILENAME
        fi       

    fi
    
    done

    echo "Done."










    


