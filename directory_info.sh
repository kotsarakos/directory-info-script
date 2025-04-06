#!/bin/bash
# assign the value of the first command-line argument to the variable directory.
directory=$1
# Check if the directory does not exist
if [ ! -d "$directory" ]; then
echo "The specified directory does not exist."
exit 1
fi
# Find the 5 largest files in the directory
# 'find' search for the specific directory
# '-exec du -h {} +': For each file found, it calculate the disk usage in a human-readable format.
# '|' pipe, and we sort the output
# '|' pipe, the sorted output and displays the top 5 lines (files with the highest disk usage).
echo "The 5 largest files in the directory:"
find "$directory" -type f -exec du -h {} + | sort -rh | head -n 5
# Check for files with more than 1 hard link
# 'find' search for the specific directory
# -exec is used to execute a command on each file that matches the specified criteria.
# also we print the file name of those which have up to 1 hard links
echo -e "\nFiles with more than 1 hard link:"
find "$directory" -type f -links +1 -exec basename {} \;
# Check for files without read permission
echo -e "\nFiles without read permission:"
# 'find' search for the specific directory
# -exec is used to execute a command on each file that matches the specified criteria.
# also print the file name only with no read permissions
find "$directory" ! -readable -exec basename {} \;
