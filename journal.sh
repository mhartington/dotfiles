#!/bin/bash

if [[ -z "$JOURNAL_DIR" ]]; then
  echo "-- Set environment variable JOURNAL_DIR to where your journal entries are stored."
  exit 0;
fi

if [[ -z "$1" ]]; then
  DATE=$(date +"%Y-%m-%d")
else
  DATE=$1
fi

$EDITOR "$JOURNAL_DIR/$DATE.txt"
