#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: $0 <logfile>"
	exit 1
fi

LOGFILE="$1"

if [ ! -f "$LOGFILE" ]; then
	echo "Error: File does not exist"
	exit 1
fi

if [ ! -s "$LOGFILE" ]; then
	echo "log file is empty!"
	exit 1
fi

echo "==== LOG FILE ANALYSIS ===="
echo "Log Files: $LOGFILE"
echo ""

TOTAL=$(wc -l < "$LOGFILE")
echo "Total Entries: $TOTAL"
echo ""

echo "Unique IP Addresses:"
awk '{print $1}' "$LOGFILE" | sort | uniq

UNIQUE_COUNT=$(awk '{print $1}' "$LOGFILE" | sort | uniq | wc -l)
echo "Total Unique IPs: $UNIQUE_COUNT"
echo ""

echo "Status Code Summary:"
awk '{print $NF}' "$LOGFILE" | sort | uniq -c | while read count code
do 
	echo "$code: $count requests"
done
echo ""

echo "Most Frequently Accessed Page:"
awk '{print $7}' "$LOGFILE" | sort | uniq -c | sort -nr | head -1
echo ""

echo "Top 3 IP Addresses:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -3

