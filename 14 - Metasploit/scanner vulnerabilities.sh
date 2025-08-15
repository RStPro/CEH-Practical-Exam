Quick Navigation
Basic Searching
Web App Vulns
Network Vulns
Priv Escalation
Exploit Matching
🔍 Metasploit Vulnerability Search
Complete Guide to Finding and Analyzing Vulnerabilities

Basic
Web Apps
Network
Priv Esc
Exploit Match
🔎 Basic Vulnerability Searching
Core Search Commands
Copy
# List all vulnerabilities
vulns

# Filter by IP address
vulns -i 192.168.1.100

# Filter by port
vulns -p 80,443,445

# Search by CVE
vulns -c CVE-2017-0144

# Show critical vulnerabilities
vulns --severity critical
Advanced Search Techniques
Copy
# Combined filters
vulns -S "os:windows port:445 has_exploit:true"

# Export results to CSV
vulns -o vuln_report.csv

# Update vulnerability database
vulns --update

# Show vulnerability details
vulns -v -i 192.168.1.100
🕸️ Web Application Vulnerabilities
Common Web Scans
Copy
# Scan for SQL injection
use auxiliary/scanner/http/sql_injection
set RHOSTS 192.168.1.100
run

# Check for XSS vulnerabilities
use auxiliary/scanner/http/xss
set TARGETURI /login.php
run

# Test for file inclusion
use auxiliary/scanner/http/file_inclusion
run
Web App Modules
scanner/http/wordpress_scanner
scanner/http/jboss_vulnscan
scanner/http/apache_normalize_path
CMS Scanning
# WordPress scan
use auxiliary/scanner/http/wordpress_scanner
set TARGETURI /wp-admin
🌐 Network Service Vulnerabilities
Common Network Scans
Copy
# SMB vulnerabilities
use auxiliary/scanner/smb/smb_ms17_010
run

# SSH vulnerabilities
use auxiliary/scanner/ssh/ssh_version
run

# FTP anonymous access
use auxiliary/scanner/ftp/anonymous
run
💡 Pro Tip: Combine with db_nmap -sV --script vuln for comprehensive network scanning.
⬆️ Privilege Escalation Checks
Windows Privilege Escalation
Copy
# Local exploit suggester
use post/multi/recon/local_exploit_suggester
set SESSION 1
run

# Check for AlwaysInstallElevated
use post/windows/gather/credentials/enum_cred_store
run
Linux Privilege Escalation
Copy
# Check SUID binaries
use post/linux/gather/enum_system
run

# Check sudo permissions
use post/linux/gather/enum_sudo
run
💥 Exploit Matching Techniques
Manual Exploit Matching
Copy
# Find exploits for a service
search type:exploit platform:windows target:smb

# Match by CVE
search cve:CVE-2017-0144

# Check exploit requirements
info exploit/windows/smb/ms17_010_eternalblue
Automated Matching
Copy
# Auto-match vulnerabilities to exploits
use post/multi/manage/exploit_suggester
set SHOWDESCRIPTION true
run

# Generate exploit report
use reporting/exploit_report
run