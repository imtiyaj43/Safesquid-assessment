#!/bin/bash

report_file="security_audit_report.txt"
> $report_file

log() {
    echo -e "$1" | tee -a "$report_file"
}

log "======== Security Audit Report ========\n"
log "Date: $(date)\n"
log "Hostname: $(hostname)\n"
log "=======================================\n"

# 1. User and Group Audits
log "\n[1] User and Group Audit"
log "-------------------------"
log "All users:"; cut -d: -f1 /etc/passwd | tee -a "$report_file"
log "\nAll groups:"; cut -d: -f1 /etc/group | tee -a "$report_file"
log "\nUsers with UID 0:"; awk -F: '($3 == "0") {print $1}' /etc/passwd | tee -a "$report_file"
log "\nUsers with empty passwords:"
sudo awk -F: '($2 == "" || $2 == "*") {print $1}' /etc/shadow | tee -a "$report_file"

# 2. File and Directory Permissions
log "\n[2] File and Directory Permission Audit"
log "----------------------------------------"
log "World-writable files:"; find / -xdev -type f -perm -0002 2>/dev/null | tee -a "$report_file"
log "Files with SUID/SGID:"; find / -xdev \( -perm -4000 -o -perm -2000 \) -type f 2>/dev/null | tee -a "$report_file"

# 3. Service Audit
log "\n[3] Service Audit"
log "------------------"
log "Running services:"; systemctl list-units --type=service --state=running | tee -a "$report_file"
log "\nSSH status:"; systemctl status ssh | head -n 10 | tee -a "$report_file"

# 4. Firewall and Network
log "\n[4] Firewall and Network Security"
log "----------------------------------"
log "Firewall status:"; sudo ufw status | tee -a "$report_file"
log "\nOpen ports:"; ss -tuln | tee -a "$report_file"
log "\nIP Forwarding:"; cat /proc/sys/net/ipv4/ip_forward | tee -a "$report_file"

# 5. IP & Network Config
log "\n[5] IP Configuration Check"
log "---------------------------"
ip a | tee -a "$report_file"
log "\nPublic IP:"; curl -s ifconfig.me | tee -a "$report_file"

# 6. Security Updates
log "\n[6] Security Updates & Patching"
log "---------------------------------"
log "Available updates:"; sudo apt update -y > /dev/null && apt list --upgradable | tee -a "$report_file"

# 7. Log Monitoring
log "\n[7] Log Monitoring"
log "--------------------"
log "Recent SSH login attempts:"; grep "sshd" /var/log/auth.log | tail -n 10 | tee -a "$report_file"

# 8. Hardening Steps
log "\n[8] Server Hardening Check"
log "---------------------------"
log "Checking SSH config:"; grep -Ei "PermitRootLogin|PasswordAuthentication" /etc/ssh/sshd_config | tee -a "$report_file"
log "\nChecking IPv6 status:"; cat /proc/sys/net/ipv6/conf/all/disable_ipv6 | tee -a "$report_file"
log "\nChecking unattended upgrades:"; dpkg -l | grep unattended-upgrades | tee -a "$report_file"

# 9. Custom Checks Placeholder
log "\n[9] Custom Security Checks"
log "----------------------------"
log "No custom checks defined yet."

# 10. Report Summary
log "\n[10] Summary"
log "-------------"
log "Review the report at: $report_file"

echo -e "\nAudit complete . Report saved in $report_file"

