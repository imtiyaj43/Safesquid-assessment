#!/bin/bash

echo "========="
echo " Top 10 Applications by CPU & Memory "
echo "======"
ps -eo user,%cpu ,%mem,comm --sort=-%cpu | head -n 11
echo"----------------------------------"

echo "========"
echo " Network Monitoring"
echo "========"
#Active Connections
connections=$(netstat -an | grep ESTABLISHED | wc -1)
echo "Active Connections: Sconnections"
#Total Packets
drops=$(netstat -s | grep -i "dropped" | head -n 5)
echo -e "\nPackets Drops:"
echo "$drops"
#Network Traffic (in MB)
interface="ens160"
rx=$(cat /proc/net/dev | grep "$interface" I awk '{print $23}')
tx=$(cat /proc/net/dev | grep "$interface" | awk '{print $10}')
rx_mb=$(echo "scale-2: Srx/1024/1024" | bc)
tx_mb=$(echo "scale=10: $tx/1024/1024" | bc)
echo "Received: $rx_mb MB"
echo "Transmitted: Stx_mb MB"
echo "---------------------------------------"

echo "================================="
echo " DISK USAGE"
echo "================================="
echo -e "Filesystem\tUsage\tMount Point"
df -h --output=source,pcent | tail -n +2 | while read line; do
    usage=$(echo $line | awk '{print $2}' | tr -d '%')
    if [ "$usage" -ge 80 ]; then
        echo "$line (Above 80%)"
    else
        echo -e "$line"
    fi
done
echo "----------------------"

echo "================================="
echo " SYSTEM LOAD"
echo "================================="

# Load Average
load_avg=$(uptime | awk -F'load average: ' '{ print $2 }')
echo "Load Average (1 min, 5 min, 15 min): $load_avg"

# CPU Usage Breakdown
echo ""
echo "CPU Usage Breakdown:"
top -bn1 | grep "CPU" | awk '{print "User: " $3 "% | System: " $5 "% | Idle: " $12 "%"}'

echo "----------------------"

echo "================================="
echo "Memory Usage:"
echo "================================="
free -h | awk 'NR==2{printf "Total: %s | Used: %s | Free: %s\n", $2, $3, $4}'
free -h | awk 'NR==3{printf "Swap - Total: %s | Used: %s | Free: %s\n", $2, $3, $4}'
echo "----------------------"


echo "================================="
echo "Process Monitoring:"
echo "================================="
echo "Total Active Processes: $(ps aux | wc -l)"

echo ""
echo "Top 5 Processes by CPU Usage:"
ps aux --sort=-%cpu | awk 'NR<=6 {printf "%-10s %-10s %-10s %s\n", $1, $3, $4, $11}'

echo ""
echo "Top 5 Processes by Memory Usage:"
ps aux --sort=-%mem | awk 'NR<=6 {printf "%-10s %-10s %-10s %s\n", $1, $3, $4, $11}'
echo "----------------------"

echo "================================="
echo "Service Monitoring"
echo "================================="

services=("sshd" "nginx" "apache2" "iptables")

for service in "${services[@]}"; do
    if systemctl list-units --type=service | grep -q "$service"; then
        status=$(systemctl is-active "$service")
        echo "$service: $status"
    else
        echo "$service: Not Installed"
    fi
done
echo "================================="

# Argument-based execution
if [ $# -eq 0 ]; then
    # Agar koi argument nahi diya toh pura dashboard dikhao
    cpu_memory_section
    network_section
    disk_section
    load_section
    memory_section
    process_section
    services_section
else
    for arg in "$@"
    do
        case $arg in
            --cpu)
                cpu_memory_section
                ;;
            --network)
                network_section
                ;;
            --disk)
                disk_section
                ;;
            --load)
                load_section
                ;;
            --memory)
                memory_section
                ;;
            --process)
                process_section
                ;;
            --services)
                services_section
                ;;
            --all)
                cpu_memory_section
                network_section
                disk_section
                load_section
                memory_section
                process_section
                services_section
                ;;
            *)
                echo "Invalid option: $arg"
                echo "Valid options: --cpu --network --disk --load --memory --process --services --all"
                ;;
        esac
    done
fi



