## 2. The Basics

In the previous section, you connected to your dedicated virtual machine and started the Db2 Genius Hub services. This section shifts focus to the Genius Hub UI itself — learning your way around the interface and understanding the key pages and features you'll use throughout the rest of the lab.

See [Section 1.3 Default Credentials](01_setup.md#13-default-credentials) for login details.

---

### 2.1 Genius Hub Login

Open a browser (Google Chrome, Mozilla Firefox, Microsoft Edge, Safari) and type the Db2 Genius Hub URL provided by your instructor.

See [Section 1.2 Accessing the Lab Environment](01_setup.md#12-accessing-the-lab-environment) for the URL.

<img src="images/GH-login.png" width="600"/>

Enter the **Username (a)** and **Password (b)**, click **Accept all** (c), then click **Login (d)**.

| Username | Password |
|---|---|
| `admin` *(a)* | `Db2ghPassw0rd#1` *(b)* |

> **Caution:** Be careful when typing the password. After 3 incorrect attempts, the username will be locked and all users running this lab will be locked out.

---

### 2.2 Configure Repository (First Login Setup)

At first login, you must configure the repository database to initialize the IBM Db2 Genius Hub environment.

**Step 1: Configure repository**

After logging in, you will be automatically taken to the **Configure repository** page.

<img src="images/Repo-welcome.png" width="800"/>

In the **Connection and database** section, enter the following values:

| Field | Value |
|---|---|
| Host | `localhost` *(a)* |
| Port | `25011` *(b)* |
| Database | `REPODB` *(c)* |
| Repository schema | `IBMCONSOLE` (default) |

Leave the **JDBC URL attribute** field empty (optional).

In the **Security and credential** section:

| Field | Value |
|---|---|
| Use SSL | ☐ Unchecked |
| Security type | Clear text password |
| Username | `db2ghadm` *(d)* |
| Password | `Db2ghPassw0rd#1` *(e)* |

Click **Test connection** *(f)* to validate. When successful, the following message is displayed:

> Connect to repository successfully.

> **Note:** This process may take a few minutes as all `REPODB` database objects are being created.

Click **Next** *(g)* to continue.

---

**Step 2: Set statistics event monitor opt-in**

<img src="images/stats-monitor-opt-in.png" width="800"/>

Enable the **Set statistics event monitor opt-in** option by switching the toggle to **On**.

This feature automatically enables statistics event monitoring on database connections and is required for the **Responsiveness** widget on the Monitor > Summary page to display data.

> **Note:** Enabling this option creates additional Db2 objects and may incur additional resource usage.

Click **Next** to continue.

---

**Step 3: Connection and database**

Configure the connection parameters to establish a connection to your Db2 database.

<img src="images/Connection-and-database.png" width="800"/>

| Label | Field | Value |
|---|---|---|
| **a** | Connection name | `demo_col` |
| **b** | Host | `localhost` |
| **c** | Port | `25010` |
| **d** | Database | `demo_col` |

**Security and Credential**

| Label | Field | Value |
|---|---|---|
| **e** | Enable monitoring data collection | ☑ Checked |
| **f** | Username | `db2demo` |
| **g** | Password | `Db2ghPassw0rd#1` |

Click **Test connection (h)** to verify. You should see: *Connect to demo_col successfully.*

**Enable Jobs to Run**

| Label | Field | Value |
|---|---|---|
| **i** | Enable jobs to run | ☑ Checked |
| **j** | Username | `db2demo` |
| **k** | Password | `Db2ghPassw0rd#1` |

Click **Test connection (l)** to verify. You should see: *Connect to demo_col successfully.*

**Enable Personal Credential**

| Label | Field | Value |
|---|---|---|
| **m** | Enable personal credential | ☑ Checked |
| **n** | Username | `db2demo` |
| **o** | Password | `Db2ghPassw0rd#1` |

Select **Save credentials to repository (q)**.

Click **Test connection (p)** to verify. You should see: *Connect to demo_col successfully.*

Click **Save (r)** to save the connection.

> The Agentic AI Service and Anomaly Detection Service will be STOPPED and will be enable later in this lab.

---

After clicking **Save**, you will be brought to the **Success!** page confirming your Db2 Genius Hub has been successfully configured. Click **Go to Databases** to proceed.

<img src="images/Success.png" width="800"/>

> This completes the Setup and Configuration section.

---

### 2.3 Getting to Know the Main Interfaces of Db2 Genius Hub

#### 2.3.1 Db2 Genius Hub Home Page

The Db2 Genius Hub home page has a summary of all databases being monitored, showing alerts, top 5 databases, and the list of database connections being monitored by Db2 Genius Hub.

<img src="images/GH-homepage.png" width="800"/>

---

#### 2.3.2 Key Insights Section

In the upper-middle section of the home page, Db2 Genius Hub shows key Insights performance metrics for five databases:

- Queries being executed
- Average CPU usage
- Average memory usage
- Peak CPU usage

<img src="images/GH-top5.png" width="600"/>

---

#### 2.3.3 Heading Icons

In the upper-right corner of the home page you also have 4 buttons with icons. The **Notification Center (Alerts)** and **Database Assistant** will be explored in more detail later in the lab.

<img src="images/GH-heading-icons.png" width="400"/>

---

#### 2.3.4 Exploring the Menus

##### 2.3.4.1 Side Menu

During the labs, we will be referencing the side menu on the upper-left side of the screen to access menu options. Click **hamburger menu (☰)** on the top left to expand the menu.

<img src="images/GH-side-menu2.png" width="300"/>

---

##### 2.3.4.2 Help Menu

On the lower-left side of the home page, you can find 4 icons.

<img src="images/GH-help-menu-expanded.png" width="200"/>

---

###### About

1. From the help menu, click **About (a)**.

   <img src="images/GH-about-menu.png" width="200"/>

2. The Db2 Genius Hub information panel is displayed, showing the release number and the build date. Click **Close (a)**.

   <img src="images/GH-about-menu-close.png" width="400"/>

---

##### 2.3.4.3 APIs

1. From the help menu, click **APIs (b)**.

   <img src="images/GH-apis-menu.png" width="200"/>

2. The REST APIs window opens. Db2 Genius Hub provides several REST APIs that can be used to make configuration changes, such as updating monitored database information, setting up blackout events, and retrieving performance metrics.

   Common use cases for the REST APIs include:

   - **Bulk password updates** — When an instance password changes, a REST API can update the password for all databases under that instance in Db2 Genius Hub at once.
   - **Dynamic blackout windows** — When a maintenance window for backups has a variable start time, the blackout API can be called before the backup begins to pause monitoring, and again after the backup completes to resume it.

3. The REST API window also provides usage examples in multiple programming languages: Payload, Curl, Go, Java, Node, and Python.

   <img src="images/GH-apis-window.png" width="800"/>

   For additional information on Db2 Genius Hub APIs and usage examples, refer to the Db2 Genius Hub documentation:
   [https://www.ibm.com/docs/en/dic?topic=working-apis](https://www.ibm.com/docs/en/dic?topic=working-apis)

---

##### 2.3.4.4 IBM Documentation

1. From the help menu, click **IBM Documentation (c)**.

   <img src="images/GH-docs-menu.png" width="200"/>

2. The IBM Db2 Genius Hub Knowledge Center opens.

   <img src="images/GH-knowledge-center.png" width="800"/>

---

##### 2.3.4.5 Community

1. From the help menu, click **Db2 Community page (d)**.

   <img src="images/GH-community-menu.png" width="200"/>

2. The Db2 Community page opens. The Db2 Community is very active — you can post any Db2-related questions and the community is always ready to help.

   You can also find announcements and informative webinars covering several IBM Db2 products.

   <img src="images/GH-community-page.png" width="800"/>

---

### 2.4 Database Connections

1. From the side menu, go to the Db2 Genius Hub home page **(a)**.

   <img src="images/GH-homepage-sidemenu.png" width="300"/>

---

#### 2.4.1 Database Tags

Db2 Genius Hub allows you to tag databases to separate views by group — for example, databases used by the HR department, databases belonging to a specific data center, or your most critical databases. By selecting a tag, Db2 Genius Hub filters the database connection list to show only databases assigned to that tag.

> **Note:** Before proceeding, wait until the `demo_col` database shows a green checkmark indicating the connection is available.

1. To create a tag, click **+ (a)** next to the "All databases" tab. The **Create tag** window opens.

   <img src="images/GH-create-tag.png" width="800"/>

   > **Note:** You can also change the display order of tags by clicking **Manage database tags**.

2. Enter the tag name: `columnar` **(b)** and click **Add database + (c)**.

   <img src="images/GH-create-tag-name.png" width="800"/>

3. Select the **`demo_col`** database **(d)** and click **Save (e)**.

   <img src="images/GH-add-database-to-tag.png" width="800"/>

4. Click **Save (f)**.

   <img src="images/GH-create-tag-save.png" width="800"/>

---

#### 2.4.2 Customize Columns

The database list shows all monitored databases with a summary of their main metrics. You can add or remove metrics from this view.

1. Click **Customize Columns (a)**.

   <img src="images/GH-customize-columns.png" width="800"/>

2. Scroll down the list, select **Server type and version (b)**, and click **Apply (c)**.

   <img src="images/GH-customize-columns-select.png" width="400"/>

3. The **Server type & version** column is now displayed for each database connection. Use the up and down arrows on the right side of each column header to sort ascending or descending.

   <img src="images/GH-server-type-column.png" width="800"/>

---

#### 2.4.3 Add a Database

Add the other pre-defined database for this lab.

1. Click **Add database connection (a)**.

   <img src="images/GH-add-additional-database-connection.png" width="800"/>

2. Enter the details:

   <img src="images/GH-add-additional-database-connection-details.png" width="800"/>

   **Connection and database**

   | Label | Field | Value |
   |---|---|---|
   | **a** | Connection name | `demo_row` |
   | **b** | Host | `localhost` |
   | **c** | Port | `25010` |
   | **d** | Database | `demo_row` |

   **Security and Credential**

   | Label | Field | Value |
   |---|---|---|
   | **e** | Enable monitoring data collection | ☑ Checked |
   | **f** | Username | `db2demo` |
   | **g** | Password | `Db2ghPassw0rd#1` |

   Click **Test connection (h)** to verify. You should see: *Connect to demo_row successfully.*

   **Enable Jobs to Run**

   | Label | Field | Value |
   |---|---|---|
   | **i** | Enable jobs to run | ☑ Checked |
   | **j** | Username | `db2demo` |
   | **k** | Password | `Db2ghPassw0rd#1` |

   Click **Test connection (l)** to verify. You should see: *Connect to demo_row successfully.*

   **Enable Personal Credential**

   | Label | Field | Value |
   |---|---|---|
   | **m** | Enable personal credential | ☑ Checked |
   | **n** | Username | `db2demo` |
   | **o** | Password | `Db2ghPassw0rd#1` |

   Select **Save credentials to repository (q)**.

   Click **Test connection (p)** to verify. You should see: *Connect to demo_row successfully.*

   Click **Save (r)** to save the connection.

3. Reload the browser to show the newly added database.

---

#### 2.4.4 Add a Tag to the New Database

1. Wait until the `demo_row` database shows a green checkmark, indicating it is available. Click **+ (a)** next to the "columnar" tab. The **Create tag** window opens.

   <img src="images/GH-create-second-tag.png" width="800"/>

   > **Note:** You can also change the display order of tags by clicking **Manage database tags**.

2. Enter the tag name: `row` **(b)** and click **Add database + (c)**.

   <img src="images/GH-create-second-tag-name.png" width="800"/>

3. Select the **`demo_row`** database **(d)** and click **Save (e)**.

   <img src="images/GH-add-second-database-to-tag.png" width="800"/>

4. Click **Save (f)**.

   <img src="images/GH-create-second-tag-save.png" width="800"/>

   The **All databases** section now shows two databases: `demo_col` and `demo_row`.

   <img src="images/GH-databases-and-tags.png" width="800"/>

---

### 2.5 Monitor Dashboard

1. From the side menu, click **Monitor (a)**.

   <img src="images/GH-monitor-sidemenu.png" width="200"/>

The Monitor dashboard is where you see more detail for a specific database. Database information is shown in the upper-left of the screen, and a drop-down list in the upper-right lets you switch between databases.

<img src="images/GH-monitor-dashboard.png" width="800"/>

---

#### 2.5.1 Filters

The filter bar shows **Real Time** data by default.

1. Click **Filter (a)**.

   <img src="images/GH-filter-button.png" width="600"/>

2. The Filter window opens. You can filter by a specific user or by an application for a selected time range.

3. Click **Cancel (b)** for now.

   <img src="images/GH-filter-cancel.png" width="400"/>

---

#### 2.5.2 Details Tabs and Manage Tabs

Each Details tab is populated with data from the time period selected in the filter.

1. There are 37 different tab options available. To see all options, click **Manage tabs (a)**.

   <img src="images/GH-manage-tabs.png" width="800"/>

2. The **Manage Tabs** window opens. The most common metrics are already selected by default. You can select additional metrics as needed.

3. If you selected additional metrics, click **Save (b)**, otherwise click **Cancel (a)**.

   <img src="images/GH-manage-tabs-window.png" width="600"/>

---

#### 2.5.3 Refresh and Pause

The screen auto-refreshes every 2 minutes. Use the refresh and pause buttons to control the display:

| Button | Action |
|---|---|
| **Refresh** | Refreshes the charts immediately |
| **Pause** | Pauses the auto-refresh |

<img src="images/GH-refresh-pause.png" width="800"/>

> **Note:** Even when the display is paused, Db2 Genius Hub continues capturing data in the background according to the collection interval configured in the monitoring profile.

---

#### 2.5.4 Charts

The upper section of the page shows 3 default charts:

- Time spent
- Resource utilization
- Throughput

1. Click **Sync charts (a)** and then click **Manage charts (b)**.

   <img src="images/GH-sync-manage-charts.png" width="800"/>

   Syncing charts ensures all charts display data for the same time period. For example, if you change the filter to 2:00 AM, all charts will update to reflect data at that time.

2. The **Manage charts** window opens. All available charts are selected by default.

3. Click **Cancel (c)**.

   <img src="images/GH-manage-charts-window.png" width="400"/>

4. To see additional charts, click **View more charts (a)** in the upper-right of the screen.

   <img src="images/GH-view-more-charts.png" width="800"/>

5. Additional charts are displayed.

   <img src="images/GH-additional-charts.png" width="800"/>

   > **Note:** The **Response time** and **Responsiveness** charts require the Statistics Event Monitor to be enabled so Db2 Genius Hub can capture and display the data.

---

### 2.6 Set Up Your AI Configuration and Select a Model

To enable the Db2 Agentic AI service in Genius Hub, you first need to create an organization and obtain an API key from [db2.ibm.com](https://db2.ibm.com), then configure Genius Hub to use it.

**Part 1: Create an Organization and Get Your API Key**

1. Open a new browser tab and navigate to [db2.ibm.com](https://db2.ibm.com). Log in with your IBMid.

2. In the top-right corner, click the organization name *(a)* to open the organization menu. Click **Create organization +** *(b)*.

   <img src="images/db2-create-organization.png" width="800"/>

3. Enter an **Organization name** *(c)* and click **Create** *(d)*.

   <img src="images/db2-organization-name.png" width="800"/>

4. Click **Display API key**.

   <img src="images/db2-display-api-key.png" width="800"/>

5. The **API key successfully created** dialog opens, showing your API key and its expiry date. Click **Copy** to copy the key to your clipboard, then click **Close**.

   <img src="images/db2-api-key-copy.png" width="600"/>

---

**Part 2: Configure AI in Genius Hub**

6. Return to the **Genius Hub** browser tab. From the side menu select **Administration**, then click **Console**.

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

   > **Note:** The model is selected for you — no changes are needed to the model type or cloud service settings.

9. Click **Sign in with IBMid (k)**. You should already be logged in from Part 1.

10. Paste the API key into the **API key field (l)** and click **Validate (m)**.

11. In the **Organization field (n)**, select the organization you just created from the drop-down list.

12. Click **Save (o)**.

    **Verify the Agentic AI Service is running**

13. SSH into the VM as `db2ghadm`. See [Section 1.4.1 Student SSH Access](01_setup.md#141-student-ssh-access) for instructions.

14. Run `ghstatus` to confirm the Genius Services are running:

    ```bash
    ghstatus
    ```

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
      Redis Service             RUNNING         PID: 35508   | Port(s): 6379
      ---------------------------------------------------------------------------------

      Overall Status: [WARNING] Liberty is running but 2 addon(s) are not running
    ```

    > **Note:** If the Agentic AI Service shows as `STOPPED`, contact your instructor before proceeding.

15. Start the Anomaly service:

   ```bash
   cd /home/db2ghadm/ibm-db2GeniusHub/addons/anomaly-detection
   ./start.sh
   ```
16. Run `ghstatus` to confirm the Agentic AI Service is running:

    ```bash
    ghstatus
    ```

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

---

### 2.7 Modify the monitoring profile collection interval from 5 minutes to 1 minute.

1. From the side menu on the left side, select **Administration** *(a)* and **Console** *(b)*.

   <img src="images/GH-admin-sidemenu.png" width="200"/>

2. Click **Monitoring profiles (c)**

   <img src="images/GH-event-monitoring-profiles.png" width="800"/>

3. Click the **default (d)** profile.

   <img src="images/GH-monitoring-profiles-default.png" width="800"/>

4. Click the **pencil (e)** icon to edit the profile.

   <img src="images/GH-monitoring-profiles-default-edit.png" width="800"/>

5. Change the **Collection interval** *(f)* to 1 minute.

   <img src="images/GH-monitoring-profiles-default-edit-interval.png" width="800"/>

   > **Note:** The minimum value is 1 minute and done here to capture data as quickly as possible.  This is not like a production environment where you would want to capture data less frequently to reduce overhead.
   

### 2.8 Turning on Event Monitors

Some features in Db2 Genius Hub require event monitors to be able to capture performance data, for example:

- Response time and Responsiveness charts require statistics event monitor
- Individual Executions tab and Impact Analysis feature require activity event monitor
- Locking event monitor tab requires locking event monitor
- Utilities event monitor tab requires utility event monitor
- Config event monitor tab requires config event monitor

1. From the side menu on the left side, select **Administration** *(a)* and **Console** *(b)*.

   <img src="images/GH-admin-sidemenu.png" width="200"/>

2. From the Administration menu, under **Monitoring**, click **Event monitoring (c)**.

   <img src="images/GH-event-monitoring-menu.png" width="800"/>

   The **Event monitoring profile** window opens.

3. Expand **`demo_col`** *(d)* and click the **pencil** *(e)* icon.

   <img src="images/GH-event-monitoring-pencil.png" width="800"/>

   To setup the event monitors for the monitored database, Db2 Genius Hub requires to have a table space to create the Db2 event monitor tables. We recommend having a separate table space dedicated for Db2 Genius Hub event monitors only. The same table space definition will be used for all event monitors from Db2 Genius Hub. The table space `TS4MONITOR` was defined already in this lab.

   <img src="images/GH-predefined-tablespace.png" width="400"/>

   There are 3 ways to create the event monitor table space (informational only - do not create a tablespace for this lab):

   a) You can use Db2 Genius Hub to create the table space automatically using the Web UI  
   b) Create the table space using the REST API: [Defining a table space by using REST API](https://www.ibm.com/docs/en/db2-genius-hub/1.1.x?topic=apis-defining-table-space-by-using-rest-api)  
   c) Create the table space manually by following: [Table space and other prerequisites for event monitoring](https://www.ibm.com/docs/en/db2-genius-hub/1.1.x?topic=profile-table-space-other-prerequisites-event-monitoring)  

4. From the **Activity** *(f)* tab, enable.

   <img src="images/GH-activity-tab.png" width="800"/>

   The options on the right side are enabled now. The **Collection interval (minutes) (a)** default is 1 minute, meaning the Db2 Genius Hub server will select the event monitor data from the event monitor tables every 1 minute, save the data into the repository tables, and delete the old data from the event monitors to start collecting the new data for the next interval.

   The **Data Retention (days) (b)** default is 28 days, meaning the Db2 Genius Hub server will delete the data which is older than 28 days from the repository tables.

   The **Use Administrative Task Scheduler (c)** enables the Db2 database to automate the execution of tasks. The administrative task scheduler is disabled by default. The Administrative Task Scheduler (ATS) is enabled at the instance level using the following registry variable (this was done for you).

   ```
   db2set DB2_ATS_ENABLE=YES
   ```

   For more details on [Administrative Task Scheduler (ATS) in event monitoring](https://www.ibm.com/docs/en/db2-genius-hub/1.1.x?topic=profile-administrative-task-scheduler-ats-in-event-monitoring)


5. Select the **Locking tab** *(g)* and change the status from **Disabled** to **Enabled**. Change **Collection interval (minutes)** to 1 minute and leave all other settings as-is.

   <img src="images/GH-locking-tab.png" width="800"/>

6. Select the **Utility tab** *(h)* and change the status from **Disabled** to **Enabled**. Change **Collection interval (minutes)** to 1 minute and leave all other settings as-is.

   <img src="images/GH-utility-tab.png" width="800"/>

   Click the down caret to expand the **Utility type** to view all utilities collected, leave all selected.

   <img src="images/GH-utility-types.png" width="800"/>

7. Select the **Statistics tab (i)** to ensure the Status is **Enabled**. Change **Collection interval (minutes)** to 1 minute and leave all other settings as-is.

   <img src="images/GH-stats-tab.png" width="800"/>

8. Select the **Config tab (j)** and change the status from **Disabled** to **Enabled**.  Change **Collection interval (minutes)** to 1 minute and leave all other settings as-is.

   <img src="images/GH-config-tab.png" width="800"/>

   If the config event monitoring is enabled, the IBM Db2 Genius Hub will create the following items in the monitored database:
   - An config event monitor named RTMON_EVMON_CONFIG
   - The following event tables:
     - IBM_RTMON.CHG_SUMMARY_HISTORY
     - IBM_RTMON.DB_DBM_HISTORY
   - A stored procedure IBM_RTMON.RTMON_EVMON_CONFIG_WATCHDOG
   - A Db2 ATS task named **Rtmon Evmon Config Watchdog**

   This will keep track of Db2 configuration changes.

9. Select down caret **Config types (k)** to view which Db2 configuration parameters to track. Leave the configuration types all selected.

   <img src="images/GH-config-types.png" width="800"/>

10. Select the **DDL tab (l)** to ensure the Status is **Disabled**.

    <img src="images/GH-ddl-tab.png" width="800"/>

11. Select the **Regvar tab (m)** and change the status from **Disabled** to **Enabled**. Change **Collection interval (minutes)** to 1 minute and leave all other settings as-is.

    <img src="images/GH-regvar-tab.png" width="800"/>

    For additional information on what Db2 Genius Hub will be executing during this process, please refer to the Db2 Genius Hub manual at:
    [https://www.ibm.com/docs/en/db2-genius-hub/1.1.0?topic=profile-administrative-task-scheduler-ats-in-event-monitoring](https://www.ibm.com/docs/en/db2-genius-hub/1.1.0?topic=profile-administrative-task-scheduler-ats-in-event-monitoring)

12. Once the configuration is done, from the upper-right side of the screen, click **Save (n)**.

    <img src="images/GH-event-monitor-save.png" width="800"/>

    You will see the following message at the top of the screen:

    <img src="images/GH-event-monitor-message.png" width="800"/>

    > **Note:** As the collection interval is set to every 1 minute, the information related to the new event monitors can take up to 1 minute to be shown in the screen.

13. Once the event monitors are created successfully, you should be able to see event monitors **(p)** in the following screen:

    <img src="images/GH-event-monitors-created.png" width="800"/>

    > **Note:** The event monitors take a few minutes to display, refresh the page until you see the event monitors above.

14. From the side menu on the left side of the screen, select **Monitor (a)**.

    <img src="images/GH-monitor-sidemenu.png" width="200"/>

15. Click **View more charts (b)** on the right side of the screen. The **Contention**, **Response time** and **Responsiveness** graphs are now visible.  Notice how the interval has changed to 1 minute, again this might not be how you want the data collection in a production environment, done here for demonstration purposes.

    <img src="images/GH-response-time-charts.png" width="800"/>

    > **Note:** The charts will not show meaningful data yet as no workload is currently running against Db2. In the Agentic AI Simulator section, workload will run in the background so you can explore the charts with real data.

---

> **Reference: How Event Monitors Work in Db2 Genius Hub**
>
> The Administrative Task Scheduler (ATS) is not a requirement, but it is strongly recommended.
>
> Without ATS, if Db2 Genius Hub loses its connection to a monitored database, the event monitor cycle is broken and the event monitor tables will continue to grow unmanaged. ATS solves this by running a watchdog process that automatically detects and drops lost/orphaned event monitors.
>
> For additional information, refer to the [Db2 Genius Hub Documentation](https://www.ibm.com/docs/en/db2-genius-hub/1.1.0?topic=profile-administrative-task-scheduler-ats-in-event-monitoring).
>
> **How the event monitor cycle works:**
>
> 1. Start monitoring a database with event monitors enabled.
> 2. Db2 Genius Hub issues the Db2 command:
>
>    ```sql
>    CREATE EVENT MONITOR ... WRITE TO TABLES
>    ```
>
> 3. Db2 creates the event monitor and its associated tables.
>
> Once the event monitor is created, Db2 Genius Hub performs the following cycle:
>
> a. Db2 inserts performance data into the event monitor tables.
> b. Db2 Genius Hub reads the data from the event monitor tables and populates the repository tables.
> c. Db2 Genius Hub flushes the event monitor.
> d. Repeat from step **a**.
>
> If Db2 Genius Hub loses its connection to the monitored database (for example, if a user forces the connection to be terminated), the cycle is broken:
>
> a. Db2 continues inserting performance data into the event monitor tables.
> b. Repeat from step **a**.
>
> **When ATS is enabled:**
> - Db2 Genius Hub creates a watchdog process that automatically detects lost/orphaned event monitors and drops them.
>
> **When ATS is not enabled:**
> - Event monitor tables continue to grow until the tablespace runs out of space.
> - Orphaned event monitors must be identified and dropped manually.

---

### 2.9 Configure Tabs for Utilities Monitoring

Before starting the data load in the next section, add the **Utilities** and **Utilities event monitor** tabs to the Monitor dashboard so you can observe load script activity in real time.

1. From the Monitor dashboard, click the **edit tabs** icon on the right side of the tab bar.

   <img src="images/GH-edit-tabs.png" width="800"/>

2. The **Manage Tabs** window opens. Under **Applications**, select **Utilities** and **Utilities event monitor (a)**.

   <img src="images/GH-edit-tabs-utilites.png" width="800"/>

3. Click **Save (b)**.

---

### 2.10 Next

This completes the Basics of Db2 Genius Hub. Proceed to [Section 3. SQL Workbench](03-workbench.md).

---
