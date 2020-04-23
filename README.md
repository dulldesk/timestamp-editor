# timestamp-editor

PowerShell script to edit file timestamps.

## Function

Each file / directory has three timestamps associated with it:
- Creation time
- Last modification time
- Last access time

Given a file, the script can:
- Change any/each timestamp to a given time
- Change all timestamps to a given time
- Change all timestamps to match the timestamps of another given file

Full file paths are to be provided (or, alternately, based on the file location of the script).

This script has been tested on Windows 10. 

## How to run

1. Clone the repository via `git clone https://github.com/dulldesk/timestamp-editor.git`, or download and unzip it via `https://github.com/dulldesk/timestamp-editor/archive/master.zip`.
2. Right-click `ts-edit-cli.ps1` > Run with PowerShell, or
    1. Open PowerShell
    2. Enter the full file path to the script (`C:\path\to\ts-edit-cli.ps1`)
3. Follow the shell instructions.

If running scripts is disabled on your system:
- Enter `Set-ExecutionPolicy -scope CurrentUser bypass` into the shell. This will allow the script to run.
- Retry step 3
- You may wish to re-disable scripts once more by entering `Set-ExecutionPolicy -scope CurrentUser default`
