
1 - ifconfig - to discover the network were he is - 192.168.56.106
2 - the network is 192.168.56.0/24
3 - netdiscover - to see what other machines are in the network
4 - there is one other machine in the network 192.168.56.113
5 - nmap - to see what open ports are open - sudo nmap -Pn -sV -T4 -p- 192.168.56.113
6 - found several open ports:

![[Pasted image 20250818184316.png]]

checking port 80 - http://192.168.56.113:80

![[Pasted image 20250818184530.png]]

![[Pasted image 20250818184616.png]]

![[Pasted image 20250818184701.png]]

trying to check the internet about default php credentials - no luck

searching vulnerabilities for Apache httpd 2.2.8 - vulnerable to XSS - authentication bypass - CVE 2017-3167

chmod on the file: chmod +x 29316.py

checking internet how to use the file. - no luck

check gobuster for this ip: gobuster dir -u http://192.168.56.113:80 -w /usr/share/wordlists/dirb/common.txt

![[Pasted image 20250818190839.png]]

got php version: 5.2.4-2ubuntu5.10

Checking metasploit. but before add a new workspace for this machine.

add workspace m2 : workspace -a m2

add nmap to metasploit db: db_nmap nmap -Pn -sV -T4 -p- 192.168.56.113

search apache 2.2 

![[Pasted image 20250818191559.png]]

set RHOST; LHOST

and run -  too long

Trying other ports

rpcbind - no
mysql - 
tomcat port 8180 - tomcat : tomcat works

