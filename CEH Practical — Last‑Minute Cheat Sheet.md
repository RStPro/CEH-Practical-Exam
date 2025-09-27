
**Quick, practical, exam‑ready checklist** — keep this visible during the exam.

---

## 1) First 10 minutes — scope & reconnaissance

- Confirm target IP(s) and flag submission process.
    
- Quick host discovery: `nmap -sn <IP>` (if allowed).
    
- Full port/service enumeration (first proper scan):
    

```bash
nmap -sC -sV -p- -T4 -n --min-rate 1000 -oA nmap/full <IP>
```

- Save results; note open ports + versions.
    

---

## 2) Web app quick path

- Directory fuzzing:
    

```bash
gobuster dir -u http://<IP> -w /usr/share/wordlists/dirb/common.txt -x php,txt,html -t 50 -o gobuster.txt
```

- Common checks: `whatweb`, `nikto`, `wpscan` (if WP).
    
- Try file uploads, LFI/RFI, auth endpoints, forgotten backups (`.bak`, `.old`).
    

---

## 3) SMB / Windows path

- Enumerate shares:
    

```bash
smbclient -L //<IP> -N
smbmap -H <IP>
```

- Check for credentials leakage in share files; search for `.xml`, `.bak`, `.config`, `credentials`.
    

---

## 4) Passwords & hashes

- Extract hashes (if found) then quick crack:
    

```bash
john --format=NT --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
hashcat -m 1000 hash.txt /usr/share/wordlists/rockyou.txt --force
```

- Try credential reuse across services: SMB, WinRM, RDP, SSH, web admin.
    

---

## 5) Reverse shells & listeners

- Keep listeners ready (use `rlwrap` for stability):
    

```bash
rlwrap nc -lvnp 443
# or for meterpreter
msfconsole -q
use exploit/multi/handler
set PAYLOAD linux/x86/meterpreter/reverse_tcp
set LHOST <yourIP>
set LPORT 443
exploit -j
```

- Common ports: 443, 80, 8080, 8443, 53 (if filtered elsewhere).
    

---

## 6) Privilege Escalation

- Linux checklist:
    
    - `sudo -l`, `uname -a`, `cat /etc/os-release`
        
    - `find / -perm -4000 -type f 2>/dev/null`
        
    - Run `linpeas.sh` (if allowed) and search for writable scripts, credentials, cron.
        
- Windows checklist:
    
    - `whoami /priv`, `systeminfo`, `net user`, `accesschk` if available
        
    - Run `winPEAS.exe`, hunt for weak service binaries, stored creds, scheduled tasks.
        

---

## 7) Pivoting & post‑exploitation

- SSH tunnelling: `ssh -L 8080:10.10.10.5:80 user@host`
    
- Use `proxychains` or `socks` through `ssh -D` for tools needing proxy.
    
- After foothold, enumerate internal subnet, creds, tokens, keys.
    

---

## 8) Time management & strategy

- 6 hours total: aim ~90–120 min per machine; submit flags ASAP when you obtain them.
    
- If stuck for 20–30 min, move to next target and come back.
    
- Document every step (commands + outputs) for reproduction and evidence.
    

---

## 9) Exam practical sanity checklist

- Tools to verify installed: `nmap`, `gobuster`/`ffuf`, `nikto`, `whatweb`, `john`/`hashcat`, `smbclient`, `msfconsole`, `nc`, `winPEAS`, `linpeas`.
    
- Save outputs frequently (`-oA`, `-oN`, `> file.txt`).
    
- Keep a spare terminal for listeners.
    

---

## 10) Calm, practical reminders

- Don’t tunnel on one technique; enumeration usually yields a pivot.
    
- Reuse credentials found anywhere.
    
- Flags often live in user directories, config files, web backups, or DB dumps.
    

---

## Handy one‑liners (copy & paste)

```bash
# Nmap all ports + scripts
nmap -sC -sV -p- -T4 -n -oA nmap/full <IP>

# Fuzz web directories
gobuster dir -u http://<IP> -w /usr/share/wordlists/dirb/common.txt -x php,txt,html -t 50

# Find SUID on linux
```