<h1 style="padding-left:16px; border-left:8px solid #378ADD;">The Setup</h1>

This lab uses a single virtual machine on an IBM Cloud environment that includes Db2, Db2 Genius Hub, and an Agentic Application to simulate workload scenarios.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Environment Overview</h2>

The lab environment is fully provisioned — all required components are pre-installed so you can focus on exploration and hands-on tasks rather than installation.

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Installed Components</h3>

| Component | Version |
|---|---|
| Db2 Advanced Enterprise Server Edition (Single Partition) | 12.1.5 |
| Db2 Genius Hub | 1.1.5.0 |
| Db2 Remote Service | 1.1.5.0 |
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
| `ghinfo` or `info` | Display environment details |
| `start-services.sh` | Start all required services |
| `ghstatus` | Check status of Db2 Genius Hub services |
| `ghstart` | Start Db2 Genius Hub services |
| `ghstop` | Stop Db2 Genius Hub services |
| `ghrestart` | Restart Db2 Genius Hub services |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Accessing the Lab Environment</h2>

All services in this lab are accessed through the **Guacamole remote desktop** provided by IBM TechZone. There are no publicly exposed application ports — Genius Hub, the Agentic Demo UI, JupyterLab, and DBeaver are all accessed from inside the desktop session using `localhost` URLs.

> **⚠️ Important — Start Services First:** Genius Hub does **not** start automatically after deployment. Before accessing any services, you must run the startup script. See **Step 1** below.

| Service | How to Access |
|---|---|
| **Guacamole Desktop** | TechZone reservation page → open the desktop link |
| **Genius Hub Console** | Inside desktop → Firefox → `https://localhost:11101/console` |
| **Agentic Demo UI** | Inside desktop → Firefox → `http://localhost:3000` |
| **JupyterLab** | Inside desktop → Firefox → `http://localhost:8888` |
| **DBeaver** | Inside desktop → Applications menu → DBeaver |
| **Db2 Host (for Genius Hub)** | `localhost` |
| **Db2 Port (db2inst1)** | `25010` |
| **Db2 Port (db2inst2 / REPODB)** | `25011` |
| **SSH Access** | `ssh -i ssh_private_key.pem YOUR-USER@YOUR-PUBLIC-IP -p 2223` |

> **ℹ️ SSH key:** Download your SSH private key (`ssh_private_key.pem`) from the TechZone reservation page using the **"Deployment SSH private key"** download button.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Default Credentials</h2>

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Genius Hub UI</h3>

| Field | Value |
|---|---|
| URL | `https://localhost:11101/console` (inside Guacamole desktop) |
| Username | `admin` |
| Password | `Db2ghPassw0rd#1` |

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Db2 Users</h3>

The following users are pre-configured. All share the same password.

| Username | Password | Notes |
|---|---|---|
| `db2inst1` | `Db2ghPassw0rd#1` | Db2 instance owner (port 25010) |
| `db2inst2` | `Db2ghPassw0rd#1` | Repo instance owner (port 25011) |
| `db2demo` | `Db2ghPassw0rd#1` | Demo user — primary lab user |
| `db2ghadm` | `Db2ghPassw0rd#1` | Genius Hub admin |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Setup and Configuration</h2>

Follow these steps to prepare the environment for the lab.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 1 — Start All Services</h3>

Before doing anything else, open the **Guacamole desktop** from the TechZone reservation page, then open a **Terminal** and run:

```bash
~/start-services.sh
```

This starts Db2, Genius Hub, the Remote Service, and the Agentic Demo UI. Wait for it to complete before proceeding.

> **ℹ️ Note:** You can run `ghinfo` or `info` at any time from a terminal to check the status and see all credentials and URLs.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 2 — Open the Guacamole Desktop</h3>

All lab work is done inside the Guacamole remote desktop:

1. Go to your TechZone reservation page
2. Click the **Guacamole** desktop link to open the full GNOME desktop in your browser
3. Inside the desktop, open **Firefox** for all web-based lab tasks

> **ℹ️ Tip:** You can copy/paste text into the Guacamole session using the Guacamole clipboard (the tab on the left edge of the screen).

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 3 — SSH Access (Optional)</h3>

SSH access is available if you need a terminal outside of the Guacamole desktop.

Download your SSH private key from the TechZone reservation page by clicking the **"Deployment SSH private key"** download button. Then connect:

```bash
ssh -i ssh_private_key.pem YOUR-USER@YOUR-PUBLIC-IP -p 2223
```

> **ℹ️ Replace** `YOUR-USER` and `YOUR-PUBLIC-IP` with the values shown on your TechZone reservation page.

**Mac/Linux — set key permissions first:**

```bash
chmod 600 ssh_private_key.pem
```

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Architecture Summary</h2>

| Layer | Technology |
|---|---|
| Operating System | RHEL 9.x |
| Database | Db2 Advanced Enterprise Server Edition 12.1.5 |
| Console | Db2 Genius Hub 1.1.5.0 |
| Remote Service | Db2 Remote Service 1.1.5.0 (port 8080) |
| Agentic UI | Next.js frontend with FastAPI backend |
| Desktop Access | GNOME Desktop via Guacamole (port 443) |
| Deployment | Automated using Ansible |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">What You Will Achieve</h2>

By completing this section, you will:

- ✅ Start and verify all lab services
- ✅ Access the Genius Hub and Agentic AI interfaces via Guacamole
- ✅ Prepare the environment for the hands-on exercises that follow

> **💡 Tip:** If you encounter issues, run `ghinfo` from any terminal to validate system status and confirm services are running.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Next Steps</h2>

This completes the setup of Db2 Genius Hub.

**[← Introduction](00-introduction.md)** &nbsp;&nbsp;|&nbsp;&nbsp; **[→ Login and Repository Setup](02-01-login-and-repo.md)**

---
