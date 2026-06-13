<h1 style="padding-left:16px; border-left:8px solid #378ADD;">The Setup</h1>

This lab uses a single virtual machine on an IBM Cloud environment that includes Db2, Db2 Genius Hub, and an Agentic Application to simulate workload scenarios.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Environment Overview</h2>

The lab environment is fully provisioned — all required components are pre-installed so you can focus on exploration and hands-on tasks rather than installation.

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Installed Components</h3>

| Component | Version |
|---|---|
| Db2 AI Advanced Edition (Single Partition) | 12.1.4 |
| Db2 Genius Hub | 1.1.2.0 |
| Agentic Demo UI | — |

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Pre-Configured Databases</h3>

| Database | Notes |
|---|---|
| `demo_col` | Column-organized database |
| `demo_row` | Row-organized database |
| `REPODB` | Created on first Genius Hub login |

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Utility Scripts</h3>

| Script | Purpose |
|---|---|
| `ghinfo` | Display environment details |
| `start-services.sh` | Start required services |
| `ghstatus` | Check status of Db2 Genius Hub services |
| `ghstart` | Start Db2 Genius Hub services |
| `ghstop` | Stop Db2 Genius Hub services |
| `ghrestart` | Restart Db2 Genius Hub services |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Accessing the Lab Environment</h2>

| Service | Endpoint |
|---|---|
| **Genius Hub Web Console** | `https://<public-ip>:11101` |
| **Agentic Demo UI** | `http://<public-ip>:3000` |
| **Db2 Host (for Genius Hub)** | `localhost` |
| **Db2 Host (for external tools)** | `YOUR-EXTERNAL-IP` |
| **Db2 Port** | `25011` |
| **SSH Access** | `ssh -i YOUR-FILE.pem YOUR-USER@YOUR-EXTERNAL-IP -p 2223` |

> **⚠️ Replace** `YOUR-FILE.pem`, `YOUR-USER`, `YOUR-EXTERNAL-IP`, and `<public-ip>` with the values provided for your lab environment.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Default Credentials</h2>

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Genius Hub UI</h3>

| Field | Value |
|---|---|
| Username | `admin` |
| Password | `Db2ghPassw0rd#1` |

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Db2 Users</h3>

The following users are pre-configured. All share the same password.

| Username | Password |
|---|---|
| `db2inst1` | `Db2ghPassw0rd#1` |
| `db2demo` | `Db2ghPassw0rd#1` |
| `db2ghadm` | `Db2ghPassw0rd#1` |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Setup and Configuration</h2>

Follow these steps to prepare the environment for the lab.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 1 — Student SSH Access</h3>

This guide will help you connect to your IBM TechZone lab environment using SSH (Secure Shell). Your instructor will provide:

- Your VM's **public IP address**
- Your personal **PEM key file** (e.g., `student_01.pem`, `student_02.pem`)

All students connect as the `db2demo` user on their own dedicated VM.

<h4 style="padding-left:14px; border-left:4px solid #888780;">Prerequisites</h4>

**Windows Users** — You'll need an SSH client:

| Option | Notes |
|---|---|
| PowerShell / Command Prompt | Built into Windows 10/11 *(recommended)* |
| PuTTY | Download from [https://www.putty.org/](https://www.putty.org/) |

**Mac/Linux Users** — SSH is already installed. Use the Terminal application.

---

<h4 style="padding-left:14px; border-left:4px solid #888780;">Step 1a — Get Your PEM File and IP Address</h4>

Your instructor will provide:
- Your `.pem` file (e.g., `student_01.pem`)
- Your VM's public IP address (e.g., `52.118.191.168`)

Write them down — you'll need them throughout the lab.

---

<h4 style="padding-left:14px; border-left:4px solid #888780;">Step 1b — Set File Permissions</h4>

> **🔒 Security requirement:** SSH requires that your private key file is not publicly readable.

**Mac/Linux:**

Navigate to where your `.pem` file is saved and run (replace `student_01` with your file name):

```bash
cd ~/Desktop
chmod 600 student_01.pem
```

**Windows — GUI method:**

1. Right-click `student_01.pem` → **Properties → Security**
2. Click **Advanced → Disable inheritance**
3. Choose **Remove all inherited permissions**
4. Click **Add → Select a principal**
5. Type your Windows username → **Check Names → OK**
6. Check **Full control → OK → Apply → OK**

**Windows — PowerShell method** (replace `student_01` with your file name):

```powershell
icacls student_01.pem /inheritance:r
icacls student_01.pem /grant:r "%USERNAME%:F"
```

---

<h4 style="padding-left:14px; border-left:4px solid #888780;">Step 1c — Connect via SSH</h4>

**Mac/Linux/Windows (PowerShell or Command Prompt):**

Navigate to where your `.pem` file is saved:

```bash
cd ~/Desktop
```

Connect using the following command (replace `student_01` with your file name and `52.118.191.168` with your VM's IP address):

```bash
ssh -i student_01.pem db2demo@52.118.191.168 -p 2223
```

The first time you connect, you'll see a host authenticity prompt. Type `yes` and press Enter:

```
The authenticity of host '[52.118.191.168]:2223' can't be established.
Are you sure you want to continue connecting (yes/no)?
```

You should now see a Linux prompt:

```
[db2demo@db2gh-demo ~]$
```

---

**Windows (PuTTY):**

First, convert your `.pem` key to PuTTY's `.ppk` format:

1. Open **PuTTYgen**, click **Load**, and select your `.pem` file *(change the file filter to "All Files")*
2. Click **Save private key** and save as `student_01.ppk`

Then connect using PuTTY:

| Field | Value |
|---|---|
| Host Name | Your VM's IP address (e.g., `52.118.191.168`) |
| Port | `2223` |
| Connection type | SSH |

3. In the left menu, navigate to **Connection → SSH → Auth**
4. Under **Private key file**, browse and select your `.ppk` file
5. Click **Open** and log in as `db2demo`

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 2 — Start Genius Hub Services</h3>

Switch to the `db2ghadm` user:

```bash
sudo su - db2ghadm
```

Start the Genius Hub services:

```bash
ghstart
```

> **ℹ️ Note:** `ghstart` is a convenience alias created for this lab. It is not part of the Genius Hub product installation.

Expected output:

```
Updating the application server bootstrap and environment properties ...
Updating the applications ...
Sat Jun 6 01:51:17 UTC 2026 Starting IBM Db2 Genius Hub.

Starting server dsweb.
Server dsweb started with process ID 26583.
Sat Jun 6 01:51:44 UTC 2026 Successfully started IBM Db2 Genius Hub.

Summary
    * Web console HTTP URL
        http://itzvsi-tfmdjcqj:11100/console

    * Web console HTTPS URL
        https://itzvsi-tfmdjcqj:11101/console
```

Check the Genius Hub services status:

```bash
ghstatus
```

Expected output:

```
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

> **ℹ️ Note:** Some services may show as `STOPPED` until Genius Hub is fully configured and addon services are started. These will be enabled in later steps.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Architecture Summary</h2>

| Layer | Technology |
|---|---|
| Operating System | RHEL 9.x |
| Database | Db2 AI Advanced Edition 12.1.4 |
| Console | Db2 Genius Hub 1.1.2.0 with management aliases |
| Agentic UI | Next.js frontend with FastAPI backend |
| Deployment | Automated using Ansible |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">What You Will Achieve</h2>

By completing this section, you will:

- ✅ Gain access to a fully configured Db2 AI environment
- ✅ Start and verify Db2 Genius Hub services
- ✅ Access both the Genius Hub and Agentic AI interfaces
- ✅ Prepare the environment for the hands-on exercises that follow

> **💡 Tip:** If you encounter issues, rerun `ghinfo` to validate the system status and confirm services are running.

> **⚠️ Keep this terminal window open** — you will need it for other tasks in this lab.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Next Steps</h2>

This completes the setup of Db2 Genius Hub.

**[← Introduction](00-introduction.md)** &nbsp;&nbsp;|&nbsp;&nbsp; **[→ Login and Repository Setup](02-01-login-and-repo.md)**

---
