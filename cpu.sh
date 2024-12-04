#!/bin/bash

HTML_FILE="/var/www/my_domain/html/CPU_load.html"

while (true)
do

CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print}')

cat <<EOF > "$HTML_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="1">
    <title>CPU Load</title>
</head>
<body>
    <p>Current CPU Load: <strong>${CPU_LOAD}</strong></p>
</body>
</html>
EOF

done
