# Set 1: Monitoring System Resources for a Proxy Server

## 📌 Objective

This script creates a **Monitoring System Resources for a Proxy Server** using Bash, which provides real-time insights into critical system metrics such as:

- Top applications by CPU and memory usage
- Network statistics (connections, dropped packets, traffic)
- Disk usage with threshold alerts
- System load averages and CPU usage breakdown
- Memory status (RAM and Swap)
- Active process summary
- Service health monitoring

---

## ⚙️ Requirements

Ensure the following packages are installed before running the script:

```
sudo apt update
sudo apt install net-tools bc -y
sudo apt install apache -y
sudo apt install nginx -y
```
## 🚀 How to Run

### Make the script executable:
```
chmod +x master-script.sh
```

### Run the full dashboard:
```
./master-script.sh -all
```

### Run specific sections only:

## Run Individual Sections
### CPU & Memory:
```
./master-script.sh -cpu
```
### Network Monitoring:
```
./master-script.sh -network
```
### Disk Usage:
```
./master-script.sh -disk
```
### System Load:
```
./master-script.sh -load
```
### Memory Info:
```
./master-script.sh -memory
```
### Process Monitoring:
```
./master-script.sh -process
```
### Service Status:
```
./master-script.sh -services
```
## ⚙️ Script Features
Displays top 10 apps by CPU and memory usage

Shows active network connections, packet drops, traffic stats

Disk usage with alert on >80%

System load and CPU breakdown

Memory + swap usage

Active processes + top consumers

Service status (sshd, nginx, apache2, iptables)

## Notes
```Default network interface: ens160 (update if needed).```
