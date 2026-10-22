<!-- Source of truth: this file (ww-databases-tx2026-lab2216/db2gh-demo/docs/lab-guide-01-setup.md)
     Edit here with Bob, then copy to 01-setup.md in db2-genius-hub-lab and push. -->
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

All services in this lab are accessed through the **Guacamole remote desktop** provided by IBM TechZone (recommended). Genius Hub, the Agentic Demo UI, JupyterLab, and DBeaver are all accessed from inside the desktop session using `localhost` URLs. Optionally, you can use an **SSH tunnel** (Step 4) to reach them from your own browser.

> **⚠️ Important — Start Services First:** Genius Hub does **not** start automatically after deployment. Before accessing any services, you must run the startup script. See **Step 1** below.

| Service | How to Access |
|---|---|
| **Guacamole Desktop** | TechZone reservation page → open the desktop link → log in as `itzuser` |
| **Genius Hub Console** | Inside desktop → Firefox → `https://localhost:11101/console` |
| **Agentic Demo UI** | Inside desktop → Firefox → `http://localhost:3000` |
| **JupyterLab** | Inside desktop → Firefox → `http://localhost:8888` |
| **DBeaver** | Inside desktop → Applications menu → DBeaver |
| **Db2 Host (for Genius Hub)** | `localhost` |
| **Db2 Port (db2inst1)** | `25010` |
| **Db2 Port (db2inst2 / REPODB)** | `25011` |
| **SSH Access** | `ssh -i ssh_private_key.pem itzuser@YOUR-PUBLIC-IP -p 2223` (IP and key are on your reservation details page, see below) |

> **ℹ️ Where to find your IP address and SSH key:** Open your **TechZone reservation details page**. The **public IP address** is listed in the details, and the **SSH private key** (`ssh_private_key.pem`) is downloaded with the **"Deployment SSH private key"** download button. The Guacamole desktop link is on the same page.

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
| `itzuser` | — | TechZone user: Guacamole desktop login and SSH (SSH key only, port 2223) |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Setup and Configuration</h2>

Follow these steps to prepare the environment for the lab.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 1 — Start All Services</h3>

> **ℹ️ Not in your Guacamole desktop yet?** See **[Introduction → Accessing Your Lab Environment](00-introduction.md#accessing-your-lab-environment)** for how to get there.

Open a **Terminal** inside the Guacamole desktop (or SSH in, see Step 2) and run:

```bash
sudo /root/start-services.sh
```

This starts Db2, Genius Hub, the Remote Service, and the Agentic Demo UI. Wait for it to complete before proceeding.

> **ℹ️ Note:** You can run `ghinfo` or `info` at any time from a terminal to check the status and see all credentials and URLs.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 2 — SSH Access (Optional)</h3>

SSH access is available if you need a terminal outside of the Guacamole desktop.

Your **public IP address** and **SSH private key** are on your TechZone reservation details page. Download the key by clicking the **"Deployment SSH private key"** download button, then connect:

```bash
ssh -i ssh_private_key.pem itzuser@YOUR-PUBLIC-IP -p 2223
```

> **ℹ️ Replace** `YOUR-PUBLIC-IP` with the public IP address shown on your TechZone reservation page. The SSH user is always `itzuser`, the same user you use to log in to the Guacamole desktop.

**Mac/Linux — set key permissions first:**

```bash
chmod 600 ssh_private_key.pem
```

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 3 — SSH Tunnel (Optional)</h3>

Use a tunnel if you would rather work in **your own laptop's browser** than in the Guacamole desktop. A tunnel forwards ports on your laptop to the VM, so `https://localhost:11101/console` on your laptop reaches Genius Hub on the VM.

> **ℹ️ Before you start:** You need the **public IP address** and the **SSH private key** (`ssh_private_key.pem`) from your TechZone reservation details page, as described in Step 2. In the commands below, replace `YOUR-PUBLIC-IP` with that IP address.

> **ℹ️ Note:** The command appears to hang. That is normal: `-N` means "forward ports, don't open a shell". **Keep the window open** while you work. Press `Ctrl+C` to close the tunnel.

Forwarded ports: `11100`/`11101` (Genius Hub), `3000` (Agentic Demo), `8000` (Agentic backend), `8888` (JupyterLab), `25010`/`25011` (Db2).

**Mac/Linux:**

```bash
chmod 600 ssh_private_key.pem
ssh -i ssh_private_key.pem itzuser@YOUR-PUBLIC-IP -p 2223 \
  -L 11100:localhost:11100 -L 11101:localhost:11101 -L 3000:localhost:3000 \
  -L 8000:localhost:8000 -L 8888:localhost:8888 -L 25010:localhost:25010 \
  -L 25011:localhost:25011 -N
```

**Windows 10/11 (PowerShell):**

Windows includes the OpenSSH client. Check with `ssh -V` (if missing: Settings → Apps → Optional features → add **OpenSSH Client**).

1. Save the key, for example `C:\Users\<you>\Downloads\ssh_private_key.pem`.
2. Restrict its permissions (SSH refuses keys that other users can read):

    ```powershell
    icacls C:\Users\<you>\Downloads\ssh_private_key.pem /inheritance:r
    icacls C:\Users\<you>\Downloads\ssh_private_key.pem /grant:r "$($env:USERNAME):(R)"
    ```

3. Run the tunnel as **one line**:

    ```powershell
    ssh -i C:\Users\<you>\Downloads\ssh_private_key.pem itzuser@YOUR-PUBLIC-IP -p 2223 -L 11100:localhost:11100 -L 11101:localhost:11101 -L 3000:localhost:3000 -L 8000:localhost:8000 -L 8888:localhost:8888 -L 25010:localhost:25010 -L 25011:localhost:25011 -N
    ```

4. Leave the window open, then browse to `https://localhost:11101/console`.

**Windows with PuTTY (alternative):**

1. **PuTTYgen** → Load the `.pem` (file filter: All Files) → *Save private key* as `.ppk`.
2. **PuTTY** → Session: Host Name = your public IP, Port = `2223`.
3. Connection → Data: Auto-login username = `itzuser`.
4. Connection → SSH → Auth → Credentials: select the `.ppk`.
5. Connection → SSH → Tunnels: for **each** port `11100, 11101, 3000, 8000, 8888, 25010, 25011`, enter *Source port* = the port and *Destination* = `localhost:<port>`, then click **Add**.
6. (Optional) Connection → SSH: tick *Don't start a shell or command at all*.
7. Return to Session, optionally save it, and click **Open**.

Once the tunnel is up, the `localhost` URLs in the table above work from your laptop's browser. Genius Hub uses a self-signed certificate, so continue past the browser warning.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Troubleshooting</h2>

| Symptom | Fix |
|---|---|
| Db2 or Agentic Demo not running | Run `sudo /root/start-services.sh` (Step 1) |
| Need to open Guacamole desktop | See **[Introduction → Accessing Your Lab Environment](00-introduction.md#accessing-your-lab-environment)** |
| Genius Hub page won't load | `su - db2ghadm`, then `ghstart`. Check with `ghstatus` |
| Check Db2 status | `su - db2inst1` then `db2pd -` (use `db2inst2` for the repo instance) |
| Tunnel: `administratively prohibited` | SSH in normally (no `-L`) and run: `sudo sed -i 's/^AllowTcpForwarding no/AllowTcpForwarding yes/' /etc/ssh/sshd_config && sudo systemctl restart sshd`, then retry the tunnel |
| Tunnel: `Address already in use` / `bind` error | Another program uses that local port. Close it, or change the first number of that `-L` (for example `-L 13000:localhost:3000`, then browse to port 13000) |
| `UNPROTECTED PRIVATE KEY FILE` | Mac/Linux: `chmod 600 ssh_private_key.pem`. Windows: run the `icacls` commands in Step 4 |
| `Permission denied (publickey)` | Wrong key or user. Use the key and user from **this** reservation |
| `Connection timed out` | Check the public IP, and use port **2223** (not 22) |

**Convert to DPF (optional, run as root):**

```bash
ansible-playbook /root/post_deploy/db2gh-demo/playbooks/post-install-db2-convert-to-dpf.yml
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

**[← Introduction](00-introduction.md)** &nbsp;&nbsp;|&nbsp;&nbsp; **[→ Using the Guacamole Desktop](01a-guacamole.md)**

---
