#!/bin/bash
echo "***Server Stats***"
echo

# Present OS 
echo "*** Current OS ***"
cat /etc/os-release | grep "PRETTY_NAME" -w
echo

# Total CPU usages
echo "*** CPU Usages ***"
top -bn1 | grep "Cpu" | cut -d ',' -f 4 | awk '{print "In Use: "100-$1"%\nIdeal: "$1"%"}'
echo

# Total Memory usages
echo "*** Memory Usage ***"
free | grep "Mem:" -w | awk '{printf "Total: %.1f Gi\nUsed: %.1f Gi (%.2f%%)\nFree: %.1f Gi (%.2f%%)\n",$2/1024^2, $3/1024^2, $3/$2 * 100, $4/1024^2, $4/$2 * 100}'
echo

# Total Disk Usages
echo "*** Disk Usage ***"
df | grep "/" -w | awk '{print "Used: "$5"\nFree: "100-$5"%"}'
echo

# Total 5 processes by CPU usage
echo "*** Top 5 Processes (CPU)***"
ps aux --sort -%cpu | head -n 6 | awk '{print $1"\t" $2 "\t" $3 "\t" $11}'
echo

# Total 5 Processes by Memory Usages
echo "*** Top 5 Processes (Memory) ***"
ps aux --sort -%mem | head -n 6 | awk '{print $1"\t" $2 "\t" $4 "\t" $11}'
echo
