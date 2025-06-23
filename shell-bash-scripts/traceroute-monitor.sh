#!/bin/bash

# This script performs a traceroute to a specified target IP or hostname defaulting to 8.8.8.8
TARGET_HOST="${1:-8.8.8.8}"
LOGFILE_NAME="trace_log_$(date '+%Y%m%d').log"

echo "Tracing route to: $TARGET_HOST"
echo "Logging to: $LOGFILE_NAME"

while true
do
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  OUTPUT=$(traceroute -m 20 -w 2 "$TARGET_HOST")  # Max 20 hops, 2 sec wait per hop

  # Check if the last line contains * * * or not
  if echo "$OUTPUT" | tail -n 1 | grep -q '\*\s\*\s\*'; then
    STATUS="Unreachable or Timeout"
  else
    STATUS="Reachable"
  fi

  {
    echo "[$TIMESTAMP] - $STATUS"
    echo "$OUTPUT"
    echo "----------------------------------------"
  } >> "$LOGFILE_NAME"

  sleep 60  # traceroute is heavier, so longer interval 60 seconds
done
