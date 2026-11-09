#!/bin/bash

# Validate that exactly two arguments are provided
if [[ $# -ne 2 ]]
then
  echo "Usage: backup.sh <target_directory_name> <destination_directory_name>"
  exit 1
fi

# Verify that both arguments are valid, accessible directories
if [[ ! -d "$1" ]] || [[ ! -d "$2" ]]
then
  echo "Error: Invalid directory path provided."
  exit 1
fi

# Assign inputs to descriptive variables safely
targetDirectory="$1"
destinationDirectory="$2"

echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

# Generate current epoch timestamp and format the output filename
currentTS=$(date +%s)
backupFileName="backup-${currentTS}.tar.gz"

# Capture absolute paths to guarantee reliable navigation during execution
origAbsPath=$(pwd)

cd "$destinationDirectory" || exit 1
destAbsPath=$(pwd)

cd "$origAbsPath" || exit 1
cd "$targetDirectory" || exit 1

# Calculate the epoch time threshold for the 24-hour rolling window
yesterdayTS=$((currentTS - 24 * 60 * 60))

# Initialize the array to hold files requiring backup
declare -a toBackup

# Iterate through the target directory and isolate recently modified files
for file in *
do
  # Skip loop if directory is empty (prevents '*' from being treated as a literal file)
  [[ -e "$file" ]] || continue

  # Compare file modification time against the 24-hour threshold using modern substitution
  if [[ $(date -r "$file" +%s) -gt "$yesterdayTS" ]]
  then
    toBackup+=("$file")
  fi
done

# Ensure there are files to backup before running the compression
if [[ ${#toBackup[@]} -gt 0 ]]
then
  # Archive the filtered files and transfer the payload to the secure destination
  tar -czvf "$backupFileName" "${toBackup[@]}"
  mv "$backupFileName" "$destAbsPath"
else
  echo "No files modified in the last 24 hours. Backup skipped."
fi
