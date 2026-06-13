## 1. The Setup

This lab uses a single virtual machine on an IBM Cloud environment that includes Db2, Db2 Genius Hub, and an Agentic Application to simulate workload scenarios.

### 1.1 Environment Overview

The lab environment is fully provisioned — all required components are pre-installed so you can focus on exploration and hands-on tasks rather than installation.

**Installed components:**

| Component | Version |
|---|---|
| Db2 AI Advanced Edition (Single Partition) | 12.1.4 |
| Db2 Genius Hub | 1.1.2.0 |
| Agentic Demo UI | — |

**Pre-configured databases:**

- `demo_col`
- `demo_row`
- `REPODB` *(created on first Genius Hub login)*

**Utility scripts available on the VM:**

| Script | Purpose |
|---|---|
| `ghinfo` | Display environment details |
| `start-services.sh` | Start required services |
| `ghstatus` | Check status of Db2 Genius Hub services |
| `ghstart` | Start Db2 Genius Hub services |
| `ghstop` | Stop Db2 Genius Hub services |
| `ghrestart` | Restart Db2 Genius Hub services |

---

### 1.2 Accessing the Lab Environment

| Service | Endpoint |
|---|---|
| **Genius Hub Web Console** | `https://<public-ip>:11101` |
| **Agentic Demo UI** | `http://<public-ip>:3000` |
| **Db2 Host (for Genius Hub)** | `localhost` |
| **Db2 Host (for external tools)** | `YOUR-EXTERNAL-IP` |
| **Db2 Port** | `25011` |
| **SSH Access** | `ssh -i YOUR-FILE.pem YOUR-USER@YOUR-EXTERNAL-IP -p 2223` |

> Replace `YOUR-FILE.pem`, `YOUR-USER`, `YOUR-EXTERNAL-IP`, and `<public-ip>` with the values provided for your lab environment.

---

### 1.3 Default Credentials

#### Genius Hub UI

| Field | Value |
|---|---|
| Username | `admin` |
| Password | `Db2ghPassw0rd#1` |

#### Db2 Users

The following users are pre-configured. All share the same password.

| Username | Password |
|---|---|
| `db2inst1` | `Db2ghPassw0rd#1` |
| `db2demo` | `Db2ghPassw0rd#1` |
| `db2ghadm` | `Db2ghPassw0rd#1` |

---

### 1.4 Setup and Configuration

Follow these steps to prepare the environment for the lab.

---

#### 1.4.1 Student SSH Access

This guide will help you connect to your IBM TechZone lab environment using SSH (Secure Shell). Your instructor will provide you with:

- Your VM's **public IP address**
- Your personal **PEM key file** (e.g., `student_01.pem`, `student_02.pem`)

All students connect as the `db2demo` user on their own dedicated VM.

##### Prerequisites

**Windows Users** — You'll need an SSH client:
- **Windows 10/11 (Built-in):** PowerShell or Command Prompt *(recommended)*
- **PuTTY:** Download from [https://www.putty.org/](https://www.putty.org/)

**Mac/Linux Users** — SSH is already installed. Use the Terminal application.

##### Step-by-Step Instructions

**Step 1: Get Your PEM File and IP Address**

Your instructor will provide:
- Your `.pem` file (e.g., `student_01.pem`)
- Your VM's public IP address (e.g., `52.118.191.168`)

Write them down — you'll need them throughout these steps.

---

**Step 2: Set File Permissions**

> **Security requirement:** SSH requires that your private key file is not publicly readable.

**Mac/Linux:**

Navigate to where your `.pem` file is saved and set permissions (replace `student_01` with your file name):
```bash
cd ~/Desktop
chmod 600 student_01.pem
```

**Windows — GUI method:**

a. Right-click `student_01.pem` and select **Properties → Security**
b. Click **Advanced → Disable inheritance**
c. Choose **Remove all inherited permissions**
d. Click **Add → Select a principal**
e. Type your Windows username → **Check Names → OK**
f. Check **Full control → OK → Apply → OK**

**Windows — PowerShell method** (replace `student_01` with your file name):
```powershell
icacls student_01.pem /inheritance:r
icacls student_01.pem /grant:r "%USERNAME%:F"
```

---

**Step 3: Connect via SSH**

**Mac/Linux/Windows (PowerShell or Command Prompt):**

a. Navigate to where your `.pem` file is saved:

```bash
cd ~/Desktop
```

b. Connect using the following command (replace `student_01` with your file name and `52.118.191.168` with your VM's IP address):

```bash
ssh -i student_01.pem db2demo@52.118.191.168 -p 2223
```

c. The first time you connect, you'll see a host authenticity prompt:
```
The authenticity of host '[52.118.191.168]:2223' can't be established.
Are you sure you want to continue connecting (yes/no)?
```
Type `yes` and press Enter.

d. You should now see a Linux prompt:
```
[db2demo@db2gh-demo ~]$
```

---

**Windows (PuTTY):**

First, convert your `.pem` key to PuTTY's `.ppk` format:

a. Open **PuTTYgen**, click **Load**, and select your `.pem` file *(change the file filter to "All Files")*
b. Click **Save private key** and save as `student_01.ppk`

Then connect using PuTTY:

c. Open **PuTTY** and enter the following settings:

| Field | Value |
|---|---|
| Host Name | Your VM's IP address (e.g., `52.118.191.168`) |
| Port | `2223` |
| Connection type | SSH |

d. In the left menu, navigate to **Connection → SSH → Auth**
e. Under **Private key file**, browse and select your `.ppk` file
f. Click **Open** and log in as `db2demo`

---

#### 1.4.2 Start Genius Hub Services

a. Switch to the `db2ghadm` user:
```bash
sudo su - db2ghadm
```

b. Start the Genius Hub services:
```bash
ghstart
```

> **Note:** `ghstart` is a convenience alias created for this lab. It is not part of the Genius Hub product installation.

```
Updating the application server bootstrap and environment properties ...
Updating the applications ...
Sat Jun 6 01:51:17 UTC 2026 Starting IBM Db2 Genius Hub.

Starting server dsweb.
Server dsweb started with process ID 26583.
Sat Jun 6 01:51:44 UTC 2026 Successfully started IBM Db2 Genius Hub.
******************************************************************************

Summary
	* Web console HTTP URL
 		http://itzvsi-tfmdjcqj:11100/console

	* Web console HTTPS URL
 		https://itzvsi-tfmdjcqj:11101/console

```

b. Check the Genius Hub services status:
```bash
ghstatus
```

> **Note:** `ghstatus` is a convenience alias created for this lab. It is not part of the Genius Hub product installation.

```
[db2ghadm@itzvsi-tfmdjcqj ibm-db2GeniusHub]$ ghstatus
==========================================
IBM Db2 Genius Hub - Product Status Check
==========================================

Component Status Summary:
---------------------------------------------------------------------------------
Component                 Status          Details
---------------------------------------------------------------------------------
Liberty Server            RUNNING         PID: 26583   | Port(s): 11100(HTTP),11101(HTTPS)
Agentic AI Service        STOPPED         -
Anomaly Detection Service STOPPED         -
DRS Agent Service         RUNNING         PID: 27023   | Port(s): 11096
Job Scheduler Service     RUNNING         PID: 27090   | Port(s): 11107
Redis Service             STOPPED         -
---------------------------------------------------------------------------------

Overall Status: [WARNING] Liberty is running but 3 addon(s) are not running
```

> **Note:** Some services may show as `STOPPED` until Genius Hub is fully configured and addon services are started. These will be enabled in later steps.


---

### 1.5 Architecture Summary

This lab environment is built on:

- RHEL 9.x operating system
- Db2 AI Advanced Edition 12.1.4
- Db2 Genius Hub 1.1.2.0 with management aliases
- Next.js-based Agentic Demo UI with a FastAPI backend
- Automated deployment using Ansible

---

### 1.6 What You Will Achieve

By completing this section, you will:

- Gain access to a fully configured Db2 AI environment
- Start and verify Db2 Genius Hub services
- Access both the Genius Hub and Agentic AI interfaces
- Prepare the environment for the hands-on exercises that follow

> **Tip:** If you encounter issues, rerun `ghinfo` to validate the system status and confirm services are running.

You will need this terminal window open for other tasks in this lab, keep it open.

---
### 1.7 Next Steps

This completes the setup of Db2 Genius Hub. Proceed to [Section 2. The Basics](02-basics.md).

---
