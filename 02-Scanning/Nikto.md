## Example Usage

```
nikto -h http://target.com
```

### Common Options

- `-h`: Target host or URL
- `-p`: Specify port (default is 80)
- `-ssl`: Force SSL scan
- `-Tuning x`: Scan tuning options (e.g., file uploads, interesting files, etc.)
- `-output result.txt`: Save output to a file
## Example with SSL and output file

```
nikto -h https://target.com -output nikto_results.txt
```

# Nikto Cheat Sheet
## 🔹 Basic Usage

```bash
nikto -h <target>
```

- `<target>` = IP, domain, or URL  

  

---

  

## 🔹 Target & Ports

```bash
nikto -h example.com       # Scan domain
```

```
nikto -h 192.168.1.10      # Scan IP
```

```
nikto -h example.com -p 8080  # Custom port
```

  

---

  

## 🔹 Output Options

```bash
nikto -h example.com -o results.txt          # Save results
```

```
nikto -h example.com -o report.xml -Format xml   # Save as XML
```

```
nikto -h example.com -o report.json -Format json # Save as JSON
```

---
## 🔹 Scan Tuning

```
nikto -h example.com -Tuning 123
```

Categories:  

- `1` = Interesting files  
- `2` = Misconfigurations  
- `3` = Default files  
- `4` = Information Disclosure  
- `5` = Injection vulnerabilities  
- `6` = Server-related issues  
- `7` = XSS vulnerabilities  

---
## 🔹 SSL / Protocols

```bash
nikto -h example.com -ssl      # Force SSL
```

```
nikto -h https://example.com   # Auto-detect SSL
```

```
nikto -h example.com -nossl    # Disable SSL
```

---
## 🔹 Evading Detection

```bash
nikto -h example.com -useragent "Mozilla/5.0"   # Custom User-Agent
```

```
nikto -h example.com -useproxy                  # Use proxy
```

---
## 🔹 Miscellaneous

```bash
nikto -list-plugins    # Show all available plugins
```

```
nikto -D VHOST         # Virtual host scanning
```

```
nikto -timeout 10      # Set timeout in seconds
```

---
## 🔹 Example Scans

```bash
nikto -h http://example.com                 # Standard scan
```

```
nikto -h 192.168.1.15 -p 8081               # Non-standard port
```

```
nikto -h example.com -Tuning 45             # Focused tuning scan
```

```
nikto -h example.com -o scan.json -Format json   # JSON output
```

---
⚡ **Tip**: Nikto is best used with other tools (Nmap, Burp Suite, Metasploit) for deeper analysis.