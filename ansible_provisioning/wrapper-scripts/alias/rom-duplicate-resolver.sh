#!/bin/bash

cat << 'EOF'
 ______  ______  ______  ______  ______  ______  ______  ______  ______  ______ 
| |__| || |__| || |__| || |__| || |__| || |__| || |__| || |__| || |__| || |__| |
|  ()  ||  ()  ||  ()  ||  ()  ||  ()  ||  ()  ||  ()  ||  ()  ||  ()  ||  ()  |
|______||______||______||______||______||______||______||______||______||______|
 ______                                                                  ______ 
| |__| | ____                   ____              _ _           _       | |__| |
|  ()  ||  _ \ ___  _ __ ___   |  _ \ _   _ _ __ | (_) ___ __ _| |_ ___ |  ()  |
|______|| |_) / _ \| '_ ` _ \  | | | | | | | '_ \| | |/ __/ _` | __/ _ \|______|
 ______ |  _ < (_) | | | | | | | |_| | |_| | |_) | | | (_| (_| | ||  __/ ______ 
| |__| ||_|_\_\___/|_| |_| |_|_|____/ \__,_| .__/|_|_|\___\__,_|\__\___|| |__| |
|  ()  ||  _ \ ___  ___  ___ | |_   _____ _|_|                          |  ()  |
|______|| |_) / _ \/ __|/ _ \| \ \ / / _ \ '__|                         |______|
 ______ |  _ <  __/\__ \ (_) | |\ V /  __/ |                             ______ 
| |__| ||_| \_\___||___/\___/|_| \_/ \___|_|                            | |__| |
|  ()  |                                                                |  ()  |
|______| author: htts://github.com/jtmb                                 |______|
 ______  ______  ______  ______  ______  ______  ______  ______  ______  ______ 
| |__| || |__| || |__| || |__| || |__| || |__| || |__| || |__| || |__| || |__| |
|  ()  ||  ()  ||  ()  ||  ()  ||  ()  ||  ()  ||  ()  ||  ()  ||  ()  ||  ()  |
|______||______||______||______||______||______||______||______||______||______|
EOF
echo

# Function to find and compare files for similarity
find_and_compare_files() {
    local dir="$1"
    local threshold=90
    local temp_file=$(mktemp)

    echo "Finding files in directory..."
    find "$dir" -type f | tee /dev/tty | sort > "$temp_file"  # Output file list to the console

    echo "Comparing files for similarity..."
    while IFS= read -r file1; do
        while IFS= read -r file2; do
            if [[ "$file1" < "$file2" ]]; then
                score=$(compare_files "$file1" "$file2")
                if (( score >= threshold )); then
                    echo "$file1|$file2|$score"
                fi
            fi
        done < "$temp_file"
    done < "$temp_file"

    rm "$temp_file"
}

# Function to compare two files and return a similarity score
compare_files() {
    local file1="$1"
    local file2="$2"

    # Calculate checksums
    local checksum1=$(md5sum "$file1" | awk '{print $1}')
    local checksum2=$(md5sum "$file2" | awk '{print $1}')
    
    # Compare checksums
    if [[ "$checksum1" == "$checksum2" ]]; then
        echo 100  # Identical files
    else
        echo 0    # Different files
    fi
}

# Function to process and list duplicate files
list_duplicates() {
    local duplicates_file="$1"
    local keep_one=true

    echo
    echo "The following files are considered duplicates:"
    echo "+------------------------------------------------+"

    while IFS='|' read -r file1 file2 score; do
        if [[ -f "$file1" ]]; then
            echo "| $file1"
            echo "| $file2"
            echo "+------------------------------------------------+"
        fi
    done < "$duplicates_file"
}

# Function to process and delete duplicate files
process_and_delete_duplicates() {
    local duplicates_file="$1"
    local keep_one=true

    # Check if there are any duplicates to process
    if ! grep -q '|' "$duplicates_file"; then
        echo "No duplicates found."
        return
    fi

    echo
    echo "Would you like to delete duplicate files (one copy will remain)? (yes/no): "
    read -r response

    if [[ "$response" == "yes" ]]; then
        local unique_files=()

        while IFS='|' read -r file1 file2 score; do
            if [[ " ${unique_files[@]} " =~ " ${file1} " ]] || [[ " ${unique_files[@]} " =~ " ${file2} " ]]; then
                continue
            fi

            if [[ -f "$file1" ]]; then
                echo "Attempting to delete: $file1"
                rm -f "$file1"
                echo "Successfully deleted: $file1"
            fi

            if [[ -f "$file2" ]]; then
                echo "Attempting to delete: $file2"
                rm -f "$file2"
                echo "Successfully deleted: $file2"
            fi

            # Track files that we are keeping
            unique_files+=("$file1")
            unique_files+=("$file2")

        done < "$duplicates_file"

        total_space_reclaimed=$(du -sh "$dir" | awk '{print $1}')
        echo "Total space reclaimed: $total_space_reclaimed MB"
    else
        echo "No files will be deleted."
        echo "EXITING"
    fi
}

# Main script logic
if [[ $# -lt 1 ]]; then
    echo "Usage: rdr <directory>"
    exit 1
fi

dir="$1"
duplicates_file=$(mktemp)

find_and_compare_files "$dir" > "$duplicates_file"
list_duplicates "$duplicates_file"
process_and_delete_duplicates "$duplicates_file"

rm "$duplicates_file"