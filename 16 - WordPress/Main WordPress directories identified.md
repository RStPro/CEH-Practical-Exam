
Main WordPress directories identified 

🔑 Core Directories 

 WordPress admin dashboard.

```
/wp-admin/
```

 core WordPress files and libraries. 

```
/wp-includes/
```

 main content directory. 

```
/wp-content/
```

📂 Inside 

```
/wp-content/
```


installed themes. 
```
/wp-content/themes/
```

 installed plugins.
```
/wp-content/plugins/ 
```

user-uploaded files (often browsable if directory listing is enabled).
```
/wp-content/uploads/  
```

 caching data (if enabled). 
```
/wp-content/cache/
```

 language files.
```
/wp-content/languages/ 
```

 must-use plugins (autoloaded).
```
/wp-content/mu-plugins/ 
```

📄 Common Files 

 WordPress configuration (contains DB credentials). 
```
/wp-config.php
```

 XML-RPC interface (can be abused for brute force or DDoS). 
```
/xmlrpc.php
```

 reveals WordPress version. /license.txt → default license file. 
```
/readme.html
```

 handles scheduled tasks. 
```
/wp-cron.php
```

 sometimes reveals version info. 
```
/wp-links-opml.php
```

 used for multisite activation. 
```
/wp-activate.php
```

 user registration page (if enabled). 🔒 Sensitive or Hidden Targets 
```
/wp-signup.php
```

 installer (should be deleted/disabled after setup). 
```
/wp-admin/install.php
```

 upgrade script. 
```
/wp-admin/upgrade.php
```

Backup files: 

```
wp-config.php.bak
```

```
wp-config.old 
```

Hidden files: 

.htaccess, 
.user.ini, 
.env. 

⚠️ Enumeration Tips Always check if directory listing is enabled. Look for exposed backup or config files. 
Pay attention to plugin and theme directories: outdated or vulnerable code is common.