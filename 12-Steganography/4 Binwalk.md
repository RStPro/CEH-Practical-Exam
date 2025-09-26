# 🔎 Binwalk Cheat Sheet

## 📌 What is it?

`binwalk` is a tool for **analyzing, reverse engineering, and extracting firmware images**. It scans binary files to detect embedded files, executable code, compressed data, and file systems.

---

## ⚡ Basic Syntax

```bash
binwalk [options] <file>
```

---

## 🔧 Main Options

|Option|Description|
|---|---|
|`binwalk file.bin`|Scan a binary for known file signatures.|
|`-e`|Extract files from the binary automatically.|
|`-E`|Use exhaustive extraction (try harder).|
|`-M`|Perform recursive scans/extractions (scan extracted files too).|
|`-B`|Search for common byte sequences.|
|`-R <regex>`|Search for custom signatures using regex.|
|`-y <magic>`|Search for specific file types (e.g., `png`).|
|`--dd=".*"`|Extract only files that match regex (e.g., only PNGs).|

---

## 🚀 Examples

### 1. Basic scan of a firmware image

```bash
binwalk firmware.bin
```

### 2. Extract embedded files

```bash
binwalk -e firmware.bin
```

### 3. Recursive extraction (scan extracted files too)

```bash
binwalk -Me firmware.bin
```

### 4. Extract only PNG files

```bash
binwalk --dd='png image:png' firmware.bin
```

### 5. Search for strings matching regex (e.g., passwords)

```bash
binwalk -R "password" firmware.bin
```

### 6. Carve only specific file types

```bash
binwalk -y 'zip' firmware.bin
```

### 7. Extract hidden files from images

```bash
binwalk -e suspicious.png
```

If an image has extra data appended (e.g., a hidden ZIP or archive), Binwalk can carve and extract it.

---

## ⚠️ Extraction Notes (–run-as)

When using `-e`, Binwalk relies on third-party tools (tar, unzip, unsquashfs, etc.). By default, it refuses to run them as **root** for safety.

If you see this error:

```
Binwalk extraction uses many third party utilities, which may not be secure...
```

### ✅ Fix

Run:

```bash
binwalk -e --run-as=root file.bin
```

### 🔒 Safer Alternatives

- Extract as a **non-privileged user**:
    

```bash
binwalk -e --run-as=parrot file.bin
```

- Or use a **sandbox/VM** to avoid executing untrusted binaries as root.
    

---

## 📂 Common Use Cases

- Extract **firmware images** from IoT devices.
    
- Recover embedded files (images, configs, executables).
    
- Identify **compressed archives** inside binaries (gzip, tar, zip).
    
- Detect **file systems** (SquashFS, JFFS2) inside firmware.
    
- Search for **secrets** like API keys or passwords.
    
- Extract **hidden files from images** (stego by appending data).
    

---

## 🧠 Tips

- Use `-Me` for deep extraction when exploring unknown firmware.
    
- Combine with `strings` and `grep` for hidden info:
    

```bash
strings firmware.bin | grep admin
```

- Mount extracted file systems using `mount` or `unsquashfs`.
    
- Be cautious: some firmware images or media files may contain **malicious binaries**. Analyze safely in a VM or sandbox.