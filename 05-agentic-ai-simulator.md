<h1 style="padding-left:16px; border-left:8px solid #378ADD;">Agentic AI Simulator</h1>

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Overview</h2>

The Db2 Agentic AI Simulator is a separate, as-is application provided for hands-on lab tasks. It allows you to trigger events that demonstrate how the Db2 agentic AI service detects and solves problems.

**The application includes:**

| Feature | Description |
|---|---|
| **Text2SQL** | Natural Language to SQL — load a dataset and ask questions in plain English |
| **WLM Queuing** | Constrain sort memory to trigger adaptive workload manager queuing |
| **Query Spilling** | Trigger sort spill-to-disk events |
| **Locking** | Create locking contention between sessions |
| **Space Management** | Test tablespace space management issues |
| **Blocking** | Demonstrate transaction blocking scenarios |
| **Runstats** | Run statistics collection operations |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Accessing the Simulator</h2>

Open a browser and navigate to:

```
http://localhost:3000
```

This page contains the three TechXchange exercises:

1. [Space Management with AI](#space-management) — find and reclaim wasted space with the AI assistant.
2. [WLM Queuing](#wlm-queuing) — diagnose and fix a workload manager queuing problem.
3. [Text2SQL](#text2sql) — turn a plain-English question into Db2 SQL with the AI assistant.

---

<h2 id="space-management" style="padding-left:14px; border-left:6px solid #1D9E75;">Space Management with AI</h2>

> **Persona:** DBA

**The task.** A tablespace is filling up. Find which schema is using the space, find the tables and indexes in it that need a REORG, and fix them. You do all of it by asking questions in plain language.

**The story.** Space is tight and you need to know where it went and what can be safely recovered. Instead of writing catalog queries and reading REORGCHK output by hand, you ask the assistant in plain language. It shows where the space is, tells you which objects are worth reorganizing and why, and gives you the exact commands in the right order. When a change is needed it asks for your approval before it runs anything, then re-checks the result so you can see what changed.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 0 — Set Up the Simulators</h3>

Before you ask any questions, open the simulator, load a data set and run the space-management scenarios so the database has something to analyze.

1. Open the Agentic AI Simulator. It runs on the lab VM, so open it in **Firefox inside the Guacamole desktop**, not in a browser on your own laptop.

   1. In the Guacamole desktop, switch to **Firefox**. If you cannot see it, click **Activities** (top-left corner) and click **Firefox** in the dash at the bottom of the screen.
   2. Click the **+** button in the Firefox tab bar to open a new tab.
   3. In the address bar, type `http://localhost:3000` and press **Enter**.

   > **ℹ️ Tip:** Keep the Lab Guide in one tab and the simulator in another, and click the tabs to switch between them.

2. Connect the simulator to the `demo_row` database. The space-management tasks use the row-organized database, because REORG applies to row-organized tables. Click **Connect DB** in the top-right corner.

   <img src="images/SIM-connect-DB.png" width="800"/>

3. In the **Connect Database** window, enter these details:

   | Field | Value |
   |---|---|
   | Host | `localhost` |
   | Database | `demo_row` |
   | User | `db2demo` |
   | Password | `Db2ghPassw0rd#1` |
   | Port | `25010` |

   Leave **Enable SSL Connection** unchecked.

4. Click **Test Connection**. When the connection works, a green **Connected** badge appears at the top right. Do not continue until it is green.

   <img src="images/SIM-db-creds.png" width="500"/>

5. You do not need to load data. The `TPCH1`, `TPCH2` and `TPCH3` schemas are already loaded in `demo_row`, so skip **Load data** under **Performance Simulators**.

6. Under **Space Management**, click **Run scenarios** next to **Rowstore REORGCHK scenarios**.

7. Select all scenarios and click **Run selected**.

   <img src="images/SM-step0-3.png" width="800"/>

   <img src="images/SM-step0-4.png" width="400"/>

8. In the **Run REORGCHK Scenarios** dialog, enter `TPCH1` as the **Schema Name** and click **Run Scenarios**.

   <img src="images/gh-reorgchk-schema-name.png" width="500"/>

9. Check that none of the simulators shows an error in the UI before you start asking questions.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 1 — Start with a Broad Question: Disk Space by Schema</h3>

You do not need to know any schema or table names up front. Start broad and let the assistant show you the landscape.

First, open the Assistant in Genius Hub:

1. Click the **Agentic AI Assistant** menu item.

   <img src="images/GH-agentic-ai-assistant-menu.png" width="200"/>

2. Expand the AI Assistant by clicking the expand button.

   <img src="images/GH-agentic-ai-assistant-expanded.png" width="800"/>

3. Read and close the **Legal Disclaimer**.

   <img src="images/GH-agentic-ai-assistant-legal-close.png" width="800"/>

4. In the **Choose Database** field, choose `demo_row`.

   <img src="images/GH-agentic-ai-assistant-choose-db.png" width="800"/>

Then ask:

**You ask:**

```
Break down disk space usage by schema
```

<img src="images/SM-step1-1.png" width="600"/>

<img src="images/SM-step1-2.png" width="600"/>

- **Space by schema.** One row per schema in a clean table, so the biggest consumers stand out straight away.
- **Tables in each schema.** General information about which tables exist, so you know what you are looking at before you drill down.
- **A proactive offer.** The assistant offers to run REORGCHK on the `SIMULATOR` schema to confirm which of its tables need a REORG. You did not ask for this; it is the natural next step.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 2 — Focus on One Schema: the Largest Table in SIMULATOR</h3>

For this example we focus on a schema called `SIMULATOR`. Explore it by asking for its largest table.

**You ask:**

```
What is the largest table in the SIMULATOR schema?
```

<img src="images/SM-step2-1.png" width="600"/>

- **Sorted by size.** The answer lists the tables with the largest first, followed by the rest in descending order.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 3 — Analyze the Schema for Space Reclamation</h3>

Now ask the assistant to analyze the whole schema. The response is thorough: which tables need a REORG, which indexes need a REORG, and the command to run for each one.

**You ask:**

```
Analyze schema SIMULATOR for space reclamation
```

<img src="images/SM-step3-1.png" width="600"/>

<img src="images/SM-step3-2.png" width="600"/>

<img src="images/SM-step3-3.png" width="600"/>

- **Tables requiring REORG.** Each table with the REORGCHK indicator it violated.
- **Indexes requiring REORG.** Listed separately from the tables.
- **Commands.** The command to run for each table and index.

> **Tip:** When several tables need a REORG, the index section may be skipped to keep the answer short. You can ask for indexes at any time, for the whole schema or for one specific table or index. Step 4 shows how.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 4 — Ask About Indexes Specifically</h3>

Ask for the indexes that need reorganization. The assistant answers with a detailed table again.

**You ask:**

```
Which indexes in schema SIMULATOR need reorganization?
```

<img src="images/SM-step4-1.png" width="600"/>

<img src="images/SM-step4-2.png" width="600"/>

- **Indicator values.** The REORGCHK indicators (F4 to F8) for each index, so you can see exactly why it was flagged.
- **REORG commands.** One ready-to-run command per index.
- **Event monitor reminder.** The assistant reminds you that the `RTMON_EVMON_UTILITY` event monitor is not enabled. Enable it in Db2 Genius Hub to track REORG history.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 5 — Get Step-by-Step Instructions for a Single Table</h3>

Pick one table from the list and ask how to fix it. The assistant gives you the whole procedure.

**You ask:**

```
Give me step-by-step instructions to reorganize SIMULATOR.REORG_F1_TEST
```

<img src="images/SM-step5-1.png" width="600"/>

<img src="images/SM-step5-2.png" width="600"/>

- **Run the REORG.** The command for this table.
- **Run RUNSTATS.** Updates the table statistics after the REORG.
- **Check the statistics.** A final check that the statistics were updated.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 6 — Let the Assistant Run It, with Your Approval</h3>

For an online REORG such as an INPLACE REORG, you do not have to copy and paste commands. Ask the assistant to do it. It asks for your approval before each step, runs what you approve, and finishes by reporting that the REORG was successful.

**You ask:**

```
Can you please run the reorg for me?
```

<img src="images/SM-step6-1.png" width="600"/>

<img src="images/SM-step6-2.png" width="600"/>

<img src="images/SM-step6-3.png" width="600"/>

<img src="images/SM-step6-4.png" width="600"/>

<img src="images/SM-step6-5.png" width="600"/>

- **Approval card.** Shows the exact command with **Approve** and **Reject** buttons. Nothing runs until you approve it.
- **Each step from the plan.** The assistant works through the steps it listed in Step 5, asking for approval each time.
- **Final result.** The assistant reports that the REORG was successful.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 7 — Check Again: the F1 Issue Is Gone</h3>

Ask the assistant to check the table again. It confirms that the F1 indicator that flagged the table is no longer a problem.

**You ask:**

```
Check again whether SIMULATOR.REORG_F1_TEST still needs a reorg
```

<img src="images/SM-step7-1.png" width="600"/>

- **F1 is clear.** The overflow indicator no longer flags the table.

---

🎯 **TechXchange Quick Path — Step 6 of 8:** **[← AI Configuration and Event Monitors](02-05-ai-configuration.md)** &nbsp;&nbsp;|&nbsp;&nbsp; **[→ WLM Queuing](#wlm-queuing)**

---

<h2 id="wlm-queuing" style="padding-left:14px; border-left:6px solid #1D9E75;">Troubleshooting WLM Queuing</h2>

Queries are accumulating in the Db2 Workload Manager (WLM) admission queue and are unable to begin execution, delaying workload processing. Diagnosing the root cause traditionally requires manually querying Db2 monitoring interfaces and investigating resource constraints, such as thread limits, sort-memory limits, and service-class configurations.

With the IBM Db2 Genius Hub AI assistant, you can troubleshoot the bottleneck simply by asking questions in plain English. The assistant autonomously investigates the active workload, pinpoints the constrained resource and any recent configuration changes responsible, identifies blocking queries, and presents targeted remediation options to clear the queue and restore query execution.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 0 — Simulate the Issue</h3>

1. In the demo UI, click **Connect DB (1)** and enter your database connection details. Once connected, navigate to the **Simulator** tab **(2)**.

   <img src="images/WLM-step0-1.png" width="800"/>

2. If TPCH data is not yet loaded in your database, load it first. (If you already loaded TPCH in the Space Management exercise, skip to step 6.)

   Click **Load Data**.

   <img src="images/WLM-step0-2.png" width="800"/>

3. Select the **1 GB** dataset **(1)** and click **Continue (2)**.

   <img src="images/WLM-step0-3.png" width="800"/>

4. Enter the schema name where the TPCH data should be loaded, then wait for the load to complete.

   > **⏳ Note:** This may take a while.

   <img src="images/WLM-step0-4.png" width="800"/>

5. Once TPCH is loaded, click the **WLM Queuing** dropdown. If you are running on a non-warehouse Db2 instance, review the prerequisite setup steps shown before creating the database you plan to use for the simulation.

   <img src="images/WLM-step0-5.png" width="800"/>

6. Scroll down to find the **Sort Memory** simulator section and click **Run Scenario**.

   <img src="images/WLM-step0-6.png" width="800"/>

7. Enter the schema name where the TPCH data was loaded and click **Run Simulation**.

   <img src="images/WLM-step0-7.png" width="800"/>

8. Monitor the logs below the simulator. Once the logs show that queuing has started, you can proceed to Genius Hub.

   <img src="images/WLM-step0-8.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 1 — Navigate to the Monitor Tab</h3>

In the Genius Hub left-hand navigation menu, locate and click **Monitor**.

<img src="images/WLM-step1-1.png" width="200"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 2 — Select the Database and Observe Queued Queries</h3>

1. On the Monitor page, click the **Database** dropdown at the top left and select the database you want to investigate (for example `DEMO_COL`).

   <img src="images/WLM-step2-1.png" width="800"/>

2. Scroll down to the tabbed section and click the **In-flight executions** tab to see the currently running queries.

   <img src="images/WLM-step2-2.png" width="800"/>

3. Inspect the **Activity state** column. You will see multiple queries with a state of **QUEUED** and non-zero WLM queue time values. They are being held by WLM admission control and are not executing.

   <img src="images/WLM-step2-3.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 3 — Open the Agentic AI Assistant</h3>

Click the **Agentic AI Assistant** icon in the top-right corner of the Genius Hub toolbar. The assistant opens.

<img src="images/WLM-step3-1.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 4 — Select the Database in the AI Assistant</h3>

Click the **Choose Database** dropdown at the bottom of the chat window and select the database you want to investigate (for example `DEMO_COL`). This scopes all AI analysis and actions to that database.

<img src="images/WLM-step4-1.png" width="600"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 5 — Ask Why Queries Are Queuing</h3>

In the chat input box, ask:

```
Why are the queries in queue?
```

The assistant autonomously runs its investigation. Observe the **Todo List** as it works through each step: triaging the issue, identifying the domain, and delivering a root cause with evidence.

<img src="images/WLM-step5-1.png" width="600"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 6 — Review the Root Cause and Resolution Steps</h3>

1. Scroll down in the response to review the **root cause**. The assistant identifies the specific resource constraint causing queuing, along with a confidence rating and supporting evidence.

2. Continue scrolling to see the **Resolution** steps, including immediate remediation actions such as reverting a configuration change or cancelling a blocking query, and long-term recommendations.

   <img src="images/WLM-step6-1.png" width="600"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 7 — Apply the Configuration Change and Approve</h3>

1. In the chat input, ask the assistant to revert the configuration change:

   ```
   Revert SHEAPTHRES_SHR to its previous value
   ```

2. The assistant presents a **Database Configuration Update Request** showing the parameter (`SHEAPTHRES_SHR`), the new value (`556959`), the current value (`50000`), and the exact SQL command to be executed. Review the details carefully.

   <img src="images/WLM-step7-1.png" width="600"/>

3. When satisfied, click **Approve** to authorize the change.

   > **ℹ️ Note:** Explicit human approval is required before any database configuration change is applied, ensuring you remain in full control.

   <img src="images/WLM-step7-2.png" width="600"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 8 — Verify the Configuration Was Updated and Queuing Is Resolved</h3>

1. After approving, verify that the response confirms the configuration change was successfully applied and is now in effect.

   <img src="images/WLM-step8-1.png" width="600"/>

2. Ask the assistant to confirm whether the queuing issue is now resolved:

   ```
   Check if queuing issue is resolved?
   ```

   Verify that the response confirms the admission queue is now empty and all previously queued queries have been admitted.

   <img src="images/WLM-step8-2.png" width="600"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 9 — Check In-Flight Executions Again</h3>

1. Return to the **Monitor** tab and click the **In-flight executions** tab again.

2. Check the **Activity state** column. All queries should now be in an **EXECUTING** state.

   <img src="images/WLM-step9-1.png" width="800"/>

> ✅ **Task complete.** You have successfully diagnosed and resolved WLM queuing using the Agentic AI Assistant in IBM Db2 Genius Hub.

| Action | What You Did |
|---|---|
| **Observed the issue** | Used Monitor → In-flight executions to identify queries stuck in QUEUED state with growing WLM queue times |
| **Engaged the AI assistant** | Opened the Agentic AI Assistant, selected the database, and asked why queries were queuing |
| **Identified root cause** | The assistant diagnosed the specific resource constraint causing WLM to hold queries, including the configuration change responsible |
| **Applied the fix** | Asked the assistant to revert `SHEAPTHRES_SHR` to its previous value; reviewed and approved the configuration change |
| **Verified resolution** | Confirmed the configuration was updated, then returned to Monitor to verify all queries moved to EXECUTING state |

---

🎯 **TechXchange Quick Path — Step 7 of 8:** **[← Space Management with AI](#space-management)** &nbsp;&nbsp;|&nbsp;&nbsp; **[→ Text2SQL](#text2sql)**

---

<h2 id="text2sql" style="padding-left:14px; border-left:6px solid #1D9E75;">Text2SQL — Natural Language to SQL</h2>

Use the Db2 Genius Hub AI assistant to turn plain-English questions into production-ready Db2 SQL queries. No SQL knowledge is required.

**The task.** Load the Cricket Statistics dataset, switch the assistant to **Generate SQL** mode, and ask one complex analytical question about the top run-scorers in three cricket formats. Review the SQL the agent builds, open it in the SQL Workbench, and run it.

**The story.** The question needs data from several tables, a ranking, and a comparison against country averages. Writing that by hand means finding the right tables and columns first. Instead, the assistant works out a plan, reads the schema, tells you about any gaps it finds, and hands you the finished query.

> **ℹ️ Note:** In Generate SQL mode the assistant writes and explains the SQL but does **not** run it. You decide when to run it, from the SQL Workbench.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 0 — Load the Cricket Statistics Dataset</h3>

Before you ask any questions, load a dataset into Db2. Text2SQL needs tables to read.

1. In the Agentic AI Simulator at `http://localhost:3000`, click the **Simulator** tab **(b)**. Check that the green **Connected** badge **(a)** is showing. Data can only be loaded when it is green.

2. Under the **Text2SQL — Natural Language to SQL** card, three datasets are available:

   | Dataset | What it contains |
   |---|---|
   | **Cricket Statistics (c)** | Batting, bowling, and fielding records. This is the dataset used in this exercise. |
   | **Supply Chain Data (d)** | Products, inventory, orders, and shipments. |
   | **TPC-H Benchmark (e)** | Suppliers, customers, orders, and parts, for complex analytical queries. |

3. Click **Load Data (f)** next to **Cricket Statistics**.

   <img src="images/T2S-step0-1.png" width="800"/>

4. Wait until the button changes to a green **Loaded** badge **(a)** with a **Reload Data** button next to it. Use **Reload Data** at any time to refresh the tables.

5. Expand the dataset card to see **Sample Queries to Test This Dataset**. The **Copy query** icon **(b)** on each row copies that question to your clipboard so you can paste it into the chat.

   <img src="images/T2S-step0-2.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 1 — Open the AI Assistant and Select the Generate SQL Tool</h3>

Open the Agentic AI Assistant in Genius Hub, the same way as in the Space Management exercise. Before you ask a question, tell the assistant which tool to use.

1. In the toolbar at the bottom of the assistant, click the **Tools** button **(a)**. It sits next to the database selector.

2. In the tool picker, choose **Generate SQL (b)**. The option is labelled *"Agent does not execute code"*.

   <img src="images/T2S-step1-1.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 2 — Confirm Text to SQL Mode Is Active</h3>

- **Confirmation message.** The chat shows *"Text to SQL mode has been activated."* The assistant is ready to turn your questions into SQL.
- **Generate SQL chip.** The active tool now shows as a chip (`Generate SQL ×`) in the toolbar. Click the `×` at any time to return to general assistant mode.

<img src="images/T2S-step2-1.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 3 — Ask a Complex Question and Watch the Agent Plan</h3>

Paste the question below into the chat input and send it.

**You ask:**

```
For the top 5 run-scorers in each format (ODI, Test, T20), analyze their consistency by calculating the ratio of centuries to matches played. Show player name, country, format, total runs, matches, centuries, consistency ratio, and compare this ratio to the average consistency ratio of all players from their country in that format who have played at least 50 matches. Identify which players exceed their country's average.
```

The assistant builds a structured **Todo List** and starts working through it, one step at a time.

<img src="images/T2S-step3-1.png" width="800"/>

- **Todo List header (a).** Shows how many steps are complete. Here, 2 of 9.
- **Completed step (b).** A green check marks a finished step. Step 2, *Retrieve column metadata for all identified cricket tables*, is done.
- **In-progress step (c).** A spinning icon marks the step that is running now.
- **Queued steps (d).** The remaining steps wait their turn. Each step's output feeds the next one.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 4 — Follow the Agent's Schema Analysis</h3>

At 4 of 9 steps, the agent stops to look at the schema more closely. It tells you what it found: the batting tables do not have a country column. It then explains how it plans to deal with that before it writes any SQL.

<img src="images/T2S-step4-1.png" width="800"/>

- **Reasoning note (a).** *"I notice that the cricket batting tables don't have a country column. Let me check if there's a separate table that links players to countries…"* The agent adapts its plan to the schema it finds, instead of guessing.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 5 — Review the Generated SQL</h3>

When all 9 steps are complete, the assistant shows the SQL in a highlighted code block with a note and a short explanation.

<img src="images/T2S-step5-1.png" width="800"/>

- **SQL code block (a).** A 74-line Db2 query. It starts with a `WITH all_formats AS (…)` common table expression that combines the ODI, Test, and T20 batting tables. The toolbar has copy and open-in-workbench icons.
- **NOTE (b).** The assistant says plainly that the batting tables have no country column. Read this before you run the query so you know what to expect.
- **Query logic summary (c).** Three bullets explain the approach: `UNION ALL` merges the three batting tables, `ROW_NUMBER()` partitioned by format ranks the top 5 run-scorers, and a `LEFT JOIN` with a `CASE` expression compares each player to the country average.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 6 — Expand the Code Block</h3>

The code block shows a short preview. Click **Show more (a)** to see the whole query.

<img src="images/T2S-step6-1.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 7 — Read the Full Query</h3>

With the block expanded, you can read all 74 lines. The first section selects from `DB2INST1.ODI_BATTING`, the second from `DB2INST1.TEST_BATTING`, and the third from `DB2INST1.T20_BATTING`.

<img src="images/T2S-step7-1.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 8 — Open the Query in the SQL Workbench</h3>

When you are happy with the SQL, click **Open in workbench (a)**, the first icon in the code block toolbar. The SQL Workbench opens in a new tab with the query already loaded. You do not need to copy and paste.

<img src="images/T2S-step8-1.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 9 — Or Copy the SQL to the Clipboard</h3>

To use the SQL somewhere else, such as another SQL editor, notebook, or IDE, click **Copy to clipboard (a)**, the second icon. This copies the full 74-line query so you can change it before you run it.

<img src="images/T2S-step9-1.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 10 — Check the Query in the Workbench</h3>

The SQL Workbench shows the generated query in the editor, and the AI assistant panel stays open on the right.

<img src="images/T2S-step10-1.png" width="800"/>

- **SQL editor (a).** The complete 74-line query, with syntax highlighting. Check that the database selector shows the database you expect.
- **AI Assistant panel (b).** The chat, including the agent's notes and explanation, stays visible so you can compare it with the query while you edit.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 11 — Run the Query</h3>

Click the arrow **(a)** next to **Run all** to see the run options. For a single statement like this one, **Run all** and **Run selected** give the same result.

<img src="images/T2S-step11-1.png" width="800"/>

- **Run selected (b).** Runs only the highlighted text.
- **Other options.** **Run from Cursor** runs from the cursor position downwards. **Schedule** runs the statement later. **Export as csv** and **Export as xlsx** save the results.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 12 — Review the Results</h3>

The result panel opens below the editor with the 15 rows the query returned. The columns are `PLAYER`, `COUNTRY`, `FORMAT`, `TOTAL_RUNS`, `MATCHES`, `CENTURIES`, and `CONSISTENCY_RATIO`.

<img src="images/T2S-step12-1.png" width="800"/>

- **Result panel (a).** Shows *Total: 15* and a green success indicator. For example: *SR Tendulkar (INDIA), 18,426 ODI runs, 463 matches, 49 centuries*.

> **ℹ️ Note:** The `COUNTRY` column shows `<country>` placeholder values. This is expected. The assistant told you in Step 5 that the batting tables do not contain a country column.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 13 — If the Agent Asks Which Schema to Use</h3>

If the same table name exists in more than one schema, the agent pauses and asks which one you mean. It does not guess.

<img src="images/T2S-step13-1.png" width="800"/>

- **Paused step (a).** The *Design CTE structure* step shows a spinning icon. The agent has stopped because it cannot resolve the ambiguity on its own.
- **Ambiguous Table Name Detected (b).** *"The table name 'ODI_BATTING' exists in multiple schemas: CRICKER, DB2INST1. Please specify which schema you want to use."*

> **ℹ️ Note:** This prompt only appears when the same table name exists in more than one accessible schema. If your database has a single schema, the step is skipped.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 14 — Answer with the Schema</h3>

Type your answer in the chat and send it.

**You answer:**

```
I want to use DB2INST1 schema.
```

<img src="images/T2S-step14-1.png" width="800"/>

- **Schema selection (a).** The agent carries on with the rest of its Todo List. It adds the `DB2INST1.` prefix to every table (for example `DB2INST1.ODI_BATTING`) and produces a fully qualified SQL statement that is ready to run.

> ✅ **Task complete.** You have used the Agentic AI Assistant in IBM Db2 Genius Hub to turn a complex plain-English question into working Db2 SQL.

| Action | What You Did |
|---|---|
| **Loaded the data** | Loaded the Cricket Statistics dataset from the Simulator tab |
| **Switched mode** | Selected the **Generate SQL** tool in the AI assistant |
| **Asked the question** | Asked for the consistency of the top run-scorers in ODI, Test, and T20 |
| **Reviewed the plan** | Followed the agent's Todo List, its schema analysis, and the gap it reported |
| **Used the SQL** | Opened the query in the SQL Workbench, ran it, and reviewed the results |

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">More Questions to Try</h3>

If you finish early, paste any of these into the Text2SQL chat with the Cricket Statistics dataset loaded. Each one tests a different analytical skill.

**1. Multi-format country analysis**

```
Which countries have players in all three formats (ODI, Test, T20) with batting averages above 40, showing the country and count of such players per format?
```

**2. Top bowlers with tournament history**

```
List the top 5 Test bowlers by wickets who have also played in tournaments, showing their bowling statistics and the tournaments their country won.
```

**3. Centuries-to-half-centuries ratio ranking**

```
Calculate the ratio of centuries to half-centuries for ODI batsmen who have scored more than 8000 runs, and rank them by this ratio in descending order.
```

---

> ✅ **This is the end of the lab.**

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Summary</h2>

In this lab, you:

| Section | What You Did |
|---|---|
| **Setup** | Connected to the lab VM, started Genius Hub services, and configured the environment |
| **Basics** | Explored the Genius Hub UI, configured event monitors, and set up AI configuration |
| **SQL Workbench** | Created tables, ran queries, used Visual Explain, and applied AI Query Tuner recommendations |
| **Monitoring** | Analyzed CPU anomalies, generated reports, used the Agentic AI Assistant, and configured alerts |
| **Agentic AI Simulator** | Used the AI assistant to find and reclaim wasted tablespace space with approval at each step, then triggered a WLM sort memory queuing scenario, used the AI assistant to diagnose the root cause, approved a configuration revert, and verified all queries returned to EXECUTING state. Finally, loaded the Cricket Statistics dataset, used Generate SQL mode to turn a complex plain-English question into Db2 SQL, and ran it in the SQL Workbench |

---

🎯 **TechXchange Quick Path — Step 8 of 8:** **[← Text2SQL](#text2sql)** &nbsp;&nbsp;|&nbsp;&nbsp; ✅ End of the Quick Path

**[← Return to Introduction](00-introduction.md)**

---
