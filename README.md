# Secure Cron Backup (`secure-cron-backup`)

An automated, POSIX-compliant Bash utility designed to securely archive time-sensitive infrastructure files. This script isolates files modified within a rolling 24-hour window, compresses them into a timestamped tarball, and transfers them to a designated secure backup directory.

## System Architecture & Logic

### Rolling 24-Hour Window (Epoch Timestamps)
To ensure absolute accuracy across date boundaries and timezones, the script relies on epoch timestamps (seconds since January 1, 1970). 
* The script captures the execution time via `date +%s`.
* It calculates the exact 24-hour threshold using arithmetic expansion: `$((currentTS - 24 * 60 * 60))`.
* It evaluates each file's modification time against this threshold using `date -r <file> +%s`.

### POSIX-Compliant File Manipulation & Array Parsing
The script utilizes strict array parsing to handle dynamic file lists safely. Files meeting the timestamp criteria are appended to an array (`toBackup+=($file)`). This array is then expanded using `${toBackup[@]}` within the `tar` execution, preventing word-splitting issues and ensuring robust handling of filenames containing spaces or special characters.

## Usage

The utility requires two arguments: the target directory to scan, and the destination directory for the archive.

```bash
backup.sh <target_directory_path> <destination_directory_path>