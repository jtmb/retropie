#!/bin/bash

# Check for correct number of arguments
if [[ $# -lt 1 ]]; then
    echo "Usage: scrape <platform>"
    echo "ex: scrape n64"
    exit 1
fi

# Get the platform argument
PLATFORM="$1"

# Scrape metadata from the net for ROMs
echo "Stopping EmulationStation..."
killall emulationstation || true

echo "Scraping metadata for platform '$PLATFORM'..."
/opt/retropie/supplementary/skyscraper/Skyscraper -p "$PLATFORM" \
    -g /home/$USER/.emulationstation/gamelists/"$PLATFORM" \
    -o /home/$USER/.emulationstation/downloaded_media/"$PLATFORM" \
    -s screenscraper --flags unattend,skipped,videos

# Add metadata to ROM library
echo "Adding metadata to ROM library for platform '$PLATFORM'..."
/opt/retropie/supplementary/skyscraper/Skyscraper -p "$PLATFORM" \
    -g /home/$USER/.emulationstation/gamelists/"$PLATFORM" \
    -o /home/$USER/.emulationstation/downloaded_media/"$PLATFORM" \
    --flags unattend,skipped,videos

# Restart EmulationStation
echo "Restarting EmulationStation..."
nohup emulationstation > /dev/null 2>&1 &
# Indicate script completion
echo "EmulationStation has been restarted in the background."
