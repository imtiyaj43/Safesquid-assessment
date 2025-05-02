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
```
./master-script.sh -cpu       # CPU and Memory
./master-script.sh -network   # Network Monitoring
./master-script.sh -disk      # Disk Usage
./master-script.sh -load      # System Load Average
./master-script.sh -memory    # RAM and Swap
./master-script.sh -process   # Top Processes
./master-script.sh -services  # Service Monitoring
```
