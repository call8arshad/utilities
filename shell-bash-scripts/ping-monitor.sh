#!/bin/bash

# Use first argument as target, or default to 8.8.8.8
TARGET_HOST="${1:-8.8.8.8}"
LOGFILE_NAME="ping_log_$(date '+%Y%m%d').log"

echo "Pinging target: $TARGET_HOST"
echo "Logging to: $LOGFILE_NAME"


while true
do
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  # Send 1 ICMP ping request (-c 1) wait up to 2 seconds (-W 2) for a reply before giving up
  OUTPUT=$(ping -c 1 -W 2 $TARGET_HOST)

  if echo "$OUTPUT" | grep -q "1 received"; then
    STATUS="Reachable"
  else
    STATUS="Unreachable"
  fi

  {
    echo "[$TIMESTAMP] - $STATUS"
    echo "$OUTPUT"
    echo "#----------------------------------------#"
  } >> "$LOGFILE_NAME"

  sleep 1  # Wait here:: Adjust ping interval (default is 1 sec)
done
