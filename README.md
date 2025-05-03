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


---

# Set 2: Script for Automating Security Audits and Server Hardening on Linux Servers

# Linux Security Audit & Hardening Script

This project contains a Bash script that automates the security auditing and hardening of Linux servers. It performs various checks to identify potential vulnerabilities and implements recommended hardening measures to improve the security posture of your system.

## 📌 Features

The script performs the following security checks:

1. **User and Group Audits**
   - List all users and groups
   - Detect users with UID 0 (root privileges)
   - Identify users with empty or weak passwords

2. **File and Directory Permissions**
   - Scan for world-writable files
   - Detect files with SUID/SGID bits
   - Check for `.ssh` directories and validate secure permissions

3. **Service Audits**
   - List all running services
   - Ensure critical services (like SSH) are running securely
   - Check for services listening on non-standard ports

4. **Firewall & Network Security**
   - Check firewall (ufw or iptables) status
   - List open ports and associated services
   - Detect insecure network settings (e.g., IP forwarding)

5. **IP Address & Configuration**
   - Show all IP addresses (public and private)
   - Highlight exposure of sensitive services to public IPs

6. **Security Updates**
   - Check for pending security updates
   - Ensure the system is receiving regular security patches

7. **Log Monitoring**
   - Analyze recent SSH login attempts
   - Highlight any suspicious login patterns

8. **Server Hardening**
   - Verify SSH configuration (disable root login & password auth)
   - Check IPv6 status and disable if unused
   - Check if GRUB bootloader is password-protected
   - Ensure automatic updates are enabled

9. **Custom Security Checks**
   - Easily extendable with custom checks using config files (coming soon)

10. **Reporting**
   - Generates a clean summary report in `security_audit_report.txt`
   - Can be extended to send email alerts if needed

---

## ⚙️ How to Use

### 🧪 Run the Script:

```
chmod +x security_audit.sh
sudo ./security_audit.sh
```

## 📄Output:
All results will be stored in a file named:
```
security_audit_report.txt
```
You can open the file to view the full audit summary.
