# Metasploit Vulnerability Scanning and Analysis Guide

A comprehensive guide for discovering, analyzing, and exploiting vulnerabilities using the Metasploit Framework.

## Table of Contents

- [Basic Vulnerability Searching](#basic-vulnerability-searching)
- [Web Application Vulnerabilities](#web-application-vulnerabilities)
- [Network Service Vulnerabilities](#network-service-vulnerabilities)
- [Privilege Escalation Techniques](#privilege-escalation-techniques)
- [Exploit Discovery and Matching](#exploit-discovery-and-matching)
- [Advanced Techniques](#advanced-techniques)
- [Best Practices](#best-practices)

---

## Basic Vulnerability Searching

### Core Search Commands

The `vulns` command is your primary tool for vulnerability management in Metasploit.

### List all discovered vulnerabilities

```bash
vulns
```

### Filter vulnerabilities by target IP

```
vulns -i 192.168.1.100
```

### Filter by specific ports

```
vulns -p 80,443,445,22
```

### Search for specific CVE

```
vulns -c CVE-2017-0144
```
### Show only critical severity vulnerabilities

```
vulns --severity critical
```

### Display high and critical vulnerabilities
```
vulns --severity high,critical
```

## Advanced Search and Filtering

### Complex search with multiple criteria

```bash
vulns -S "os:windows port:445 has_exploit:true"
```

### Search by service name

```
vulns -S "service:http"
````

### Filter by vulnerability type

```
vulns -S "type:sql_injection"
```

### Show detailed vulnerability information

```
vulns -v -i 192.168.1.100
```

### List vulnerabilities with available exploits

```
vulns -S "has_exploit:true"
```

## Database Management

### Update vulnerability database

```bash
vulns --update
```

### Export results to CSV for reporting

```
vulns -o vuln_report.csv
```

### Import vulnerability data

```
vulns --import vulnerability_data.xml
```
## Clear vulnerability database

```
vulns --clear
```

---
## Web Application Vulnerabilities

### SQL Injection Testing

### Basic SQL injection scanner

```bash
use auxiliary/scanner/http/sql_injection
set RHOSTS 192.168.1.100
set RPORT 80
set TARGETURI /login.php
set VERBOSE true
run
```

### Advanced SQL injection with custom payloads

```bash
use auxiliary/scanner/http/blind_sql_injection
set RHOSTS target.com
set TARGETURI /search.php
set METHOD POST
set DATA "query=test"
run
```

### Cross-Site Scripting (XSS) Detection

### XSS vulnerability scanner

```bash
use auxiliary/scanner/http/xss
set RHOSTS 192.168.1.100
set TARGETURI /search.php
set METHOD GET
set QUERY "q"
run
```

### Reflected XSS testing

```bash
use auxiliary/scanner/http/reflected_xss
set RHOSTS target.com
set TARGETURI /contact.php
run
```

## File Inclusion Vulnerabilities

### Local File Inclusion (LFI) scanner

```bash
use auxiliary/scanner/http/file_inclusion
set RHOSTS 192.168.1.100
set TARGETURI /index.php
set PARAMETER file
run```

# Remote File Inclusion (RFI) testing

```bash
use auxiliary/scanner/http/rfi_scanner
set RHOSTS target.com
set TARGETURI /page.php
run
```

### Content Management System Scanning

# WordPress vulnerability scanner

```bash
use auxiliary/scanner/http/wordpress_scanner
set RHOSTS wordpress-site.com
set TARGETURI /
set ENUMERATE_USERNAMES true
set ENUMERATE_PLUGINS true
set ENUMERATE_THEMES true
run
```

# Joomla scanner

```bash
use auxiliary/scanner/http/joomla_scanner
set RHOSTS joomla-site.com
run
```

### Drupal scanner

```bash
use auxiliary/scanner/http/drupal_scanner
set RHOSTS drupal-site.com
run
```

## Additional Web Application Modules

### Apache path normalization vulnerability

```bash
use auxiliary/scanner/http/apache_normalize_path
set RHOSTS 192.168.1.100
run
```

### JBoss vulnerability scanner

```bash
use auxiliary/scanner/http/jboss_vulnscan
set RHOSTS 192.168.1.100
set RPORT 8080
run
```

### Directory traversal scanner

```bash
use auxiliary/scanner/http/dir_traversal
set RHOSTS target.com
run
```

---

## Network Service Vulnerabilities

### SMB Service Vulnerabilities
### EternalBlue (MS17-010) scanner

```bash
use auxiliary/scanner/smb/smb_ms17_010
set RHOSTS 192.168.1.0/24
set THREADS 50
run
```

### SMB version detection

```bash
use auxiliary/scanner/smb/smb_version
set RHOSTS 192.168.1.0/24
run
```

### SMB share enumeration

```bash
use auxiliary/scanner/smb/smb_enumshares
set RHOSTS 192.168.1.100
run
```

### SMB user enumeration

```bash
use auxiliary/scanner/smb/smb_enumusers
set RHOSTS 192.168.1.100
run
```

### SSH Service Analysis

### SSH version scanner

```bash
use auxiliary/scanner/ssh/ssh_version
set RHOSTS 192.168.1.0/24
run
```

### SSH user enumeration

```bash
use auxiliary/scanner/ssh/ssh_enumusers
set RHOSTS 192.168.1.100
set USER_FILE /usr/share/wordlists/metasploit/unix_users.txt
run
```

### SSH login brute force

```bash
use auxiliary/scanner/ssh/ssh_login
set RHOSTS 192.168.1.100
set USERNAME admin
set PASS_FILE /usr/share/wordlists/rockyou.txt
run
```

### FTP Service Scanning

### FTP anonymous access scanner

```bash
use auxiliary/scanner/ftp/anonymous
set RHOSTS 192.168.1.0/24
run
```

### FTP version detection

```bash
use auxiliary/scanner/ftp/ftp_version
set RHOSTS 192.168.1.0/24
run
```

### FTP brute force

```
use auxiliary/scanner/ftp/ftp_login
set RHOSTS 192.168.1.100
set USER_FILE /usr/share/wordlists/metasploit/unix_users.txt
run
```

## Database Service Vulnerabilities

### MySQL scanner

```bash
use auxiliary/scanner/mysql/mysql_version
set RHOSTS 192.168.1.100
run
```

### MSSQL scanner

```bash
use auxiliary/scanner/mssql/mssql_ping
set RHOSTS 192.168.1.0/24
run
```

### PostgreSQL scanner

```bash
use auxiliary/scanner/postgres/postgres_version
set RHOSTS 192.168.1.100
run
```

## Pro Tip: Comprehensive Network Scanning

Combine Metasploit scanning with Nmap for comprehensive network analysis:

### From within Metasploit

```bash
db_nmap -sV --script vuln 192.168.1.0/24
```

---

# Privilege Escalation Techniques

## Windows Privilege Escalation

### Automated local exploit suggester

```bash
use post/multi/recon/local_exploit_suggester
set SESSION 1
set SHOWDESCRIPTION true
run
```

### Check for AlwaysInstallElevated registry setting

```bash
use post/windows/gather/credentials/enum_cred_store
set SESSION 1
run
```

### Windows privilege escalation enumeration

```bash
use post/windows/gather/enum_system
set SESSION 1
run
```

### Check for unquoted service paths

```bash
use post/windows/gather/enum_services
set SESSION 1
run
```

### Enumerate installed patches

```bash
use post/windows/gather/enum_patches
set SESSION 1
run
```

## Linux Privilege Escalation

### Comprehensive Linux system enumeration

```bash
use post/linux/gather/enum_system
set SESSION 1
set VERBOSE true
run
```

### Check sudo permissions and configurations

```bash
use post/linux/gather/enum_sudo
set SESSION 1
run
```

### Find SUID/SGID binaries

```
use post/linux/gather/checkvm
set SESSION 1
run
```

### Enumerate cron jobs

```bash
use post/linux/gather/enum_cron
set SESSION 1
run
```

### Check for writable directories

```bash
use post/linux/gather/enum_protections
set SESSION 1
run
```

## Cross-Platform Enumeration

### Multi-platform system information

```bash
use post/multi/gather/env
set SESSION 1
run
```

### Network configuration enumeration

```bash
use post/multi/gather/netstat
set SESSION 1
run
```

### Process enumeration

```bash
use post/multi/gather/pidstat
set SESSION 1
run
```

---

# Exploit Discovery and Matching

## Manual Exploit Discovery

### Search for exploits by service type

```bash
search type:exploit platform:windows target:smb
```

### Search by specific CVE identifier

```
search cve:CVE-2017-0144
```

### Search for remote exploits

```
search type:exploit rank:excellent
```

### Search by application name

```
search name:apache type:exploit
```

### Search for post-exploitation modules

```
search type:post platform:linux
```

## Exploit Information Gathering

### Get detailed information about an exploit

```bash
info exploit/windows/smb/ms17_010_eternalblue
```

### Show exploit options and requirements

```
show options
```

### Display exploit targets

```
show targets
```

### Show available payloads

```
show payloads
```


### Check exploit ranking and reliability

```
info exploit/linux/local/overlayfs_priv_esc
```

## Automated Exploit Matching

### Automated exploit suggestion based on session

```bash
use post/multi/recon/local_exploit_suggester
set SESSION 1
set SHOWDESCRIPTION true
set VERBOSE true
run
```

### Generate comprehensive exploit report

```
use auxiliary/analyze/report_generation
set WORKSPACE default
run
```

---

# Advanced Techniques

## Database Integration

### Initialize database connection

```bash
db_status
```

### Import Nmap XML results

```
db_import /path/to/nmap_results.xml
```

### Create and switch workspaces

```
workspace -a project_name
workspace project_name
```

### Export data for external analysis

```
db_export -f xml /path/to/export.xml
```

## Custom Vulnerability Scripts

### Create custom auxiliary scanner

```bash
use auxiliary/scanner/custom/custom_vuln_check
set RHOSTS 192.168.1.100
set CUSTOM_PARAM value
run
```

### Load external vulnerability definitions

```
load_vulnerability_db /path/to/custom_vulns.json
```

## Reporting and Documentation

### Generate HTML vulnerability report

```bash
use auxiliary/analyze/report_html
set WORKSPACE current
set OUTPUT /path/to/report.html
run
```

### Create executive summary

```
use auxiliary/analyze/executive_summary
set CRITICAL_ONLY true
run
```

---

## Best Practices

### Planning and Preparation

1. **Scope Definition**: Always define clear testing boundaries
2. **Authorization**: Ensure proper written authorization before testing
3. **Backup Plans**: Have rollback procedures for any changes made

### Scanning Strategy

1. **Gradual Approach**: Start with passive reconnaissance, then active scanning
2. **Network Segmentation**: Consider network topology and potential impact
3. **Timing**: Be mindful of business hours and system criticality

### Documentation

1. **Detailed Logs**: Maintain comprehensive logs of all activities
2. **Evidence Collection**: Document findings with screenshots and command outputs
3. **Timeline Tracking**: Record timestamps for all testing activities

### Exploitation Guidelines

1. **Minimal Impact**: Use least invasive methods first
2. **Session Management**: Properly manage and clean up sessions
3. **Data Protection**: Avoid accessing sensitive data unless specifically authorized

### Post-Testing Activities

1. **System Cleanup**: Remove any artifacts left during testing
2. **Vulnerability Validation**: Confirm all findings are legitimate
3. **Report Generation**: Create clear, actionable reports for stakeholders

### Legal and Ethical Considerations

> **WARNING**: These tools and techniques should only be used on systems you own or have explicit written permission to test. Unauthorized access to computer systems is illegal and may result in criminal charges.

#### Key Points

- Always obtain proper authorization before testing
- Respect scope limitations and boundaries
- Follow responsible disclosure practices
- Maintain confidentiality of discovered vulnerabilities
- Document all activities for accountability

---

*This guide is for educational and authorized security testing purposes only. Always ensure you have proper authorization before conducting any security assessments.*