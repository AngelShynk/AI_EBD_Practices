# MySQL 8.4 + MySQL Workbench Installation Guide

This guide explains how to install **MySQL 8.4 (latest stable version)** and **MySQL Workbench** on **Windows** and **macOS**.

---

## 🔑 Example Root Password
When asked to create a MySQL **root password** during installation, use:

```
MySQL_Student123
```

⚠️ Note: This is just an example for class practice. Students can change it later if needed.

---

## 🖥️ Windows Installation

### 1. Download
1. Go to [MySQL Community Downloads](https://dev.mysql.com/downloads/).
2. Select **MySQL Installer for Windows**.
3. Download the **Windows (x86, 32-bit), MSI Installer**.
4. Click **Download** → *No thanks, just start my download*.

### 2. Install MySQL
1. Run the downloaded installer.
2. Choose **Developer Default** setup (includes MySQL Server + Workbench).
3. In configuration steps:
   - Server type: **Development Computer**
   - Authentication: **Use Strong Password Encryption**
   - Root password: `MySQL_Student123`
   - (Optional) Add extra users.

### 3. Test Installation
Open **Command Prompt** and run:
```bash
mysql -u root -p
```
Enter `MySQL_Student123` and you should see the MySQL prompt.

### 4. Workbench
- Open **MySQL Workbench**.
- Create a connection with:
  - Host: `localhost`
  - Port: `3306`
  - Username: `root`
  - Password: `MySQL_Student123`

---

## 🍏 macOS Installation

### 1. Download
1. Go to [MySQL Community Downloads](https://dev.mysql.com/downloads/).
2. Select **macOS** and download the **DMG Archive** for MySQL 8.4.

### 2. Install MySQL
1. Open the `.dmg` file and run the **MySQL Installer**.
2. Set root password to:
   ```
   MySQL_Student123
   ```
3. MySQL will be installed at `/usr/local/mysql/`.
4. Open **System Preferences → MySQL** to start/stop the server.

### 3. Install MySQL Workbench
- Download from [MySQL Workbench Downloads](https://dev.mysql.com/downloads/workbench/).
- Drag it into **Applications**.

### 4. Test Installation
Open **Terminal** and run:
```bash
mysql -u root -p
```
Enter `MySQL_Student123` to log in.

Then open **Workbench** and connect with:
- Host: `localhost`
- Port: `3306`
- Username: `root`
- Password: `MySQL_Student123`

---

## ✅ You’re Ready!
Now you have MySQL 8.4 and MySQL Workbench installed.  
Use MySQL Workbench for database design and queries, or the terminal/command prompt for practice.
