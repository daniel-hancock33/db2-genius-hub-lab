<h1 style="padding-left:16px; border-left:8px solid #378ADD;">Section 2 — The Basics</h1>

In the previous section, you connected to your dedicated virtual machine and started the Db2 Genius Hub services. This section shifts focus to the Genius Hub UI itself — learning your way around the interface and understanding the key pages and features you'll use throughout the rest of the lab.

> **📋 Reference:** See [Section 1.3 Default Credentials](01-setup.md#default-credentials) for login details.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Genius Hub Login</h2>

Open a browser (Google Chrome, Mozilla Firefox, Microsoft Edge, or Safari) and navigate to the Db2 Genius Hub URL provided by your instructor.

> **📋 Reference:** See [Section 1.2 Accessing the Lab Environment](01-setup.md#accessing-the-lab-environment) for the URL.

<img src="images/GH-login.png" width="600"/>

Enter your credentials and click **Login**:

| Field | Value |
|---|---|
| Username *(a)* | `admin` |
| Password *(b)* | `Db2ghPassw0rd#1` |

Click **Accept all** *(c)*, then click **Login** *(d)*.

> **⚠️ Caution:** Be careful when typing the password. After 3 incorrect attempts, the username will be locked and all users running this lab will be locked out.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Configure Repository (First Login Setup)</h2>

At first login, you must configure the repository database to initialize the IBM Db2 Genius Hub environment.

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 1 — Configure Repository</h3>

After logging in, you will be automatically taken to the **Configure repository** page.

<img src="images/Repo-welcome.png" width="800"/>

**Connection and database:**

| Label | Field | Value |
|---|---|---|
| **a** | Host | `localhost` |
| **b** | Port | `25011` |
| **c** | Database | `REPODB` |
| — | Repository schema | `IBMCONSOLE` (default) |
| — | JDBC URL attribute | *(leave empty)* |

**Security and credential:**

| Label | Field | Value |
|---|---|---|
| — | Use SSL | ☐ Unchecked |
| — | Security type | Clear text password |
| **d** | Username | `db2ghadm` |
| **e** | Password | `Db2ghPassw0rd#1` |

Click **Test connection** *(f)* to validate. When successful:

> ✅ *Connect to repository successfully.*

> **ℹ️ Note:** This process may take a few minutes as all `REPODB` database objects are being created.

Click **Next** *(g)* to continue.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 2 — Set Statistics Event Monitor Opt-In</h3>

<img src="images/stats-monitor-opt-in.png" width="800"/>

Enable the **Set statistics event monitor opt-in** option by switching the toggle to **On**.

This feature automatically enables statistics event monitoring on database connections and is required for the **Responsiveness** widget on the Monitor > Summary page to display data.

> **ℹ️ Note:** Enabling this option creates additional Db2 objects and may incur additional resource usage.

Click **Next** to continue.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 3 — Connection and Database</h3>

Configure the connection parameters to establish a connection to your Db2 database.

<img src="images/Connection-and-database.png" width="800"/>

**Connection and database:**

| Label | Field | Value |
|---|---|---|
| **a** | Connection name | `demo_col` |
| **b** | Host | `localhost` |
| **c** | Port | `25010` |
| **d** | Database | `demo_col` |

**Security and credential:**

| Label | Field | Value |
|---|---|---|
| **e** | Enable monitoring data collection | ☑ Checked |
| **f** | Username | `db2demo` |
| **g** | Password | `Db2ghPassw0rd#1` |

Click **Test connection (h)** → *Connect to demo_col successfully.*

**Enable Jobs to Run:**

| Label | Field | Value |
|---|---|---|
| **i** | Enable jobs to run | ☑ Checked |
| **j** | Username | `db2demo` |
| **k** | Password | `Db2ghPassw0rd#1` |

Click **Test connection (l)** → *Connect to demo_col successfully.*

**Enable Personal Credential:**

| Label | Field | Value |
|---|---|---|
| **m** | Enable personal credential | ☑ Checked |
| **n** | Username | `db2demo` |
| **o** | Password | `Db2ghPassw0rd#1` |

Select **Save credentials to repository (q)**.

Click **Test connection (p)** → *Connect to demo_col successfully.*

Click **Save (r)** to save the connection.

> **ℹ️ Note:** The Agentic AI Service and Anomaly Detection Service will be `STOPPED` and will be enabled later in this lab.

After clicking **Save**, you will be brought to the **Success!** page. Click **Go to Databases** to proceed.

<img src="images/Success.png" width="800"/>

> ✅ This completes the Setup and Configuration section.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Getting to Know the Main Interfaces</h2>

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Home Page</h3>

The Db2 Genius Hub home page provides a summary of all databases being monitored, showing alerts, key insights, and the list of database connections.

<img src="images/GH-homepage.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Key Insights Section</h3>

In the upper-middle section, Db2 Genius Hub shows performance metrics for five databases:

- Queries being executed
- Average CPU usage
- Average memory usage
- Peak CPU usage

<img src="images/GH-top5.png" width="600"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Heading Icons</h3>

In the upper-right corner you'll find 4 icon buttons. The **Notification Center (Alerts)** and **Database Assistant** will be explored in more detail later in the lab.

<img src="images/GH-heading-icons.png" width="400"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Exploring the Menus</h3>

<h4 style="padding-left:14px; border-left:4px solid #888780;">Side Menu</h4>

During the labs, you will use the side menu to access all major features. Click the **hamburger menu (☰)** on the top left to expand.

<img src="images/GH-side-menu2.png" width="300"/>

---

<h4 style="padding-left:14px; border-left:4px solid #888780;">Help Menu</h4>

On the lower-left side of the home page, you'll find 4 icons:

<img src="images/GH-help-menu-expanded.png" width="200"/>

<h4 style="padding-left:14px; border-left:4px solid #888780;">About</h4>

1. From the help menu, click **About (a)**.

   <img src="images/GH-about-menu.png" width="200"/>

2. The Db2 Genius Hub information panel opens, showing the release number and build date. Click **Close (a)**.

   <img src="images/GH-about-menu-close.png" width="400"/>

---

<h4 style="padding-left:14px; border-left:4px solid #888780;">APIs</h4>

1. From the help menu, click **APIs (b)**.

   <img src="images/GH-apis-menu.png" width="200"/>

2. The REST APIs window opens. Db2 Genius Hub provides REST APIs for configuration changes, monitoring, and integration. Common use cases include:

   | Use Case | Description |
   |---|---|
   | **Bulk password updates** | When an instance password changes, update all databases under that instance in one API call |
   | **Dynamic blackout windows** | Pause monitoring before a maintenance window and resume it afterward |

3. The REST API window also provides usage examples in: Payload, Curl, Go, Java, Node, and Python.

   <img src="images/GH-apis-window.png" width="800"/>

   > **📖 Reference:** [Db2 Genius Hub API Documentation](https://www.ibm.com/docs/en/dic?topic=working-with-apis)

---

<h4 style="padding-left:14px; border-left:4px solid #888780;">IBM Documentation</h4>

1. From the help menu, click **IBM Documentation (c)**.

   <img src="images/GH-docs-menu.png" width="200"/>

2. The IBM Db2 Genius Hub Knowledge Center opens.

   <img src="images/GH-knowledge-center.png" width="800"/>

---

<h4 style="padding-left:14px; border-left:4px solid #888780;">Community</h4>

1. From the help menu, click **Db2 Community page (d)**.

   <img src="images/GH-community-menu.png" width="200"/>

2. The Db2 Community page opens. The Db2 Community is very active — post questions, browse announcements, and find informative webinars covering several IBM Db2 products.

   <img src="images/GH-community-page.png" width="800"/>

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Database Connections</h2>

From the side menu, go to the Db2 Genius Hub home page **(a)**.

<img src="images/GH-homepage-sidemenu.png" width="300"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Database Tags</h3>

Db2 Genius Hub allows you to tag databases to separate views by group — for example, by department, data center, or criticality. Selecting a tag filters the database list to show only databases assigned to that tag.

> **⏳ Wait** until the `demo_col` database shows a green checkmark before proceeding.

**Create a tag:**

1. Click **+ (a)** next to the "All databases" tab. The **Create tag** window opens.

   <img src="images/GH-create-tag.png" width="800"/>

   > **ℹ️ Note:** You can also change the display order of tags by clicking **Manage database tags**.

2. Enter the tag name: `columnar` **(b)** and click **Add database + (c)**.

   <img src="images/GH-create-tag-name.png" width="800"/>

3. Select the **`demo_col`** database **(d)** and click **Save (e)**.

   <img src="images/GH-add-database-to-tag.png" width="800"/>

4. Click **Save (f)**.

   <img src="images/GH-create-tag-save.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Customize Columns</h3>

The database list shows all monitored databases with a summary of their main metrics. You can add or remove metrics from this view.

1. Click **Customize Columns (a)**.

   <img src="images/GH-customize-columns.png" width="800"/>

2. Scroll down the list, select **Server type and version (b)**, and click **Apply (c)**.

   <img src="images/GH-customize-columns-select.png" width="400"/>

3. The **Server type & version** column is now displayed. Use the up/down arrows on each column header to sort.

   <img src="images/GH-server-type-column.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Add a Database</h3>

Add the other pre-defined database for this lab.

1. Click **Add database connection (a)**.

   <img src="images/GH-add-additional-database-connection.png" width="800"/>

2. Enter the following details:

   <img src="images/GH-add-additional-database-connection-details.png" width="800"/>

   **Connection and database:**

   | Label | Field | Value |
   |---|---|---|
   | **a** | Connection name | `demo_row` |
   | **b** | Host | `localhost` |
   | **c** | Port | `25010` |
   | **d** | Database | `demo_row` |

   **Security and credential:**

   | Label | Field | Value |
   |---|---|---|
   | **e** | Enable monitoring data collection | ☑ Checked |
   | **f** | Username | `db2demo` |
   | **g** | Password | `Db2ghPassw0rd#1` |

   Click **Test connection (h)** → *Connect to demo_row successfully.*

   **Enable Jobs to Run:**

   | Label | Field | Value |
   |---|---|---|
   | **i** | Enable jobs to run | ☑ Checked |
   | **j** | Username | `db2demo` |
   | **k** | Password | `Db2ghPassw0rd#1` |

   Click **Test connection (l)** → *Connect to demo_row successfully.*

   **Enable Personal Credential:**

   | Label | Field | Value |
   |---|---|---|
   | **m** | Enable personal credential | ☑ Checked |
   | **n** | Username | `db2demo` |
   | **o** | Password | `Db2ghPassw0rd#1` |

   Select **Save credentials to repository (q)**.

   Click **Test connection (p)** → *Connect to demo_row successfully.*

   Click **Save (r)** to save the connection.

3. Reload the browser to display the newly added database.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Add a Tag to the New Database</h3>

1. Wait until `demo_row` shows a green checkmark. Click **+ (a)** next to the "columnar" tab.

   <img src="images/GH-create-second-tag.png" width="800"/>

2. Enter the tag name: `row` **(b)** and click **Add database + (c)**.

   <img src="images/GH-create-second-tag-name.png" width="800"/>

3. Select the **`demo_row`** database **(d)** and click **Save (e)**.

   <img src="images/GH-add-second-database-to-tag.png" width="800"/>

4. Click **Save (f)**.

   <img src="images/GH-create-second-tag-save.png" width="800"/>

The **All databases** section now shows two databases: `demo_col` and `demo_row`.

<img src="images/GH-databases-and-tags.png" width="800"/>

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Monitor Dashboard</h2>

From the side menu, click **Monitor (a)**.

<img src="images/GH-monitor-sidemenu.png" width="200"/>

The Monitor dashboard shows detailed information for a specific database. Use the drop-down in the upper-right to switch between databases.

<img src="images/GH-monitor-dashboard.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Filters</h3>

The filter bar shows **Real Time** data by default.

1. Click **Filter (a)**.

   <img src="images/GH-filter-button.png" width="600"/>

2. The Filter window opens. You can filter by user or application for a selected time range.

3. Click **Cancel (b)** for now.

   <img src="images/GH-filter-cancel.png" width="400"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Details Tabs and Manage Tabs</h3>

Each Details tab is populated with data from the selected time period.

1. There are **37 different tab options** available. Click **Manage tabs (a)** to see all options.

   <img src="images/GH-manage-tabs.png" width="800"/>

2. The most common metrics are already selected by default. Select additional metrics as needed.

3. Click **Save (b)** if you made changes, otherwise click **Cancel (a)**.

   <img src="images/GH-manage-tabs-window.png" width="600"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Refresh and Pause</h3>

The screen auto-refreshes every 2 minutes. Use these buttons to control the display:

| Button | Action |
|---|---|
| **Refresh** | Refreshes the charts immediately |
| **Pause** | Pauses the auto-refresh |

<img src="images/GH-refresh-pause.png" width="800"/>

> **ℹ️ Note:** Even when paused, Db2 Genius Hub continues capturing data in the background according to the monitoring profile collection interval.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Charts</h3>

The upper section shows 3 default charts: **Time spent**, **Resource utilization**, and **Throughput**.

1. Click **Sync charts (a)** then **Manage charts (b)**.

   <img src="images/GH-sync-manage-charts.png" width="800"/>

   Syncing charts ensures all charts display data for the same time period.

2. Click **Cancel (c)**.

   <img src="images/GH-manage-charts-window.png" width="400"/>

3. To see additional charts, click **View more charts (a)** in the upper-right.

   <img src="images/GH-view-more-charts.png" width="800"/>

4. Additional charts are displayed.

   <img src="images/GH-additional-charts.png" width="800"/>

   > **ℹ️ Note:** The **Response time** and **Responsiveness** charts require the Statistics Event Monitor to be enabled.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Set Up Your AI Configuration</h2>

To enable the Db2 Agentic AI service in Genius Hub, you need to create an organization and API key from [db2.ibm.com](https://db2.ibm.com), then configure Genius Hub to use it.

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Part 1 — Create an Organization and Get Your API Key</h3>

1. Open a new browser tab and navigate to [db2.ibm.com](https://db2.ibm.com). Log in with your IBMid.

2. In the top-right corner, click the organization name *(a)* to open the menu. Click **Create organization +** *(b)*.

   <img src="images/db2-create-organization.png" width="800"/>

3. Enter an **Organization name** *(c)* and click **Create** *(d)*.

   <img src="images/db2-organization-name.png" width="800"/>

4. Click **Display API key**.

   <img src="images/db2-display-api-key.png" width="800"/>

5. The **API key successfully created** dialog opens. Click **Copy** to copy the key to your clipboard, then click **Close**.

   <img src="images/db2-api-key-copy.png" width="600"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Part 2 — Configure AI in Genius Hub</h3>

6. Return to the **Genius Hub** browser tab. From the side menu select **Administration → Console**.

   <img src="images/GH-administration-menu-console-ai.png" width="200"/>

7. In the **AI Assistant** section, click **AI configuration** *(e)*.

   <img src="images/GH-ai-configuration-menu.png" width="800"/>

8. On the **AI configuration** page, enable **Agentic AI** by clicking the slider *(g)* from **Disabled** to **Enabled**.

   <img src="images/GH-ai-configuration-page.png" width="800"/>

   The model type is pre-selected for this lab:

   | Label | Field | Value |
   |---|---|---|
   | **h** | Model type | IBM provided AI stack |
   | **i** | Cloud service | AWS Bedrock |
   | **j** | Model deployment region | US East 1 |

   > **ℹ️ Note:** The model is pre-selected — no changes are needed to the model type or cloud service settings.

9. Click **Sign in with IBMid (k)**. You should already be logged in from Part 1.

10. Paste the API key into the **API key field (l)** and click **Validate (m)**.

11. In the **Organization field (n)**, select the organization you just created.

12. Click **Save (o)**.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Part 3 — Verify the Agentic AI Service is Running</h3>

13. SSH into the VM as `db2ghadm`. See [Section 1 — Student SSH Access](01-setup.md#step-1--student-ssh-access).

14. Run `ghstatus`:

    ```bash
    ghstatus
    ```

    If the Agentic AI Service shows as `STOPPED`, start the Anomaly service:

    ```bash
    cd /home/db2ghadm/ibm-db2GeniusHub/addons/anomaly-detection
    ./start.sh
    ```

15. Confirm all services are running:

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
    Agentic AI Service        RUNNING         PID: 37750   | Port(s): 11108
    Anomaly Detection Service RUNNING         PID: 38002   | Port(s): 11109
    DRS Agent Service         RUNNING         PID: 27023   | Port(s): 11096
    Job Scheduler Service     RUNNING         PID: 27090   | Port(s): 11107
    Redis Service             RUNNING         PID: 35508   | Port(s): 6379
    ---------------------------------------------------------------------------------

    Overall Status: [OK] All components are running
    ```

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Modify the Monitoring Profile Collection Interval</h2>

Change the collection interval from 5 minutes to 1 minute for faster data capture during the lab.

1. From the side menu, select **Administration (a) → Console (b)**.

   <img src="images/GH-admin-sidemenu.png" width="200"/>

2. Click **Monitoring profiles (c)**.

   <img src="images/GH-event-monitoring-profiles.png" width="800"/>

3. Click the **default (d)** profile.

   <img src="images/GH-monitoring-profiles-default.png" width="800"/>

4. Click the **pencil (e)** icon to edit the profile.

   <img src="images/GH-monitoring-profiles-default-edit.png" width="800"/>

5. Change the **Collection interval** *(f)* to **1 minute**.

   <img src="images/GH-monitoring-profiles-default-edit-interval.png" width="800"/>

   > **ℹ️ Note:** The minimum value is 1 minute. This is done here to capture data as quickly as possible for demonstration purposes. In a production environment, you would collect data less frequently to reduce overhead.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Turning on Event Monitors</h2>

Some Db2 Genius Hub features require event monitors to capture performance data:

| Feature | Required Event Monitor |
|---|---|
| Response time / Responsiveness charts | Statistics event monitor |
| Individual Executions tab / Impact Analysis | Activity event monitor |
| Locking event monitor tab | Locking event monitor |
| Utilities event monitor tab | Utility event monitor |
| Config event monitor tab | Config event monitor |

1. From the side menu, select **Administration (a) → Console (b)**.

   <img src="images/GH-admin-sidemenu.png" width="200"/>

2. Under **Monitoring**, click **Event monitoring (c)**.

   <img src="images/GH-event-monitoring-menu.png" width="800"/>

3. Expand **`demo_col`** *(d)* and click the **pencil** *(e)* icon.

   <img src="images/GH-event-monitoring-pencil.png" width="800"/>

   > **ℹ️ Note:** Db2 Genius Hub requires a tablespace to create event monitor tables. A dedicated tablespace `TS4MONITOR` has already been created for this lab.

   <img src="images/GH-predefined-tablespace.png" width="400"/>

   There are 3 ways to create the event monitor tablespace (informational — do not create one for this lab):

   | Method | Description |
   |---|---|
   | **Web UI** | Use Db2 Genius Hub to create the tablespace automatically |
   | **REST API** | [Defining a tablespace by using REST API](https://www.ibm.com/docs/en/db2-genius-hub/1.1.x?topic=apis-defining-table-space-by-using-rest-api) |
   | **Manual** | [Table space prerequisites for event monitoring](https://www.ibm.com/docs/en/db2-genius-hub/1.1.x?topic=profile-table-space-other-prerequisites-event-monitoring) |

4. From the **Activity (f)** tab, enable. The options on the right side become available.

   <img src="images/GH-activity-tab.png" width="800"/>

   | Setting | Default | Description |
   |---|---|---|
   | Collection interval | 1 minute | How often Genius Hub reads and processes event monitor data |
   | Data Retention | 28 days | How long data is kept in repository tables |
   | Use Administrative Task Scheduler | Optional | Enables automated watchdog process (strongly recommended) |

   ```
   db2set DB2_ATS_ENABLE=YES
   ```

   > **📖 Reference:** [Administrative Task Scheduler (ATS) in event monitoring](https://www.ibm.com/docs/en/db2-genius-hub/1.1.x?topic=profile-administrative-task-scheduler-ats-in-event-monitoring)

5. Select the **Locking (g)** tab → change status to **Enabled** → set Collection interval to **1 minute**.

   <img src="images/GH-locking-tab.png" width="800"/>

6. Select the **Utility (h)** tab → change status to **Enabled** → set Collection interval to **1 minute**.

   <img src="images/GH-utility-tab.png" width="800"/>

   Click the down caret to expand **Utility type** and view all collected utilities (leave all selected).

   <img src="images/GH-utility-types.png" width="800"/>

7. Select the **Statistics (i)** tab → ensure Status is **Enabled** → set Collection interval to **1 minute**.

   <img src="images/GH-stats-tab.png" width="800"/>

8. Select the **Config (j)** tab → change status to **Enabled** → set Collection interval to **1 minute**.

   <img src="images/GH-config-tab.png" width="800"/>

   When config event monitoring is enabled, Genius Hub creates the following in the monitored database:

   - Event monitor: `RTMON_EVMON_CONFIG`
   - Tables: `IBM_RTMON.CHG_SUMMARY_HISTORY`, `IBM_RTMON.DB_DBM_HISTORY`
   - Stored procedure: `IBM_RTMON.RTMON_EVMON_CONFIG_WATCHDOG`
   - Db2 ATS task: **Rtmon Evmon Config Watchdog**

9. Select the **Config types (k)** down caret to view which Db2 configuration parameters to track (leave all selected).

   <img src="images/GH-config-types.png" width="800"/>

10. Select the **DDL (l)** tab → ensure Status is **Disabled**.

    <img src="images/GH-ddl-tab.png" width="800"/>

11. Select the **Regvar (m)** tab → change status to **Enabled** → set Collection interval to **1 minute**.

    <img src="images/GH-regvar-tab.png" width="800"/>

12. Click **Save (n)** in the upper-right.

    <img src="images/GH-event-monitor-save.png" width="800"/>

    You will see a confirmation message at the top of the screen:

    <img src="images/GH-event-monitor-message.png" width="800"/>

13. After a few minutes, the event monitors should appear in the screen. Refresh the page as needed.

    <img src="images/GH-event-monitors-created.png" width="800"/>

14. From the side menu, select **Monitor (a)**.

    <img src="images/GH-monitor-sidemenu.png" width="200"/>

15. Click **View more charts (b)**. The **Contention**, **Response time**, and **Responsiveness** graphs are now visible.

    <img src="images/GH-response-time-charts.png" width="800"/>

    > **ℹ️ Note:** Charts won't show meaningful data yet — no workload is currently running. In the Agentic AI Simulator section, workload will run so you can explore the charts with real data.

---

> **📖 Reference: How Event Monitors Work in Db2 Genius Hub**
>
> The Administrative Task Scheduler (ATS) is not required, but is strongly recommended.
>
> **Without ATS:** If Genius Hub loses its connection to a monitored database, the event monitor cycle is broken and event monitor tables will continue to grow unmanaged.
>
> **With ATS:** A watchdog process automatically detects and drops lost/orphaned event monitors.
>
> **The event monitor cycle:**
>
> 1. Genius Hub issues: `CREATE EVENT MONITOR ... WRITE TO TABLES`
> 2. Db2 creates the event monitor and its associated tables.
> 3. Db2 inserts performance data into the event monitor tables.
> 4. Genius Hub reads the data, populates the repository tables, then flushes the event monitor.
> 5. Repeat from step 3.
>
> If the connection is lost, Db2 continues inserting data but the flush step never runs — tables grow until the tablespace fills. ATS prevents this by automatically cleaning up orphaned monitors.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Configure Tabs for Utilities Monitoring</h2>

Before starting the data load, add the **Utilities** and **Utilities event monitor** tabs to the Monitor dashboard so you can observe load activity in real time.

1. From the Monitor dashboard, click the **edit tabs** icon on the right side of the tab bar.

   <img src="images/GH-edit-tabs.png" width="800"/>

2. The **Manage Tabs** window opens. Under **Applications**, select **Utilities** and **Utilities event monitor (a)**.

   <img src="images/GH-edit-tabs-utilites.png" width="800"/>

3. Click **Save (b)**.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Next Steps</h2>

This completes the Basics of Db2 Genius Hub.

**[→ Proceed to Section 3: SQL Workbench](03-workbench.md)**

---
