#!/bin/bash

echo "==== USER ACCOUNT REPORT ===="
echo ""

TOTAL_users=$(wc -l < /etc/passwd)
SYSTEM_USERS=$(awk -F: '$3 < 1000 {count++} END {print count}' /etc/passwd)
REGULAR_USERS=$(awk -F: '$3 < 1000 {count++} END {print count}' /etc/passwd)
LOGGED_IN=$(who | awk '{print $1}' | sort -u |wc -l)



echo "==== USER STATISTICS ===="
echo "Total Users: $TOTAL_users"
echo "System Users (UID < 1000): $SYSTEM_USERS"
echo "Regular Users (UID >= 1000): $REGULAR_USERS"
echo "currently logged in: $LOGGED_IN"
echo ""


echo "==== REGULAR USER DETAILS ===="
printf "%-15s %-8s %-25s %-15s\n" "Username " "UID" "Home Directory" "Shell"
echo "-----------------------------------"

awk -F: '$3 >=1000 {
	printf "%-15s %-8s %-25s %-15s\n", $1, $3, $6, $7
}' /etc/passwd

echo ""

echo "====GROUP INFORMATION===="

awk -F: '{
	split($4, members, ",")
	if ($4 == "") {
		count = 0
	} else {
		count = lenght(members)
	}
	printf "%-20s Members: %d\n", $1, count
}' /etc/group

echo ""

echo "====SECURITY ALERT===="

ROOT_USER=$(awk -F: '$3 == 0 {print $1}' /etc/passwd)
ROOT_COUNT=$(echo "$ROOT_USER" | wc -w)

echo "Users with root Privileges (UID 0): $ROOT_COUNT"
echo "$ROOT_USER"

NO_PASS=$(sudo awk -F: '($2=="!" || $2=="*" || $2=="") {print $1}' /etc/shadow)

if [ -z "$NO_PASS" ]; then 
	echo "all users have password set"
else
	echo "users without passwords:"
	echo "$NO_PASS"
fi

echo ""
echo "Inactive Users(Never Logged In):"

if command -v lastlog>/dev/null 2>&1; then
	lastlog | awk '$4 == "**Never" {print $1}'
else
	echo "lastlog command not available"
fi


HTML="user_report.html"

{
echo "<html><body>"
echo "<h1>User Account Report</h1>"
echo "<h2>User Statistics</h2>"
echo "<p>Total Users: $TOTAL_users</p>"
echo "<p>System users: $SYSTEM_USERS</p>"
echo "<p>Regular users: $REGULAR_USERS</p>"
echo "</body></html>"
} > $HTML

echo "HTML report saved as $HTML"


for user in $(awk -F: '$3 >=1000 {print $1}' /etc/passwd)
do
	echo "User: $user"
	sudo chage -l "$user" | grep "Password expires"
done

echo "User report attatched" | mail -s "user report" your_email@example.com < user_report.html

