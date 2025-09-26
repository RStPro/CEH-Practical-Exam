### Basic Network Discovery

```
nmap -sn <IP>/24
```
  
### Full Port Scan with Service and OS Detection

```
nmap -sS -sCV -O -A -p- <IP>
```
  
### Scan without DNS Resolution

```
nmap -Pn -n -T4 -sCV -O -p- <IP>
```

- `-sS`: TCP SYN scan
- `-sC`: Default scripts
- `-sV`: Version detection
- `-O`: OS detection
- `-A`: Aggressive scan
- `-Pn`: Treat all hosts as up
- `-n`: Skip DNS resolution
- `-T4`: Speed up scan

## Most Common Flags

| **Flag**          | **Purpose**                                           | **Example**                   |
| ----------------- | ----------------------------------------------------- | ----------------------------- |
| `-sS`             | **TCP SYN scan** (stealthy, half-open)                | `nmap -sS <target>`           |
| `-sT`             | **TCP Connect scan** (full connection)                | `nmap -sT <target>`           |
| `-sU`             | **UDP scan**                                          | `nmap -sU <target>`           |
| `-sN`             | **TCP NULL scan** (no flags set)                      | `nmap -sN <target>`           |
| `-sF`             | **TCP FIN scan** (sends FIN flag only)                | `nmap -sF <target>`           |
| `-sX`             | **TCP Xmas scan** (FIN, PSH, URG flags set)           | `nmap -sX <target>`           |
| `-p-`             | Scan **all 65535 ports**                              | `nmap -p- <target>`           |
| `-p <ports>`      | Scan **specific ports**                               | `nmap -p 21,22,80 <target>`   |
| `-sV`             | **Service/version detection**                         | `nmap -sV <target>`           |
| `-O`              | **OS detection**                                      | `nmap -O <target>`            |
| `-A`              | **Aggressive scan** (OS, version, script, traceroute) | `nmap -A <target>`            |
| `-T<0-5>`         | Set **timing template** (0 = slowest, 5 = fastest)    | `nmap -T4 <target>`           |
| `-Pn`             | Skip **host discovery** (treat hosts as up)           | `nmap -Pn <target>`           |
| `-n`              | Disable **DNS resolution**                            | `nmap -n <target>`            |
| `-v` / `-vv`      | Increase **verbosity**                                | `nmap -v -sS <target>`        |
| `-oN <file>`      | Output scan to a **normal text file**                 | `nmap -oN scan.txt <target>`  |
| `-oX <file>`      | Output scan to **XML**                                | `nmap -oX scan.xml <target>`  |
| `--script <name>` | Run **NSE scripts** (e.g., vuln, ftp-anon)            | `nmap --script vuln <target>` |
| `-iL <file>`      | Scan **targets from a list**                          | `nmap -iL targets.txt`        |
## Objectives:
### 1. host discovery
  
-sn - disable port scan
-PR - ARP ping scan
nmap -sn -PR [IP address]
-PU - performs the UDP ping scan. on top of telling us the machine is up it also gives us the mac address

### nmap -sn -PU [IP address]

### -PE - ICMP ECHO ping scan. (same as -PU) - We send an Echo ping request and the active machine respondes with an Echo ping reply

### nmap -sn -PE [IP address]

### nmap -sn -PE [Target Range of IP Addresses] - (here, the target range of IP addresses is 10.10.1.10-23) - it gives us the same as -PU with all active machine for the given targuet IP range.

### -PP: performs the ICMP timestamp ping scan. - same as -PU but with the time stamp of the other machine

### nmap -sn -PP [Target IP Address]

You can specify to use any or a group of these installed scripts; moreover, you can install other user’s scripts and use them for your scans.

Let’s begin with the default scripts.
You can choose to run the scripts in the default category using `--script=default` or simply adding `-sC`.
In addition to [default](https://nmap.org/nsedoc/categories/default.html), categories include auth, broadcast, brute, default, discovery, dos, exploit, external, fuzzer, intrusive, malware, safe, version, and vuln. A brief description is shown in the following table.

| Script Category | Description                                                            |
| --------------- | ---------------------------------------------------------------------- |
| `auth`          | Authentication related scripts                                         |
| `broadcast`     | Discover hosts by sending broadcast messages                           |
| `brute`         | Performs brute-force password auditing against logins                  |
| `default`       | Default scripts, same as `-sC`                                         |
| `discovery`     | Retrieve accessible information, such as database tables and DNS names |
| `dos`           | Detects servers vulnerable to Denial of Service (DoS)                  |
| `exploit`       | Attempts to exploit various vulnerable services                        |
| `external`      | Checks using a third-party service, such as Geoplugin and Virustotal   |
| `fuzzer`        | Launch fuzzing attacks                                                 |
| `intrusive`     | Intrusive scripts such as brute-force attacks and exploitation         |
| `malware`       | Scans for backdoors                                                    |
| `safe`          | Safe scripts that won’t crash the target                               |
| `version`       | Retrieve service versions                                              |
| `vuln`          | Checks for vulnerabilities or exploit vulnerable services              |

Some scripts belong to more than one category. Moreover, some scripts launch brute-force attacks against services, while others launch DoS attacks and exploit systems. Hence, it is crucial to be careful when selecting scripts to run if you don’t want to crash services or exploit them.

We use Nmap to run a SYN scan against `10.10.37.104` and execute the default scripts in the console shown below.
The command is `sudo nmap -sS -sC 10.10.37.104`, where `-sC` will ensure that Nmap will execute the default scripts following the SYN scan.


