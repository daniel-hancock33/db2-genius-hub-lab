## 3. Monitoring Databases

Now that you have learned the basics, let's start monitoring databases.

> **Note:** Event monitors were configured in [Section 2.7 Turning on Event Monitors](02_basics.md#27-turning-on-event-monitors). If you skipped that section, complete it before proceeding.

> **Note:** Three TPC-H schemas are pre-created in the `demo_col` database with empty tables, ready for data loading:
>
> | Schema | Dataset Size |
> |---|---|
> | `tpch1` | 1 GB |
> | `tpch2` | 2 GB |
> | `tpch3` | 3 GB |
>
> Data will be loaded into these schemas during this section.

1. SSH into the VM as `db2demo`. See [Section 1.4.1 Student SSH Access](01_setup.md#141-student-ssh-access) for instructions.

2. Start the data load script:

   ```bash
   ./load-tpch-data.sh
   ```

   > **Note:** The script will load data into the `tpch1`, `tpch2`, and `tpch3` schemas in the background. This will generate workload on the database that you will observe in the Monitor dashboard.

   The script will load for several minutes, and then you will be able to observe the database activity in the Monitor dashboard.  The output below is an example of the output you will see:
   ```
   ========================================
   TPCH Data Loading Script
   ========================================

   ✓ All data directories found

   Data File Sizes:
   1.1G	/data/tpch1
   2.1G	/data/tpch2
   3.0G	/data/tpch3

   ========================================
   Starting Parallel Data Loading
   ========================================

   🔥 This will create HEAVY database activity!
   🔍 Open Db2 Genius Hub NOW to monitor:
      https://150.240.161.7:11101/console

   Loading will take 20-30 minutes...

   Starting TPCH1 load (1 GB)...
   Starting TPCH2 load (2 GB)...
   Starting TPCH3 load (3 GB)...

   ✓ All three loads started in parallel!

   Process IDs:
   TPCH1: 126739
   TPCH2: 126740
   TPCH3: 126741

   Log files:
   TPCH1: /tmp/tpch1_load.log
   TPCH2: /tmp/tpch2_load.log
   TPCH3: /tmp/tpch3_load.log

   Monitoring progress...

   Loading... TPCH1:⏳ TPCH2:⏳ TPCH3:⏳
   ```

3. Open the Monitor dashboard. From the side menu, click **Monitor (c)**.

   <img src="images/GH-monitor-sidemenu.png" width="200"/>

   > You will receive a notification **Virtual memory in use** at times when the load is running. This is normal and expected behavior in our lab environement due to it serving as the Db2 application instance and the GH repo instane. The notification will appear and disappear as memory is used.  In a production environment, it is recommended to run Genius Hub on a separate server properly sized for your Db2 estate.

4. Using the Monitor dashboard, analyze the graphs and check for any anomalies or spikes **(a)** in CPU usage **(b)** on the system. As the data is loading you will start to see system resources increase.

   <img src="images/GH-resource-utilization-cpu.png" width="800"/>

   In the example below, something happened around **June 6 5:54 AM** where the graph shows an anomaly. Write down the time of your anomaly — you will be investigating the issue in the next steps.

5. Position the mouse close to the dot **(a)** on top of the graph (do not click yet). Db2 Genius Hub will show the details.

   <img src="images/GH-cpu-anomaly-detail.png" width="800"/>

   Around that time, the CPU usage went up to 66% compared to the average CPU usage.

---

### 3.1 Using Drill-Down for Investigation

1. Click the small dot **(a)** to drill down for more details.

   <img src="images/GH-drill-down.png" width="400"/>

2. Db2 Genius Hub sets the filter **(a)** to the time of the issue, and all graphs **(b)** and tabs **(c)** now reflect the CPU data according to the filter.

   <img src="images/GH-drill-down-result.png" width="800"/>

#### 3.1.1 Checking the Utilities

3. Click **View more charts (a)** to see less charts.

   <img src="images/GH-view-more-charts.png" width="800"/>

4. Since we are in a controlled environment we know that the workload is loading data. To check the top utilities running at that time, click the **Utilities Applications (a)** tab. The screen shows several utilities running at the time of the anomaly.

   <img src="images/GH-utilities-tab-detail.png" width="800"/>

5. In the Search bar type: `LOAD` and press **Enter** to show LOAD type only.

   <img src="images/GH-search-load-only.png" width="800"/>

6. Select the three vertical dots **(a)** to the right of one of the LOAD utilities and click  **View details (a)**.

   <img src="images/GH-utilities-view-details.png" width="800"/>

   Here are the details of a LOAD utility that was running at the time of the anomaly.

   <img src="images/GH-utilities-view-details-result.png" width="800"/>

   The Utilities tab shows multiple LOAD utilities running simultaneously at the time of the CPU spike — loading data into tables such as `TPCH3.LINEITEM`. Db2 Genius Hub has identified the parallel data load as the root cause of the increased CPU usage. This is expected behavior when loading large datasets concurrently.

> There are many more views and filters available in Db2 Genius Hub. Explore the different views and filters to find the information you need.

---

### 3.2 Reports

Now that you have identified the cause of the CPU spike, generate a report to document the findings. Reports can be shared with others, kept for historical reference, or scheduled to run automatically on a recurring basis.

1. From the side menu, select **Reports (a)**.

   <img src="images/GH-report-side-menu.png" width="200"/>

2. From the **Reports** page, click **Create report (b)**.

   <img src="images/GH-create-report.png" width="800"/>

3. Select **On-demand (c)** to create a report immediately.

   <img src="images/GH-create-on-demand-report.png" width="400"/>

   Db2 Genius Hub includes several pre-defined report types:

   | Report | Description |
   |---|---|
   | **Database performance** | Overall status and key metrics: CPU, memory, storage, throughput, SQL statements |
   | **Enterprise trends** | Top 10 statements by CPU, memory, storage, and log space usage |
   | **Top statements** | Monitoring metrics for top N SQL statements from package cache |
   | **Table usage** | Top N table objects and related key metrics |
   | **Disk space usage** | Storage usage information for the database |

4. Fill in the report details:

   | Label | Field | Value |
   |---|---|---|
   | **a** | Name | `CPU Spike` |
   | **b** | Type | Database performance |
   | **c** | Database | `demo_col` |

   Click **Next (d)**.

   <img src="images/GH-report-config.png" width="800"/>

5. Add or remove metrics for the report, for our purpose leave the default metrics. Click **Next (a)**.

   <img src="images/GH-report-metrics.png" width="800"/>

6. Ensure **CPU (a)** is selected. At the bottom of the page, keep the Interval as-is **12 hours (b)**. The **Notifications** field can be used to add email addresses to send the report to. Skip this for now and click **Next (c)**.

   <img src="images/GH-report-metrics-custom.png" width="800"/>

7. Review the report summary and click **Finish (a)**.

   <img src="images/GH-report-summary.png" width="800"/>

8. Db2 Genius Hub confirms the report was created. The status bar will show blue (running).

   <img src="images/GH-report-running.png" width="800"/>

9. Once the report disappears from the **Active** tab, click the **Completed (b)** tab.

   <img src="images/GH-report-completed-tab.png" width="800"/>

10. Confirm the report status is **Complete (a)**, select your report **(b)**, and click **View (c)**.

    <img src="images/GH-report-selected.png" width="800"/>

11. When the report opens, check for the CPU anomaly. The report also shows the top 10:

    - Longest running queries
    - Most expensive queries
    - Most run queries

    <img src="images/GH-report-output.png" width="800"/>

    This allows you to investigate which applications were running and consuming CPU at that time. Scroll down to the **Resource usage** chart and hover over the CPU spike *(a)*. This is the same CPU spike we observed in the real-time monitoring. This reporting allows you to investigate the root cause of the CPU spike.

    <img src="images/GH-report-cpu-spike.png" width="800"/>

12. Return to the Genius Hub tab. and select **Share (b)**.

    <img src="images/GH-report-share.png" width="800"/>

13. Db2 Genius Hub allows you to share reports in multiple formats. The following sharing options are available:

      <img src="images/GH-report-share-dialog.png" width="400"/>

      | Tab | Description |
      |---|---|
      | **URL** | Direct link to the report — share with anyone who has access to the Genius Hub console |
      | **Python** | Embed the report in a Jupyter Notebook using an `IFrame` |
      | **JavaScript** | Dynamically inject the report into any web page |
      | **Html** | Embed the report directly in a web page or markdown file using an `<iframe>` tag |


---

### 3.3 Using Agentic AI Assistant

1. Another way to explore what happened around that time is to use the Agentic AI Assistant. Click the **Agentic AI Assistant (a)** menu item.

   <img src="images/GH-agentic-ai-assistant-menu.png" width="200"/>

2. Expand the AI Assistant by clicking th expand button **(b)**.

   <img src="images/GH-agentic-ai-assistant-expanded.png" width="800"/>

3. Read and close the **Legal Disclaimer (c)**.

   <img src="images/GH-agentic-ai-assistant-legal-close.png" width="800"/>

4. In the **Ask a question... (d)** field Choose `demo_col` in the **Choose Database** field.

   <img src="images/GH-agentic-ai-assistant-choose-db.png" width="800"/>

5. In the **Ask a question...** field **(e)**, enter a natural language query for the time period of your anomaly and press enter. For example:

   ```
   show me cpu on June 6 at 5:00 AM to June 6 at 7:00 AM
   ```
   > You will need to change to the date and time you wrote down earlier.  For this example, we know the anomaly happened at 5:54 AM based on our real-time monitoring performaed earlier.

   The Database Assistant will apply the filter and create a result box with a Graph *(a)* and Data view *(b)*.  Click each to see the results.
   
   **Graph**

   <img src="images/GH-agentic-ai-assistant-report-graph.png" width="600"/>

   > Review the graph to see the high cpu usage at 5:54 AM.

   **Data view**
   
   <img src="images/GH-agentic-ai-assistant-report-data.png" width="600"/>

   > Review all the pages until you find the high cpu usage, in my example it is on page 6.

6. You will see the CPU usage went up to 66% **(c)** at 5:54:18 AM in my example.

   <img src="images/GH-agentic-ai-assistant-high-cpu.png" width="400"/>

7. In the **Ask a question...** field **(e)**, enter:

   ```
   What was running on June 6 at 5:54 AM
   ```

   <img src="images/GH-agentic-ai-assistant-running.png" width="400"/>

   > The Agentic AI Assistant looked for SQL running at this time which returned no result.  The more context you provide, the better the results. The CPU wouldn't spike without a running process.  Direct the Agentic AI Assistant to look for other processes that were running at this time.

8. In the **Ask a question...** field **(e)**, enter:

   ```
   Are there utilities running?
   ```

   <img src="images/GH-agentic-ai-assistant-utilites-running.png" width="400"/>

   > **Note:** Since this is the same chat session, the Agentic AI Assistant retains the context of your previous question, including the time range. If you start a new chat session, that context is lost and you will need to specify the time range again.

   The Agentic AI Assistant responds with a detailed breakdown of utility activity at that time. In the example above, the assistant identified **12 utility operations** — 11 RUNSTATS and 1 LOAD — and presented them in a filterable table showing the type, user, start time, and stop time for each operation. The assistant then summarized the key findings:

   - RUNSTATS was actively running on **TPCH1.LINEITEM** from 5:54:04 to 5:54:31
   - Multiple RUNSTATS operations on SYSIBM synonym tables were executed by **DB2INST1**
   - A LOAD operation on **TPCH1.NATION** completed just before this window (5:53:41 to 5:53:42)
   - Three RUNSTATS operations on IBM_RTMON monitoring tables were executed by **DB2DEMO** at 5:54:38

   The assistant also offers to continue the investigation — in this case asking whether you would like to see the performance impact of the **LINEITEM RUNSTATS** operation. This demonstrates the conversational, context-aware nature of the Agentic AI Assistant.

9. Optional: The Agentic AI Assistant can help with much more than performance investigation. Here are some additional questions to explore — feel free to try them in a new session:

   **Monitoring and Performance**
   - What are the configuration parameters for my database?
   - Show me time spent on various processing
   - Show me time spent from yesterday
   - Show me my database performance
   - Show me my database performance from 3 days ago until today
   - What is the query throughput of the system today?
   - What is my query throughput in the last 10 hours?
   - Query response time in the last hour
   - List top 3 longest running queries
   - CPU summary
   - Memory summary

   **Navigation**
   - Take me to the home page
   - Take me to the workbench

   **Schema and Storage**
   - What's my top 5 largest tables?
   - What's my top 5 largest tables by storage size?
   - List of tables
   - List of schemas
   - Storage utilization by tablespace
   - Show me DDL
   - Show me table definition

   **Statistics**
   - Get outdated statistics
   - Give me list of tables in schema ibm_rtmon which has outdated stats
   - Give me outdated stats for schema ibm_rtmon with row changes of 20% or more in last 5 hours

   **Conversational Examples**
   - How can I cast XML data to non-XML data?
   - How can I configure the Db2 audit facility?
   - What are some WLM objects? Show in a tabular fashion
   - What does this SQL do?
```sql
     SELECT eee.workdept AS dp#, eee.empno, aaa.projno, ppp.prstaff AS staff
     FROM (SELECT * FROM employee
           WHERE lastname LIKE '%A%'
           AND job <> 'DESIGNER'
           AND workdept BETWEEN 'B' AND 'E') AS eee
     LEFT OUTER JOIN emp_act aaa ON aaa.empno = eee.empno AND aaa.emptime <= 0.5
     INNER JOIN project ppp ON aaa.projno = ppp.projno AND ppp.projname LIKE '%Q%'
     ORDER BY eee.workdept, eee.empno, aaa.projno;
```
   - What does this code do?
```sql
     CREATE FUNCTION julian_out(inval DATE) RETURNS CHAR(7)
     RETURN RTRIM(CHAR(YEAR(inval))) || SUBSTR(DIGITS(DAYOFYEAR(inval)),8);

     SELECT empno, CHAR(hiredate, ISO) AS h_date, JULIAN_OUT(hiredate) AS j_date
     FROM employee
     WHERE empno < '000050'
     ORDER BY empno;
```

   > These are just a starting point — be creative and explore what the Agentic AI Assistant can do for you!

---

---

#### 3.3.1 Database Assistant Operation Modes

Db2 Genius Hub provides 2 additional operation modes for the Database Assistant:

- **Agent Mode**
  - Supports troubleshooting and monitoring tasks, such as query performance, WLM queuing, or SQL changes
  - Provides natural language to SQL code generation

- **Deep Research**
  - Performs in-depth research on database queries
  - Generates a report with sources and citations

When you interact with the assistant:

a. Enter the research or troubleshooting prompt. If the request is unclear, the assistant asks follow-up questions.  
b. The assistant generates an artifact and streams progress updates, such as planning, researching, validating, and report generation.  
c. When the process is complete, you can view both the answer and the detailed research activity with citations.

##### 3.3.1.1 Agent Mode Sample Questions

The Agent mode can help you with questions related to:

a. Performance troubleshooting  
b. Resolving locking issues  
c. Database health checks  
d. What's changed analysis  
e. Resolving blocking transactions  
f. Text2SQL  
g. Conversational search

Make sure **Agent Mode (a)** is selected, then try these examples:

- Generate a SQL to find all players from US who have scored more than 1000 runs in World Cups
- Generate a SQL to list all players along with their countries who have taken more than 30 wickets in World Cup cricket
- Generate a SQL to find all players who have both batting and bowling records in World Cups, showing their total runs and total wickets

##### 3.3.1.2 Deep Research Sample Questions

The Deep Research mode can help you with documentation summarization and topic analysis. Here are some examples:

- How to set up HADR in db2?
- Are there any queuing taking place? If so, can you tell me which is in the head of the queue. Can you also tell me list of queries causing queuing to take place
- Why is my query running slow? Can you reason out the same?
- Show me the log file size settings for my DB2 database
- Give me the current value of INSTANCE_MEMORY in my DB2 configuration?
- Can you do a quick health check of my DB2 database?
- Show me all the waiting locks held by application handle
- What is the current buffer pool hit ratio in my database?
- What activities are currently running in my database?
- How much of my transaction log space is currently being used?
- Show me the transaction log usage across all database members
- Give me the unit of work IDs for all active transactions?

##### 3.3.1.3 Close the Agentic AI Assitant and return to the Genius Hub Home page.

Click the **Close (a)** button in the top right corner of the Agentic AI Assistant window.

   <img src="images/GH-close-agentic-ai-assistant.png" width="800"/>

You are now back at the Genius Hub Home page.


---

### 3.4 Alerts

Now that you know you have an anomaly in your system which happens from time to time, you want to get an alert if the anomaly happens again.

1. From the side menu on the left side, select **Administration (a)** and **Console (b)**.

   <img src="images/GH-admin-sidemenu.png" width="200"/>

2. From the Administration menu, under **Monitoring**, click **Monitoring profiles (c)**.

   <img src="images/GH-monitoring-profiles-menu.png" width="800"/>

   The **Monitoring profile** window opens. More details on monitoring profiles are covered later in the lab.

3. Select the **default (d)** profile name and click **Edit (e)**.

   <img src="images/GH-monitoring-profile-edit.png" width="800"/>

4. From the **Alerts (f)** section, click **View all (g)**.

   <img src="images/GH-alerts-settings.png" width="800"/>

5. From the **Anomaly detection (h)** tab select all Anomaly types and click **Activate (i)**.

   <img src="images/GH-anomaly-types.png" width="800"/>


6. If not logged into the VM, SSH into the VM as `db2demo`. See [Section 1.4.1 Student SSH Access](01_setup.md#141-student-ssh-access) for instructions.

7. Rerun the the data load script:

   ```bash
   ./load-tpch-data.sh
   ```

8. Open the Monitor dashboard. From the side menu, click **Monitor (c)**.

   <img src="images/GH-monitor-sidemenu.png" width="200"/>

9. In the Notification section notice the anomaly alerts.

   <img src="images/GH-monitor-anomaly-alerts.png" width="800"/>

   The **Notification Center** displays active alerts for the monitored database. In the example above, two notifications are shown for `demo_col`:

   - **Log space usage anomaly detected** *(informational)* — The percentage of transaction log space being used has deviated from normal patterns. Rapid log space growth may indicate long-running transactions, insufficient log space configuration, or archive log issues. This can lead to transaction failures and database unavailability if log space fills completely.
   - **Virtual memory in use** *(critical)* — A critical alert indicating virtual memory is being consumed on the system.

   Each notification includes:

   - A **Description** explaining what was detected and why it may be a concern
   - A **Recommended solution** with specific actions to investigate and resolve the issue

   Two actions are available at the bottom of each notification:

   | Button | Action |
   |---|---|
   | **Filter by notification** | Filters the Monitor dashboard to the time of the alert for further investigation |
   | **Work with AI Assistant** | Opens the Agentic AI Assistant pre-loaded with the alert context for guided troubleshooting |

10. For the **Log space usage anomaly detected** notification, click **Filter by notification (a)**.

    <img src="images/GH-monitor-filter-by-notification.png" width="800"/>

      > **Note:** Clicking **Filter by notification** automatically sets the time filter to the moment the anomaly was detected. All charts and tabs on the Monitor dashboard immediately update to show what was happening on the system at that time — making it easy to correlate the alert with the underlying database activity without having to manually set a time range.

11. For the **Log space usage anomaly detected** notification, click **Work with AI Assistant (a)**.

    <img src="images/GH-monitor-work-with-ai-assistant.png" width="800"/>

    > **Note:** Clicking **Work with AI Assistant** opens the Agentic AI Assistant pre-loaded with the context of the alert. The assistant is aware of the alert type, the database, and the time it occurred — allowing you to immediately ask follow-up questions or request a guided investigation without having to re-enter any context.

---

### 3.5 Query Monitoring

1. SSH into the VM as `db2demo`. See [Section 1.4.1 Student SSH Access](01_setup.md#141-student-ssh-access) for instructions.

2. Run the workload exerciser script to generate query activity across all three schemas:

   ```bash
      cd /home/db2demo/db2-tpch-cli-sim/scripts
      sh ./exerciser.sh demo_col --schema1 TPCH1 --schema2 TPCH2 --schema3 TPCH3
   ```

   Once running, you should see output similar to:

   ```
   --------------------------------------------------------------------------------
   DB2 TPC-H Workload Exerciser
   --------------------------------------------------------------------------------

   Configuration:
   Database: demo_col
   Schemas: TPCH1, TPCH2, TPCH3

   Checking for database...
   ✓ Found database: demo_col
   Note: Assuming schemas TPCH1, TPCH2, TPCH3 exist

   Launching workload sessions...
   Log files will be written to /tmp


   ==========================================
   All 9 workload sessions are now running!
   ==========================================

   Sessions with maintenance tasks (marked X):
   - demo_col/TPCH1/user1  (backup, reorg, runstats)
   - demo_col/TPCH2/user2 (backup, reorg, runstats)
   - demo_col/TPCH3/user3  (backup, reorg, runstats)

   Log files:
   /tmp/tpch_TPCH1.*.log
   /tmp/tpch_TPCH2.*.log
   /tmp/tpch_TPCH3.*.log

   To monitor activity:
   tail -f /tmp/*.log
   db2top
   db2pd -db <dbname> -applications

   This script will run until you press Ctrl+C
   ==========================================
   ```

3. Open the Monitor dashboard. From the side menu, click **Monitor (a)**.

   <img src="images/GH-monitor-sidemenu.png" width="200"/>

4. Select the database `demo_col` from the **Database** drop-down list.

   <img src="images/GH-monitor-database.png" width="800"/>

5. Allow the workload to run for approximately 5 minutes so that Db2 Genius Hub captures meaningful activity data.

6. Return to the terminal and stop the script by pressing **Ctrl+C**.

   ```
   ==========================================
   Shutting down workload sessions...
   All sessions terminated.
   Log files preserved in /tmp
   ```

7. Back in Db2 Genius Hub, observe the increase in resource usage on the **Resource utilization** chart — CPU usage will have increased and memory usage will have risen. This is expected behavior from the concurrent query workload and is used here to illustrate the monitoring capabilities of Db2 Genius Hub.

   <img src="images/GH-monitor-dashboard-cpu-memory.png" width="800"/>

8. Click the highest CPU usage point in the **Resource utilization** chart to drill down into the details and view the SQL statements that were running at that specific point in time.

   <img src="images/GH-monitor-dashboard-highest-cpu.png" width="800"/>

9. Notice how the filtering is applied to the SQL statements table, showing only the SQL statements that were running at that specific point in time.

   <img src="images/GH-monitor-dashboard-highest-cpu-point-in-time.png" width="800"/>


   The Monitor dashboard updates automatically after clicking **Filter by notification** on the **Shared sort memory anomaly detected** alert. The filter bar confirms the timeframe is now set to the time of the anomaly. Four active notifications are visible in the notification panel, including a warning for **Virtual memory in use**. The charts reflect activity during the workload period:

   - **Time spent** — shows significant SQL execution activity with large portions of lock waits and other processing
   - **Resource utilization** — shows elevated memory and CPU usage throughout the workload period
   - **Throughput** — shows statement execution rate dropping off toward the end of the period

10. Click the **In-flight executions Statement** tab to view the SQL statements that were running at that specific point in time.

    <img src="images/GH-monitor-dashboard-cpu-inflight-sql.png" width="800"/>

    Clicking the **In-flight executions** tab reveals all SQL statements that were actively executing at the time of the CPU increase. The tab shows **34 statements across 4 pages**, all with an activity state of **EXECUTING**, run by **DB2DEMO** from application **db2bp**. The statements are TPC-H benchmark queries involving aggregations, joins, and GROUP BY clauses — consistent with the **Shared sort memory anomaly**, which is triggered by large sort operations from complex queries.
inc
    Key metrics available for each statement:

    | Column | Description |
    |---|---|
    | **SQL** | The SQL statement being executed |
    | **Statement execution time** | How long the statement has been running |
    | **Start time** | When the statement started |
    | **Rows read** | Number of rows scanned |
    | **Estimated query cost** | Optimizer's estimated cost |
    | **Peak sort used** | Peak sort memory consumed |
    | **WLM queue time** | Time spent waiting in the workload manager queue |

11. Select the **Shared sort memory anomaly detected (a)** from the Notications section.

    <img src="images/GH-monitor-dashboard-shared-sort-anomaly.png" width="800"/>
    
12. Click the **Filter by notification button (c)** for the **Shared sort memory anomaly detected**.

    <img src="images/GH-monitor-dashboard-shared-sort-anomaly-filtered.png" width="800"/>

      The Monitor dashboard now shows a broader time range, with the pink highlighted region indicating the period when the workload was actively running. The notification panel shows the **Shared sort memory anomaly detected (c)** alert selected, with two action buttons available: **Filter by notification (d)** and **Work with AI Assistant**.

      The charts clearly show the workload activity window:

      - **Time spent** — two distinct spikes of SQL execution activity are visible, corresponding to the workload sessions. Outside of these spikes the system is idle, making the workload period easy to identify.
      - **Resource utilization** — CPU usage rises sharply during the workload window then returns to baseline, while memory remains consistently elevated throughout.
      - **Throughput** — shows bursts of statement execution and rows read during the active workload period.

      The **In-flight executions** tab shows the SQL statements that were actively executing at the time of the anomaly. The highlighted statements are TPC-H benchmark queries — complex analytical SQL involving aggregations, multi-table joins, and GROUP BY clauses run by **DB2DEMO** from application **db2bp**. These types of queries are known to consume significant sort memory, which is consistent with the **Shared sort memory anomaly** alert.

      Each statement provides key execution metrics including rows read, estimated query cost, sort memory used, and WLM queue time — giving you immediate visibility into what was running and how much resource each statement was consuming at the time of the alert.

13. Select the three vertical dots *(a)* to the right of one of the SQL statements to view the **Details (b)**.

      <img src="images/GH-sql-select-details.png" width="800"/>

14. Clicking a statement opens the **SQL details** page, which provides a full breakdown of the selected statement's execution context.

    <img src="images/GH-sql-details.png" width="800"/>

    The header shows key execution metadata:

    | Field | Value |
    |---|---|
    | Application handle | 56762 |
    | Activity ID | 1 |
    | UOW ID | 3 |
    | Entry time | Jun 6, 2026 3:55 PM |
    | Total time | 0:00.021 |
    | WLM queue time | 0.00% |
    | Threshold violations | 0 |

    The SQL statement is displayed in full — a TPC-H query calculating revenue from the `LINEITEM` table using date range and discount filters with parameterized markers (`?`).

    Below the SQL, several analysis tabs are available:

    | Tab | Description |
    |---|---|
    | **Explain Plan** | Visual execution plan for the statement |
    | **Locking** | Lock activity associated with the statement |
    | **I/O** | I/O activity during execution |
    | **Log** | Transaction log usage |
    | **Sort** | Sort memory consumption |
    | **Time spent** | Breakdown of time across execution phases |
    | **Additional Info** | Extended execution metadata |

    > **Note:** In this example, the Explain Plan is not available for this statement type. Click **Open in Workbench** to open the statement in the SQL Workbench for further analysis and tuning.

15. Click the **Sort** tab to view the sort memory details for this statement — particularly relevant since the alert was triggered by a shared sort memory anomaly.

    <img src="images/GH-sql-details-sort.png" width="800"/>

    The Sort tab shows detailed sort memory metrics for the statement:

    | Metric | Value |
    |---|---|
    | Total sorts | 0 |
    | Sort overflows | 0 |
    | Sort share heap currently allocated | 2478 |
    | Estimated sort share heap top pages | 8668 |
    | Sort share heap high watermark | 2478 |
    | Hash join overflows | 0 |
    | Hash group by overflows | 0 |

    Even though this individual statement shows no sort overflows, the **sort share heap currently allocated (2478 pages)** and **estimated top pages (8668)** indicate significant sort memory consumption. When many similar TPC-H queries run concurrently, the cumulative sort heap usage across all statements is what triggers the shared sort memory anomaly — not any single statement in isolation.

16. Select the **Explain Plan (a)** tab and click the **Open in Workench (b)** button.

    <img src="images/GH-sql-details-explain.png" width="800"/>

17. On the Workbench, click the **Explain (a)** icon.

    <img src="images/GH-sql-workbench-explain-icon.png" width="800"/>

18. Client Ok to run the visual explain.

    <img src="images/GH-sql-workbench-run-explain.png" width="800"/>

19. Change the schema to `TPCH3` and click **OK (b)** to generate the explain.

    <img src="images/GH-sql-workbench-change-schema.png" width="800"/>

20. Review the visual explain plan.

    <img src="images/GH-sql-workbench-explain.png" width="800"/>

    The **Explain Plan** view provides a visual representation of how Db2 will execute the SQL statement. The execution plan shows a simple 5-node plan for the TPC-H query against the `LINEITEM` table in the `TPCH3` schema:

      | Step | Operator | Cost |
      |---|---|---|
      | 1 | Return | 9,570.68 |
      | 2 | Grpby (Group By) | 9,570.68 |
      | 3 | Grpby (Group By) | 9,570.68 |
      | 4 | Tbscan (Table Scan) | 9,570.64 |
      | s1 | LineItem — Tpch3 | — |

      The plan shows that Db2 is performing a full **table scan** on `TPCH3.LINEITEM` followed by two **group by** aggregation operations before returning the result. The absence of an index scan confirms that no suitable index exists for this query — contributing to the high CPU and sort memory usage observed during the workload.

      The right panel shows the **Properties** for the selected node, including:

      | Property | Value |
      |---|---|
      | Cumulative total cost | 9,570.68 |
      | Cumulative CPU cost | 15,917,137,920.00 |
      | Cumulative I/O cost | 4,185.00 |
      | Prep time | 19 milliseconds |
      | Statement heap size | 16,384 |

      Two actions are available at the bottom:

      - **Tune query** — opens the AI Query Tuner to analyze and recommend improvements
      - **Open in Workbench** — opens the statement in the SQL Workbench for manual editing and testing

21. Click **Tune query**

    <img src="images/GH-tune-query.png" width="800"/>

22. Click OK on the **Select tuning activity to run**.

    <img src="images/GH-tune-query-ok.png" width="800"/>

23. Click **Close** for the query tuning task.

    <img src="images/GH-tune-query-tuning-task-ok.png" width="800"/>

24. From the side menu on the left side, select **Workbench (a)**.

    <img src="images/GH-workbench-sidemenu.png" width="200"/>

25. In the **Workbench** select **Query tuning report (a)***.

    <img src="images/GH-workbench-query-tuning-report.png" width="800"/>

### 3.6 Jobs

You can use Db2 Genius Hub to create and schedule jobs. We will run a heavy query using a job to simulate the alert configured in the previous section.

> Note: this section is **information only** as there is a firewall port issue related to SSH port 22 disables in the lab environment that prevents the job from running.  That issue will be addressed in a future release of Genius Hub.

1. From the side menu on the left side, select **Administration (e)**.

   <img src="images/GH-admin-sidemenu.png" width="200"/>

2. From the Administration menu, under **Jobs**, click **Jobs**.

   <img src="images/GH-jobs-menu.png" width="800"/>

   The **Jobs** window opens.

3. Click **Create job (a)**.

   <img src="images/GH-create-job.png" width="800"/>

   The **Create new job** window opens.

4. In the **Define (a)** tab, enter a **Name (b)** for the job. Select **SQL script (c)**. In the **Job script text (d)** field, enter the following SQL:

   ```sql
   SELECT * FROM
      SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,
      SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,
      SYSIBM.TABLES,SYSIBM.TABLES
   ;
   ```
   > **Caution:** This is a cartesian product query designed to generate CPU load. Do not add more table references than shown — too many will overload the system.

   <img src="images/GH-create-job-define.png" width="800"/>

5. Scroll down to the bottom of the page and click **Next (a)**.

   <img src="images/GH-create-job-next.png" width="800"/>

6. In the **Select databases (a)** tab, select **Personal credential (b)** and select **`demo_col` (c)**. Click **Next (d)**.

   <img src="images/GH-create-job-database.png" width="800"/>

7. A summary of the job is displayed. Click **Finish (a)**.

   <img src="images/GH-create-job-summary.png" width="800"/>

8. A message confirming the job was created successfully is displayed.

   <img src="images/GH-job-created.png" width="800"/>

9. From the **Jobs** page, click the **3 dots (a)** on the right side of the job and select **Run with existing credentials (b)** from the drop-down menu.

   <img src="images/GH-job-run.png" width="800"/>

10. Wait until you see the alert **(a)** in the upper-right corner.

    <img src="images/GH-job-alert.png" width="800"/>

11. When you see the alert, stop the job to avoid consuming excessive CPU. Click **Stop (b)** after selecting your job **(a)**.

    <img src="images/GH-job-stop.png" width="800"/>

12. The **Stop job** window opens. Click **Stop (a)**.

    <img src="images/GH-job-stop-confirm.png" width="800"/>

13. Delete the job as it is no longer needed. Select your job **(a)** and click **Delete (b)**.

    <img src="images/GH-job-delete.png" width="800"/>

14. Go back to the Monitor dashboard by clicking **Monitor (c)** from the side menu.

    <img src="images/GH-monitor-sidemenu.png" width="200"/>

15. Select the **CPU time (a)** alert. The alert details **(b)** are displayed.

    <img src="images/GH-alert-cpu-time.png" width="800"/>

16. Click **Work with Database Assistant (a)**. The Database Assistant window opens on the right side of the screen. Review the recommendation.

    <img src="images/GH-alert-database-assistant.png" width="800"/>

17. Write down the recommendation from the Database Assistant.

18. You can also view the recommendation from the Notification Center. Click the **alert (a)** icon in the upper-right corner.

    <img src="images/GH-notification-center-icon.png" width="400"/>

19. The **Notification Center** summary window opens. Click **View notification center (a)** at the lower-right side of the screen.

    <img src="images/GH-notification-center-summary.png" width="800"/>

20. The **Notification Center** window is displayed. Select the **CPU time (a)** alert and review the alert details **(b)** on the right side of the screen.

    <img src="images/GH-notification-center-detail.png" width="800"/>

    From the recommendation you can view the access plan or tune the statement. These options will be explored later in the lab in the Visual Explain and Query Tuning sections.
