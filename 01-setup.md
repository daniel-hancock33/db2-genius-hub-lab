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

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Finding Your Environment Details</h2>

During your workshop session, you will access the lab through the **TechXchange Student Portal**:

1. Open the **Access URL** provided by your instructor (e.g., `https://ibm.biz/...`).
2. Enter the session passcode provided by your instructor.
3. You will be assigned a personal environment card (e.g. **Student 1 - LAB-2216**).

| Item on Student Page | What it is for | How you will use it |
|---|---|---|
| **Guacamole Remote Desktop link** | In-browser Linux desktop with all tools pre-installed | Click the link to open the desktop immediately (no password needed) |
| **Public IP Address** (e.g. `150.240.x.x`) | Unique IP address of your VM | Used only if you connect via direct SSH from your laptop |
| **Deployment SSH private key (`.pem`)** | SSH key file | Download this key to SSH in via port `2223` as user `itzuser` |

> 💡 **Keep your Student Environment page open in a tab** so you can reference links and download files if needed.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Accessing the Lab Environment</h2>

All services in this lab are accessed through the **Guacamole remote desktop** in your browser (recommended). Genius Hub, the Agentic Demo UI, JupyterLab, and DBeaver are all pre-installed inside the desktop session using `localhost` URLs.

| Service | How to Access |
|---|---|
| **Guacamole Desktop** | Student page → click Guacamole desktop link |
| **Genius Hub Console** | Inside desktop → Firefox → `https://localhost:11101/console` |
| **Agentic Demo UI** | Inside desktop → Firefox → `http://localhost:3000` |
| **JupyterLab** | Inside desktop → Firefox → `http://localhost:8888` |
| **DBeaver** | Inside desktop → Applications menu → DBeaver |
| **Db2 Host (for Genius Hub)** | `localhost` |
| **Db2 Port (db2inst1)** | `25010` |
| **Db2 Port (db2inst2 / REPODB)** | `25011` |
| **SSH Access (Optional)** | `ssh -i <your-key>.pem itzuser@YOUR-PUBLIC-IP -p 2223` |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Default Credentials</h2>

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Genius Hub UI</h3>

| Field | Value |
|---|---|
| URL | `https://localhost:11101/console` (inside Guacamole desktop) |
| Username | `admin` |
| Password | `Db2ghPassw0rd#1` |

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Db2 Users</h3>

The following database and service users are pre-configured. All share the same default password:

| Username | Password | Role / Purpose |
|---|---|---|
| `db2inst1` | `Db2ghPassw0rd#1` | Db2 instance owner (port 25010) |
| `db2inst2` | `Db2ghPassw0rd#1` | Repo instance owner (port 25011) |
| `db2demo` | `Db2ghPassw0rd#1` | Demo user — primary lab user |
| `db2ghadm` | `Db2ghPassw0rd#1` | Genius Hub administrator |
| `itzuser` | *(SSH key only)* | Lab desktop and SSH user (port 2223, no password needed) |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Setup Steps</h2>

Follow these quick steps to launch the lab:

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 1 — Open the Guacamole Desktop</h3>

1. On your **Student Environment page**, click the **Guacamole remote desktop link**.
2. The remote desktop session will open automatically in your browser tab — no separate password is required.
3. Firefox will open automatically with this lab guide.

> **ℹ️ Tip:** Read **[Using the Guacamole Desktop](01a-guacamole.md)** for clipboard copy/paste instructions, window sizing, and troubleshooting.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 2 — Start All Lab Services</h3>

> **⚠️ Important:** Genius Hub and the demonstration services do **not** run automatically on boot. You must run the startup script once.

Inside the Guacamole desktop:
1. Open a **Terminal** (Right-click desktop → **Open Terminal**, or use Applications menu top-left).
2. Run the startup script:

```bash
sudo /root/start-services.sh
```

3. Wait 1–2 minutes for all services (Db2, Genius Hub, Remote Service, Agentic UI) to start.
4. You can check status at any time by running:

```bash
ghinfo
```

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 3 — SSH Access (Optional)</h3>

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

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 4 — SSH Tunnel (Optional)</h3>

Use a tunnel if you would rather work in **your own laptop's browser** than in the Guacamole desktop. A tunnel forwards ports on your laptop to the VM, so `https://localhost:11101/console` on your laptop reaches Genius Hub on the VM.

> **ℹ️ Before you start:** You need the **public IP address** and the **SSH private key** (`ssh_private_key.pem`) from your TechZone reservation details page, as described in Step 3. In the commands below, replace `YOUR-PUBLIC-IP` with that IP address.

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
