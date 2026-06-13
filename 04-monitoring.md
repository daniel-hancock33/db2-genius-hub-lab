<h1 style="padding-left:16px; border-left:8px solid #378ADD;">Section 4 — Monitoring Databases</h1>

Now that you have learned the basics, let's start monitoring databases.

> **⚠️ Prerequisite:** Event monitors were configured in [Section 2 — Turning on Event Monitors](02-basics.md#turning-on-event-monitors). If you skipped that section, complete it before proceeding.

> **ℹ️ Pre-created TPC-H schemas:** Three schemas are pre-created in the `demo_col` database with empty tables, ready for data loading:
>
> | Schema | Dataset Size |
> |---|---|
> | `tpch1` | 1 GB |
> | `tpch2` | 2 GB |
> | `tpch3` | 3 GB |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Start the Data Load</h2>

1. SSH into the VM as `db2demo`. See [Section 1 — Student SSH Access](01-setup.md#step-1--student-ssh-access) for instructions.

2. Start the data load script:

   ```bash
   ./load-tpch-data.sh
   ```

   > **ℹ️ Note:** The script loads data into the `tpch1`, `tpch2`, and `tpch3` schemas in parallel. This generates heavy workload that you will observe in the Monitor dashboard.

   Example output:

   ```
   ========================================
   TPCH Data Loading Script
   ========================================

   ✓ All data directories found

   Data File Sizes:
   1.1G    /data/tpch1
   2.1G    /data/tpch2
   3.0G    /data/tpch3

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
   ```

3. Open the Monitor dashboard. From the side menu, click **Monitor (c)**.

   <img src="images/GH-monitor-sidemenu.png" width="200"/>

   > **ℹ️ Note:** You may receive a **Virtual memory in use** notification while the load is running. This is expected in the lab environment where Db2 and the Genius Hub repository share the same VM. In production, it is recommended to run Genius Hub on a separate, properly sized server.

4. Analyze the graphs and check for anomalies or spikes **(a)** in CPU usage **(b)**. As data loads, you will see system resources increase.

   <img src="images/GH-resource-utilization-cpu.png" width="800"/>

   In the example below, something happened around **June 6 5:54 AM** where the graph shows an anomaly. **Write down the time of your anomaly** — you will investigate it in the next steps.

5. Hover over the dot **(a)** on top of the graph (do not click yet) to see the details.

   <img src="images/GH-cpu-anomaly-detail.png" width="800"/>

   Around that time, CPU usage went up to **66%** compared to the average.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Using Drill-Down for Investigation</h2>

1. Click the small dot **(a)** to drill down for more details.

   <img src="images/GH-drill-down.png" width="400"/>

2. Genius Hub sets the filter **(a)** to the time of the issue. All graphs **(b)** and tabs **(c)** now reflect the CPU data according to the filter.

   <img src="images/GH-drill-down-result.png" width="800"/>

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Checking the Utilities</h3>

3. Click **View more charts (a)** to collapse extra charts.

   <img src="images/GH-view-more-charts.png" width="800"/>

4. Click the **Utilities Applications (a)** tab to see the top utilities running at the time of the anomaly.

   <img src="images/GH-utilities-tab-detail.png" width="800"/>

5. In the Search bar, type `LOAD` and press **Enter** to filter to LOAD type only.

   <img src="images/GH-search-load-only.png" width="800"/>

6. Click the three vertical dots **(a)** to the right of one of the LOAD utilities and select **View details**.

   <img src="images/GH-utilities-view-details.png" width="800"/>

   <img src="images/GH-utilities-view-details-result.png" width="800"/>

   The Utilities tab shows multiple LOAD utilities running simultaneously at the time of the CPU spike — loading data into tables such as `TPCH3.LINEITEM`. Db2 Genius Hub has identified the parallel data load as the root cause of the increased CPU usage.

> **💡 Explore:** There are many more views and filters available in Db2 Genius Hub. Explore the different views and filters to find the information you need.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Reports</h2>

Now that you have identified the cause of the CPU spike, generate a report to document the findings. Reports can be shared, kept for historical reference, or scheduled to run automatically.

1. From the side menu, select **Reports (a)**.

   <img src="images/GH-report-side-menu.png" width="200"/>

2. Click **Create report (b)**.

   <img src="images/GH-create-report.png" width="800"/>

3. Select **On-demand (c)** to create a report immediately.

   <img src="images/GH-create-on-demand-report.png" width="400"/>

   **Available report types:**

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

5. Leave the default metrics and click **Next (a)**.

   <img src="images/GH-report-metrics.png" width="800"/>

6. Ensure **CPU (a)** is selected. Keep the Interval as **12 hours (b)**. Skip the **Notifications** field and click **Next (c)**.

   <img src="images/GH-report-metrics-custom.png" width="800"/>

7. Review the summary and click **Finish (a)**.

   <img src="images/GH-report-summary.png" width="800"/>

8. The report status bar shows blue (running).

   <img src="images/GH-report-running.png" width="800"/>

9. Once the report disappears from **Active**, click the **Completed (b)** tab.

   <img src="images/GH-report-completed-tab.png" width="800"/>

10. Confirm the status is **Complete (a)**, select your report **(b)**, and click **View (c)**.

    <img src="images/GH-report-selected.png" width="800"/>

11. The report opens showing the CPU anomaly and the top 10 longest running, most expensive, and most run queries.

    <img src="images/GH-report-output.png" width="800"/>

    Scroll down to the **Resource usage** chart and hover over the CPU spike *(a)*. This is the same spike observed in real-time monitoring.

    <img src="images/GH-report-cpu-spike.png" width="800"/>

12. Return to the Genius Hub tab and click **Share (b)**.

    <img src="images/GH-report-share.png" width="800"/>

13. Available sharing options:

    | Tab | Description |
    |---|---|
    | **URL** | Direct link — share with anyone who has Genius Hub console access |
    | **Python** | Embed in a Jupyter Notebook using an `IFrame` |
    | **JavaScript** | Dynamically inject the report into any web page |
    | **Html** | Embed using an `<iframe>` tag in any web page or markdown file |

    <img src="images/GH-report-share-dialog.png" width="400"/>

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Using the Agentic AI Assistant</h2>

1. Click the **Agentic AI Assistant (a)** menu item.

   <img src="images/GH-agentic-ai-assistant-menu.png" width="200"/>

2. Expand the AI Assistant by clicking the expand button **(b)**.

   <img src="images/GH-agentic-ai-assistant-expanded.png" width="800"/>

3. Read and close the **Legal Disclaimer (c)**.

   <img src="images/GH-agentic-ai-assistant-legal-close.png" width="800"/>

4. In the **Ask a question... (d)** field, choose `demo_col` in the **Choose Database** field.

   <img src="images/GH-agentic-ai-assistant-choose-db.png" width="800"/>

5. Enter a natural language query for the time period of your anomaly and press Enter. For example:

   ```
   show me cpu on June 6 at 5:00 AM to June 6 at 7:00 AM
   ```

   > **⚠️ Change the date and time** to match the anomaly you observed earlier.

   The Database Assistant applies the filter and creates a result box with a **Graph** view and a **Data** view. Click each to see the results.

   **Graph view:**

   <img src="images/GH-agentic-ai-assistant-report-graph.png" width="600"/>

   **Data view:**

   <img src="images/GH-agentic-ai-assistant-report-data.png" width="600"/>

6. You will see the CPU usage spike at the time of the anomaly (e.g., 66% at 5:54:18 AM).

   <img src="images/GH-agentic-ai-assistant-high-cpu.png" width="400"/>

7. Ask a follow-up question:

   ```
   What was running on June 6 at 5:54 AM
   ```

   <img src="images/GH-agentic-ai-assistant-running.png" width="400"/>

   > The assistant searched for SQL running at this time and returned no result. Provide more context — the CPU wouldn't spike without a running process.

8. Ask the assistant to look for other processes:

   ```
   Are there utilities running?
   ```

   <img src="images/GH-agentic-ai-assistant-utilites-running.png" width="400"/>

   > **ℹ️ Note:** Since this is the same chat session, the assistant retains context from your previous question, including the time range. Starting a new session clears this context.

   The assistant responds with a detailed breakdown of utility activity — identifying 12 utility operations (11 RUNSTATS and 1 LOAD) and presenting them in a filterable table.

9. **Optional:** Try these additional questions to explore the assistant's capabilities:

   **Monitoring and Performance:**
   - `What are the configuration parameters for my database?`
   - `Show me time spent on various processing`
   - `Show me my database performance from 3 days ago until today`
   - `What is the query throughput of the system today?`
   - `List top 3 longest running queries`
   - `CPU summary` / `Memory summary`

   **Navigation:**
   - `Take me to the home page`
   - `Take me to the workbench`

   **Schema and Storage:**
   - `What's my top 5 largest tables by storage size?`
   - `List of schemas`
   - `Storage utilization by tablespace`
   - `Show me DDL`

   **Statistics:**
   - `Get outdated statistics`
   - `Give me outdated stats for schema ibm_rtmon with row changes of 20% or more in last 5 hours`

   **Conversational Examples:**
   - `How can I cast XML data to non-XML data?`
   - `What are some WLM objects? Show in a tabular fashion`
   - `What does this SQL do?`
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

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Database Assistant Operation Modes</h3>

Db2 Genius Hub provides 2 additional operation modes for the Database Assistant:

| Mode | Description |
|---|---|
| **Agent Mode** | Supports troubleshooting and monitoring tasks; natural language to SQL code generation |
| **Deep Research** | Performs in-depth research and generates a report with sources and citations |

**How it works:**

1. Enter a research or troubleshooting prompt. If unclear, the assistant asks follow-up questions.
2. The assistant streams progress updates: planning, researching, validating, and report generation.
3. When complete, view both the answer and detailed research activity with citations.

<h4 style="padding-left:14px; border-left:4px solid #888780;">Agent Mode Sample Questions</h4>

Ensure **Agent Mode (a)** is selected, then try:

- `Generate a SQL to find all players from US who have scored more than 1000 runs in World Cups`
- `Generate a SQL to list all players along with their countries who have taken more than 30 wickets in World Cup cricket`
- `Generate a SQL to find all players who have both batting and bowling records in World Cups, showing their total runs and total wickets`

Agent Mode also handles:

| Category | Examples |
|---|---|
| Performance troubleshooting | WLM queuing, slow queries |
| Locking issues | Deadlocks, lock waits |
| Database health checks | Overall health summary |
| What's changed analysis | Config and schema changes |
| Blocking transactions | Identify and resolve blockers |
| Text2SQL | Natural language to SQL |
| Conversational search | Ask questions in plain English |

<h4 style="padding-left:14px; border-left:4px solid #888780;">Deep Research Sample Questions</h4>

- `How to set up HADR in db2?`
- `Are there any queuing taking place? If so, can you tell me which is in the head of the queue?`
- `Why is my query running slow? Can you reason out the same?`
- `Show me the log file size settings for my DB2 database`
- `Can you do a quick health check of my DB2 database?`
- `Show me all the waiting locks held by application handle`
- `What is the current buffer pool hit ratio in my database?`
- `What activities are currently running in my database?`
- `How much of my transaction log space is currently being used?`

<h4 style="padding-left:14px; border-left:4px solid #888780;">Close the Agentic AI Assistant</h4>

Click the **Close (a)** button in the top right corner of the Agentic AI Assistant window.

<img src="images/GH-close-agentic-ai-assistant.png" width="800"/>

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Alerts</h2>

Now that you have identified an anomaly, configure alerts so you are notified if it recurs.

1. From the side menu, select **Administration (a) → Console (b)**.

   <img src="images/GH-admin-sidemenu.png" width="200"/>

2. Under **Monitoring**, click **Monitoring profiles (c)**.

   <img src="images/GH-monitoring-profiles-menu.png" width="800"/>

3. Select the **default (d)** profile and click **Edit (e)**.

   <img src="images/GH-monitoring-profile-edit.png" width="800"/>

4. From the **Alerts (f)** section, click **View all (g)**.

   <img src="images/GH-alerts-settings.png" width="800"/>

5. From the **Anomaly detection (h)** tab, select all Anomaly types and click **Activate (i)**.

   <img src="images/GH-anomaly-types.png" width="800"/>

6. SSH into the VM as `db2demo` and rerun the data load script:

   ```bash
   ./load-tpch-data.sh
   ```

7. Open the Monitor dashboard. From the side menu, click **Monitor (c)**.

   <img src="images/GH-monitor-sidemenu.png" width="200"/>

8. In the Notification section, notice the anomaly alerts.

   <img src="images/GH-monitor-anomaly-alerts.png" width="800"/>

   The **Notification Center** displays active alerts. Each notification includes:

   | Element | Description |
   |---|---|
   | **Description** | What was detected and why it may be a concern |
   | **Recommended solution** | Specific actions to investigate and resolve the issue |
   | **Filter by notification** | Filters the Monitor dashboard to the time of the alert |
   | **Work with AI Assistant** | Opens the Agentic AI Assistant pre-loaded with the alert context |

9. For the **Log space usage anomaly detected** notification, click **Filter by notification (a)**.

   <img src="images/GH-monitor-filter-by-notification.png" width="800"/>

   > **ℹ️ Note:** Clicking **Filter by notification** automatically sets the time filter to the moment the anomaly was detected. All charts and tabs immediately update to show what was happening at that time.

10. For the same notification, click **Work with AI Assistant (a)**.

    <img src="images/GH-monitor-work-with-ai-assistant.png" width="800"/>

    > **ℹ️ Note:** The Agentic AI Assistant opens pre-loaded with the alert context — including the alert type, database, and time — allowing you to immediately ask follow-up questions without re-entering any context.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Query Monitoring</h2>

1. SSH into the VM as `db2demo` and run the workload exerciser script:

   ```bash
   cd /home/db2demo/db2-tpch-cli-sim/scripts
   sh ./exerciser.sh demo_col --schema1 TPCH1 --schema2 TPCH2 --schema3 TPCH3
   ```

   Expected output:

   ```
   --------------------------------------------------------------------------------
   DB2 TPC-H Workload Exerciser
   --------------------------------------------------------------------------------

   Database: demo_col
   Schemas: TPCH1, TPCH2, TPCH3

   Launching workload sessions...

   ==========================================
   All 9 workload sessions are now running!
   ==========================================

   Sessions with maintenance tasks (marked X):
   - demo_col/TPCH1/user1  (backup, reorg, runstats)
   - demo_col/TPCH2/user2  (backup, reorg, runstats)
   - demo_col/TPCH3/user3  (backup, reorg, runstats)

   This script will run until you press Ctrl+C
   ==========================================
   ```

2. Open the Monitor dashboard. From the side menu, click **Monitor (a)**.

   <img src="images/GH-monitor-sidemenu.png" width="200"/>

3. Select `demo_col` from the **Database** drop-down list.

   <img src="images/GH-monitor-database.png" width="800"/>

4. Allow the workload to run for approximately **5 minutes** so Genius Hub captures meaningful activity data.

5. Return to the terminal and stop the script: press **Ctrl+C**.

6. Back in Db2 Genius Hub, observe the increased resource usage on the **Resource utilization** chart.

   <img src="images/GH-monitor-dashboard-cpu-memory.png" width="800"/>

7. Click the highest CPU usage point to drill down and view the SQL statements running at that specific point in time.

   <img src="images/GH-monitor-dashboard-highest-cpu.png" width="800"/>

8. Notice how filtering is applied, showing only the SQL statements running at that point in time.

   <img src="images/GH-monitor-dashboard-highest-cpu-point-in-time.png" width="800"/>

9. Click the **In-flight executions Statement** tab to view actively executing SQL at the time of the CPU increase.

   <img src="images/GH-monitor-dashboard-cpu-inflight-sql.png" width="800"/>

   **Key metrics available for each in-flight statement:**

   | Column | Description |
   |---|---|
   | **SQL** | The SQL statement being executed |
   | **Statement execution time** | How long the statement has been running |
   | **Start time** | When the statement started |
   | **Rows read** | Number of rows scanned |
   | **Estimated query cost** | Optimizer's estimated cost |
   | **Peak sort used** | Peak sort memory consumed |
   | **WLM queue time** | Time spent waiting in the workload manager queue |

10. Select the **Shared sort memory anomaly detected (a)** from the Notifications section.

    <img src="images/GH-monitor-dashboard-shared-sort-anomaly.png" width="800"/>

11. Click the **Filter by notification button (c)** for the **Shared sort memory anomaly detected**.

    <img src="images/GH-monitor-dashboard-shared-sort-anomaly-filtered.png" width="800"/>

    The pink highlighted region indicates the period when the workload was actively running. The charts clearly show:

    | Chart | What You'll See |
    |---|---|
    | **Time spent** | Two distinct spikes of SQL execution activity |
    | **Resource utilization** | CPU rises sharply then returns to baseline; memory remains elevated |
    | **Throughput** | Bursts of statement execution during the active workload period |

12. Select the three vertical dots *(a)* to the right of one of the SQL statements and select **Details (b)**.

    <img src="images/GH-sql-select-details.png" width="800"/>

13. The **SQL details** page provides a full breakdown of the selected statement's execution context.

    <img src="images/GH-sql-details.png" width="800"/>

    **Execution metadata:**

    | Field | Value |
    |---|---|
    | Application handle | 56762 |
    | Activity ID | 1 |
    | UOW ID | 3 |
    | Entry time | Jun 6, 2026 3:55 PM |
    | Total time | 0:00.021 |
    | WLM queue time | 0.00% |
    | Threshold violations | 0 |

    **Analysis tabs:**

    | Tab | Description |
    |---|---|
    | **Explain Plan** | Visual execution plan for the statement |
    | **Locking** | Lock activity associated with the statement |
    | **I/O** | I/O activity during execution |
    | **Log** | Transaction log usage |
    | **Sort** | Sort memory consumption |
    | **Time spent** | Breakdown of time across execution phases |
    | **Additional Info** | Extended execution metadata |

14. Click the **Sort** tab to view sort memory details.

    <img src="images/GH-sql-details-sort.png" width="800"/>

    | Metric | Value |
    |---|---|
    | Total sorts | 0 |
    | Sort overflows | 0 |
    | Sort share heap currently allocated | 2478 |
    | Estimated sort share heap top pages | 8668 |
    | Sort share heap high watermark | 2478 |
    | Hash join overflows | 0 |
    | Hash group by overflows | 0 |

    > **ℹ️ Note:** Even though this individual statement shows no sort overflows, the sort share heap allocation (2478 pages, estimated top 8668) is significant. When many similar TPC-H queries run concurrently, the cumulative sort heap usage across all statements triggers the shared sort memory anomaly.

15. Click the **Explain Plan (a)** tab, then click **Open in Workbench (b)**.

    <img src="images/GH-sql-details-explain.png" width="800"/>

16. On the Workbench, click the **Explain (a)** icon.

    <img src="images/GH-sql-workbench-explain-icon.png" width="800"/>

17. Click **OK** to run the visual explain.

    <img src="images/GH-sql-workbench-run-explain.png" width="800"/>

18. Change the schema to `TPCH3` and click **OK (b)** to generate the explain.

    <img src="images/GH-sql-workbench-change-schema.png" width="800"/>

19. Review the visual explain plan.

    <img src="images/GH-sql-workbench-explain.png" width="800"/>

    **Execution plan breakdown:**

    | Step | Operator | Cost |
    |---|---|---|
    | 1 | Return | 9,570.68 |
    | 2 | Grpby (Group By) | 9,570.68 |
    | 3 | Grpby (Group By) | 9,570.68 |
    | 4 | Tbscan (Table Scan) | 9,570.64 |
    | S1 | LineItem — Tpch3 | — |

    **Properties for the selected node:**

    | Property | Value |
    |---|---|
    | Cumulative total cost | 9,570.68 |
    | Cumulative CPU cost | 15,917,137,920.00 |
    | Cumulative I/O cost | 4,185.00 |
    | Prep time | 19 milliseconds |
    | Statement heap size | 16,384 |

    The plan shows a full **table scan** on `TPCH3.LINEITEM` — confirming no suitable index exists for this query.

20. Click **Tune query** to open the AI Query Tuner.

    <img src="images/GH-tune-query.png" width="800"/>

21. Click **OK** on the **Select tuning activity to run** dialog.

    <img src="images/GH-tune-query-ok.png" width="800"/>

22. Click **Close** for the query tuning task.

    <img src="images/GH-tune-query-tuning-task-ok.png" width="800"/>

23. From the side menu, select **Workbench (a)**.

    <img src="images/GH-workbench-sidemenu.png" width="200"/>

24. In the Workbench, select **Query tuning report (a)**.

    <img src="images/GH-workbench-query-tuning-report.png" width="800"/>

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Jobs</h2>

You can use Db2 Genius Hub to create and schedule jobs.

> **📌 Informational Only:** This section is informational — there is a firewall port issue (SSH port 22) in the lab environment that prevents jobs from running. This will be addressed in a future release of Genius Hub.

1. From the side menu, select **Administration (e)**.

   <img src="images/GH-admin-sidemenu.png" width="200"/>

2. Under **Jobs**, click **Jobs**.

   <img src="images/GH-jobs-menu.png" width="800"/>

3. Click **Create job (a)**.

   <img src="images/GH-create-job.png" width="800"/>

4. In the **Define (a)** tab, enter a **Name (b)**, select **SQL script (c)**, and enter the following SQL in the **Job script text (d)** field:

   ```sql
   SELECT * FROM
      SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,
      SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,SYSIBM.TABLES,
      SYSIBM.TABLES,SYSIBM.TABLES
   ;
   ```

   > **⚠️ Caution:** This is a Cartesian product query designed to generate CPU load. Do not add more table references than shown — too many will overload the system.

   <img src="images/GH-create-job-define.png" width="800"/>

5. Scroll down and click **Next (a)**.

   <img src="images/GH-create-job-next.png" width="800"/>

6. In the **Select databases (a)** tab, select **Personal credential (b)** and select **`demo_col` (c)**. Click **Next (d)**.

   <img src="images/GH-create-job-database.png" width="800"/>

7. Review the summary and click **Finish (a)**.

   <img src="images/GH-create-job-summary.png" width="800"/>

8. A message confirms the job was created successfully.

   <img src="images/GH-job-created.png" width="800"/>

9. From the **Jobs** page, click the **3 dots (a)** on the right side of the job and select **Run with existing credentials (b)**.

   <img src="images/GH-job-run.png" width="800"/>

10. Wait until you see the alert **(a)** in the upper-right corner.

    <img src="images/GH-job-alert.png" width="800"/>

11. When the alert appears, stop the job to avoid excessive CPU consumption. Select your job **(a)** and click **Stop (b)**.

    <img src="images/GH-job-stop.png" width="800"/>

12. The **Stop job** window opens. Click **Stop (a)**.

    <img src="images/GH-job-stop-confirm.png" width="800"/>

13. Delete the job. Select your job **(a)** and click **Delete (b)**.

    <img src="images/GH-job-delete.png" width="800"/>

14. Return to the Monitor dashboard by clicking **Monitor (c)** from the side menu.

    <img src="images/GH-monitor-sidemenu.png" width="200"/>

15. Select the **CPU time (a)** alert. The alert details **(b)** are displayed.

    <img src="images/GH-alert-cpu-time.png" width="800"/>

16. Click **Work with Database Assistant (a)**. The Database Assistant opens on the right side. Review the recommendation.

    <img src="images/GH-alert-database-assistant.png" width="800"/>

17. **Write down the recommendation** from the Database Assistant.

18. You can also view the recommendation from the Notification Center. Click the **alert (a)** icon in the upper-right corner.

    <img src="images/GH-notification-center-icon.png" width="400"/>

19. The **Notification Center** summary window opens. Click **View notification center (a)**.

    <img src="images/GH-notification-center-summary.png" width="800"/>

20. The **Notification Center** window opens. Select the **CPU time (a)** alert and review the alert details **(b)** on the right side.

    <img src="images/GH-notification-center-detail.png" width="800"/>

    From the recommendation you can view the access plan or tune the statement — capabilities covered in the Visual Explain and Query Tuning sections.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Next Steps</h2>

This completes the Monitoring Databases section.

**[→ Proceed to Section 5: Agentic AI Simulator](05-agentic-ai-simulator.md)**

---
