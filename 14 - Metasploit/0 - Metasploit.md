### Scan a Target Network using SMetasploit

We need to configure metasploit db

```
service postgresql start  
msfconsole  
db_status  
  
msfdb init  
  
service postgresql restart  

db_status
```

## Create Workspace

1. **Create (add) a workspace**

```bash
workspace -a my_workspace
```

This creates the workspace and makes it the current one.

2. **List workspaces**

```bash
workspace -l
```

The current workspace will be indicated in the list.

3. **Switch to an existing workspace**

```bash
workspace -s my_workspace
```

(Some older docs accept `workspace my_workspace` to switch.)

4. **Remove a workspace**

```bash
workspace -d my_workspace
```

---

Here, we are scanning the whole subnet 10.10.1.0/24 for active hosts.

```
db_nmap -Pn -sS -n -sV -O -p- -T4 -v3 10.10.1.0/24  
```

Type **hosts** and hit Enter to view the list of active hosts along with their MAC addresses, OS names, etc.
Type **services** or **db_services** and hit Enter to receive a list of the services running on the active hosts.


## Metasploit — View Hosts & Services (after `db_nmap`)

Compact reference: how to verify and explore results imported by `db_nmap` inside `msfconsole`.

## 1) List discovered hosts

```bash
msf6 > hosts
```

Typical columns: `address`, `mac`, `name`, `os_name`, `info`, `purpose`.

---

## 2) List discovered services

```bash
msf6 > services
```

Typical columns: `host`, `port`, `proto`, `name`, `state`, `info` (banner/version).

---

## 3) Common service filters

- By port:
    

```bash
msf6 > services -p 80
```

- By host:
    

```bash
msf6 > services -h 10.10.10.5
```

- Or use shell filtering if your `services` doesn't support flags:
    

```bash
msf6 > services | grep tcp
```

---

## 4) Related DB views

```bash
msf6 > vulns    # imported vulnerability info
msf6 > notes    # Nmap script output / manual notes
msf6 > creds    # discovered credentials
```

---

## 5) Workspaces

Make sure you are in the correct workspace — `hosts`/`services` are scoped per workspace.

```bash
msf6 > workspace -l
msf6 > workspace -s lab1
```

---

## 8) Exporting / Automation

- Export DB:
    

```bash
msf6 > db_export /tmp/msf_export.xml
```

- Use RC scripts to run scans and then show results:
    

```bash
# followup.rc
workspace -s lab1
db_nmap -sV 10.10.10.0/24
hosts
services
```

Run with:

```bash
msfconsole -r followup.rc
```

---

## Troubleshooting

- If `db_nmap` ran but `hosts`/`services` are empty: check `db_status` — the DB may have been disconnected at scan time.
    
- To import richer Nmap output manually:
    

```bash
nmap -sV --script=vuln -oX /tmp/scan.xml target
msf6 > db_import /tmp/scan.xml
```

---

## Common pitfalls & tips

- If `db_status` shows **not connected**, workspace data won’t persist. Fix the DB first with `msfdb init` or by starting PostgreSQL.
    
- Workspaces are **database-backed**: they separate hosts/services/creds/vulns per project — ideal for one engagement or lab per workspace.
    
- Prefer `db_import` of scanner XMLs (Nmap, etc.) rather than adding hosts manually for faster population
## High-Value Target Ports & Metasploit #metasploit  Modules

**Author:** Metasploit Helper

**Description:** A curated list of common ports running high-value services, along with reconnaissance, brute-force, and exploit modules for Metasploit. Always use scanners first to identify the exact service and version.

**Disclaimer:** For authorized security testing and educational purposes only.

---

## Port 21 - FTP (File Transfer Protocol)

**Common Service:** FTP Server (e.g., vsftpd, ProFTPD)

*   **Auxiliary #1 (Brute Force):**

```
use auxiliary/scanner/ftp/ftp_login
```

Purpose: Bruteforces username and password logins.

*   **Exploit #2 (vsftpd Backdoor):**

```
use exploit/unix/ftp/vsftpd_234_backdoor
```

Purpose: Exploits a backdoor in vsftpd version 2.3.4.
___

## Port 22 - SSH (Secure Shell)

**Use this Script before anything to see if the port has vulnerabilities**

```
nmap --script "ssh-*" -p 22
```

**Common Service:** SSH Server (OpenSSH)

*   **Auxiliary #1 (Brute Force):**

```
use auxiliary/scanner/ssh/ssh_login
```

   Purpose: The primary method for attacking SSH.

*   **Auxiliary #2 (User Enumeration):**

```
use auxiliary/scanner/ssh/ssh_enumusers
```

   Purpose: Enumerates valid system usernames on older OpenSSH versions.
___

## Port 23 - Telnet

**Common Service:** Telnet Server

*   **Auxiliary #1 (Brute Force):**

```
   use auxiliary/scanner/telnet/telnet_login
```

Purpose: Bruteforces logins on the unencrypted service.

*   **Exploit #2 (Encryption Option Exploit):**

```
use exploit/linux/telnet/telnet_encrypt_keyid
```

 Purpose: Exploits a vulnerability in the encryption option handling.
___

## Port 25 / 465 / 587 - SMTP

**Common Service:** Mail Server (Postfix, Sendmail, Exim)

*   **Auxiliary #1 (User Enumeration):**

```
use auxiliary/scanner/smtp/smtp_enum
```

Purpose: Enumerates valid users via VRFY, EXPN, or RCPT TO.

*   **Exploit #2 (Exim RCE):**

```
use exploit/linux/smtp/exim4_deliver_message_priv_esc
```

Purpose: Privilege escalation in specific Exim versions.
___

## Port 53 - DNS

**Common Service:** DNS Server (BIND)

*   **Auxiliary #1 (Version Info):**

```
use auxiliary/gather/dns_info
```

Purpose: Gathers version and information.

*   **Auxiliary #2 (Zone Transfer):**

```
use auxiliary/gather/dns_axfr
```

Purpose: Attempts a zone transfer to dump all DNS records.
___

## Port 80 / 443 / 8080 - HTTP/HTTPS

**Common Service:** Web Servers (Apache, Nginx, IIS) & Web Apps

*   **Auxiliary #1 (Service Identification):**

```
use auxiliary/scanner/http/http_version
```

Purpose: The critical first step for all web services.

*   **Exploit #2 (Tomcat Manager):**

```
use exploit/multi/http/tomcat_mgr_upload
```

Purpose: Uploads a malicious WAR file if manager app credentials are known.
___

## Port 110 / 995 - POP3

**Common Service:** Mail Retrieval Server

*   **Auxiliary #1 (Brute Force):**

```
use auxiliary/scanner/pop3/pop3_login
```

Purpose: Bruteforces email credentials.

*   **Auxiliary #2 (Version Scan):**

```
use auxiliary/scanner/pop3/pop3_version
```

Purpose: Discovers POP3 server software and version.
___

## Port 139 / 445 - SMB

**Common Service:** Windows File & Print Sharing

*   **Auxiliary #1 (Reconnaissance):**

```
use auxiliary/scanner/smb/smb_version
```

```
use auxiliary/scanner/smb/smb_enumshares
```

Purpose: Discovers OS version and available shares.

*   **Exploit #2 (EternalBlue):**

```
use exploit/windows/smb/ms17_010_eternalblue
```

Purpose: Exploits a critical vulnerability in SMBv1 (MS17-010).
___

## Port 143 / 993 - IMAP

**Common Service:** Mail Retrieval Server

*   **Auxiliary #1 (Brute Force):**

```
use auxiliary/scanner/imap/imap_login
```

Purpose: Bruteforces email credentials.

*   **Auxiliary #2 (Version Scan):**

```
use auxiliary/scanner/imap/imap_version
```

Purpose: Discovers IMAP server software and version.
___

## Port 1433 / 1434 - MSSQL

**Common Service:** Microsoft SQL Server

*   **Auxiliary #1 (Brute Force):**

```
use auxiliary/scanner/mssql/mssql_login
```

Purpose: Bruteforces the 'sa' and other user accounts.

*   **Exploit #2 (Command Execution):**

```
use exploit/windows/mssql/mssql_payload
```

Purpose: Executes a payload on the server via `xp_cmdshell`.
___

## Port 1521 - Oracle TNS

**Common Service:** Oracle Database

*   **Auxiliary #1 (SID & Login Brute Force):**

```
use auxiliary/scanner/oracle/sid_brute
```

```
use auxiliary/admin/oracle/oracle_login
```

Purpose: Discovers SIDs and then bruteforces logins.

*   **Auxiliary #2 (Authentication Sniffer):**

```
use auxiliary/sniffer/oracle
```

Purpose: Sniffs and cracks authentication hashes (requires MITM position).
___

## Port 27017 / 27018 - MongoDB

**Common Service:** MongoDB NoSQL Database

*   **Auxiliary #1 (Enumeration):**

```
use auxiliary/scanner/mongodb/mongodb_enum
```

Purpose: Lists databases if no authentication is enabled.

*   **Auxiliary #2 (Brute Force):**

```
use auxiliary/scanner/mongodb/mongodb_login
```

Purpose: Bruteforces credentials if authentication is enabled.
___

## Port 3389 - RDP

**Common Service:** Remote Desktop Protocol

*   **Auxiliary #1 (Brute Force):**

```
use auxiliary/scanner/rdp/rdp_login
```

Purpose: Bruteforces user credentials.

*   **Auxiliary #2 (BlueKeep Scanner):**

```
use auxiliary/scanner/rdp/cve_2019_0708_bluekeep
```

Purpose: Checks for the critical BlueKeep vulnerability (CVE-2019-0708).
___

## Port 4848 - Oracle GlassFish

**Common Service:** GlassFish Admin Console

*   **Auxiliary #1 (Brute Force):**

```
use auxiliary/scanner/http/glassfish_login
```

Purpose: Bruteforces the admin console login.

*   **Auxiliary #2 (Traversal - CVE-2017-1000028):**

```
use auxiliary/scanner/http/glassfish_traversal
```

Purpose: Reads sensitive files like `domain.xml` to steal password hashes.
____

## Port 5432 - PostgreSQL

**Common Service:** PostgreSQL Database

*   **Auxiliary #1 (Brute Force):**

```
use auxiliary/scanner/postgres/postgres_login
```

Purpose: Bruteforces database credentials.

*   **Exploit #2 (Command Execution):**

```
use exploit/linux/postgres/postgres_copy_from_program_cmd_exec
```

Purpose: Uses `COPY FROM PROGRAM` to execute commands on the OS.
___

## Port 5985 / 5986 - WinRM

**Common Service:** Windows Remote Management

*   **Auxiliary #1 (Brute Force):**

```
use auxiliary/scanner/winrm/winrm_login
```

Purpose: Bruteforces credentials for PowerShell remoting.

*   **Exploit #2 (Script Execution):**

```
use exploit/windows/winrm/winrm_script_exec
```

Purpose: Uploads and executes a payload using valid WinRM credentials.
___

## Port 5984 - Apache CouchDB

**Common Service:** CouchDB NoSQL Database

*   **Auxiliary #1 (Enumeration):**

```
use auxiliary/scanner/couchdb/couchdb_enum
```

Purpose: Gathers version and database information.

*   **Exploit #2 (RCE - CVE-2017-12635):**

```
use exploit/linux/http/apache_couchdb_cmd_exec
```

Purpose: Creates an admin user and gains RCE via the Erlang protocol.
___

## Port 6379 - Redis

**Common Service:** Redis In-Memory Data Store

*   **Auxiliary #1 (Information Gathering):**

```
use auxiliary/scanner/redis/redis_server
```

Purpose: Checks if authentication is required and gathers info.

*   **Exploit #2 (SSH Key Write):**

```
use exploit/linux/redis/redis_unauthorized_exec
```

Purpose: Writes an SSH key for root access if no authentication is present.
___

## Port 8009 - Apache JServ Protocol (AJP)

**Common Service:** AJP Connector (Tomcat)

*   **Auxiliary/Exploit #1 (Ghostcat - CVE-2020-1938):**

```
use auxiliary/admin/http/tomcat_ghostcat
```

```
use exploit/linux/http/tomcat_ghostcat
```

Purpose: Scans for and exploits a file read/inclusion vulnerability.
___

## Port 8282 - HTTP API Management

**Common Service:** Often WSO2, Synapse, or custom APIs

*   **Auxiliary #1 (Service Identification):**

```
use auxiliary/scanner/http/http_version
```

Purpose: **Critical.** Identifies the specific application running.

*   **Exploit #2 (WSO2 RCE):**

```
use exploit/multi/http/wso2_uploader_rce
```

Purpose: Exploits file upload functionality in WSO2 products for RCE.
___

## Port 8383 - HTTP Management Consoles

**Common Service:** VMware vCenter, File Services

*   **Auxiliary #1 (Service Identification):**

```
use auxiliary/scanner/http/http_version
```

Purpose: Identifies the service (e.g., vSphere Client).

*   **Exploit #2 (vCenter RCE - VMSA-2021-0010):**

```
use exploit/multi/http/vmware_vcenter_analytics_upload_ova
```

Purpose: Exploits an unauthenticated RCE in vCenter (CVE-2021-21972).
___

## Port 9000 / 9001 - Web Applications

**Common Service:** Portainer (Docker), Jenkins, SonarQube

*   **Auxiliary #1 (Service Identification):**

```
use auxiliary/scanner/http/http_version
```

```
use auxiliary/scanner/http/jenkins_enum` (if applicable)
```

Purpose: **Critical.** The attack path depends entirely on the identified service.

*   **Exploit #2 (Jenkins RCE):**

```
use exploit/multi/http/jenkins_script_console
```

Purpose: Executes Groovy code in the Jenkins Script Console for a shell.
___

## Port 9200 - Elasticsearch

**Common Service:** Elasticsearch REST API

*   **Auxiliary #1 (Info/Data Disclosure):**

```
use auxiliary/scanner/elasticsearch/indices_enum
```

Purpose: Enumerates all database indices if authentication is off.

*   **Exploit #2 (RCE - CVE-2014-3120):**

```
use exploit/multi/elasticsearch/script_mvel_rce
```

Purpose: Executes arbitrary Java code on older versions with scripting enabled.

  ___

## Port 10000 - Webmin

**Common Service:** Webmin System Administration

*   **Auxiliary #1 (Brute Force):**

```
use auxiliary/scanner/webmin/webmin_login
```

Purpose: Bruteforces the Webmin login.

*   **Exploit #2 (RCE - CVE-2019-15107):**

```
use exploit/linux/http/webmin_backdoor
```

Purpose: Exploits a backdoor in `password_change.cgi` for unauthenticated RCE.


---
