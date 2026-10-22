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

This page contains the two TechXchange exercises:

1. [Space Management with AI](#space-management) — find and reclaim wasted space with the AI assistant.
2. [WLM Queuing](#wlm-queuing) — diagnose and fix a workload manager queuing problem.

---

<h2 id="space-management" style="padding-left:14px; border-left:6px solid #1D9E75;">Space Management with AI</h2>

> **Persona:** DBA

**The task.** A tablespace is filling up. Find which schema is using the space, find the tables and indexes in it that need a REORG, and fix them. You do all of it by asking questions in plain language.

**The story.** Space is tight and you need to know where it went and what can be safely recovered. Instead of writing catalog queries and reading REORGCHK output by hand, you ask the assistant in plain language. It shows where the space is, tells you which objects are worth reorganizing and why, and gives you the exact commands in the right order. When a change is needed it asks for your approval before it runs anything, then re-checks the result so you can see what changed.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 0 — Set Up the Simulators</h3>

Before you ask any questions, load a data set and run the space-management scenarios so the database has something to analyze.

1. Under **Performance Simulators**, click **Load data** next to the **TPCH** dataset.

2. Choose the **SF 1.0 (Huge)** dataset.

   <img src="images/SM-step0-1.png" width="800"/>

   <img src="images/SM-step0-2.png" width="500"/>

3. Under **Space Management**, click **Run scenarios** next to **Rowstore REORGCHK scenarios**.

4. Select all scenarios and click **Run selected**.

   <img src="images/SM-step0-3.png" width="800"/>

   <img src="images/SM-step0-4.png" width="400"/>

5. Check that none of the simulators shows an error in the UI before you start asking questions.

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

4. In the **Choose Database** field, choose `demo_col`.

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

🎯 **TechXchange Quick Path — Step 6 of 7:** **[← AI Configuration and Event Monitors](02-05-ai-configuration.md)** &nbsp;&nbsp;|&nbsp;&nbsp; **[→ WLM Queuing](#wlm-queuing)**

---

<h2 id="wlm-queuing" style="padding-left:14px; border-left:6px solid #1D9E75;">Sort Memory Queuing Simulation</h2>

This simulation constrains sort memory resources at the database level to trigger queuing by the adaptive workload manager.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 1 — Establish Database Connection</h3>

1. Click the top right icon **Connect DB** to connect to the `DEMO_COL` database.

   <img src="images/SIM-connect-icon.png" width="800"/>

2. Enter the database credentials and click **Connect**.

   <img src="images/SIM-db-creds.png" width="800"/>

3. Confirm the connection is active — the **Connect DB** icon turns green.

   <img src="images/SIM-db-connected.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 2 — Load TPCH Dataset</h3>

<!-- TODO: confirm whether attendees who already loaded TPCH in the Space Management exercise can skip this step. Then replace this comment with a visible note. -->

4. In the TPCH Dataset section, click **Load Data**.

   <img src="images/SIM-tpch-load.png" width="800"/>

5. Select the dataset size **SF 0.1 (Medium - ~600K rows) (a)** and click **Continue (b)**.

   <img src="images/SIM-tpch-load-medium.png" width="800"/>

6. Enter schema `DEMO` **(a)** and click **Load Data (b)**.

   <img src="images/SIM-tpch-data-load-schema.png" width="400"/>

7. Wait while the status shows **Loading**.

   <img src="images/SIM-tpch-loading-data.png" width="800"/>

   > **⏳ Note:** This may take a few minutes depending on the size of the dataset.

8. When the load completes, the button changes to **Reload Data**.

   <img src="images/SIM-tpch-data-loaded.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 3 — Run the WLM Sort Scenario</h3>

9. Click **WLM Queuing (a)** to open the WLM Sort Memory scenario.

   <img src="images/SIM-click-wlm.png" width="800"/>

10. Click **Run Scenario (a)** to simulate the SORT issue.

    <img src="images/SIM-wlm-sort-run.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 4 — Monitor Inflight Queries in Genius Hub</h3>

1. In **Genius Hub**, click **Monitor (a)** in the side menu.

   <img src="images/SIM-monitor-side-menu.png" width="200"/>

2. Make sure `DEMO_COL` is selected.

   <img src="images/SIM-wlm-sort-db-select.png" width="800"/>

3. Scroll down and click **Inflight execution statement (a)**. Notice the queries are queuing.

   <img src="images/SIM-wlm-sort-inflight-queued.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 5 — Ask Why Queries Are Queuing</h3>

1. Click **Agentic AI (a)** in the side menu and expand the **Assistant** window **(b)**.

   <img src="images/SIM-chatbot-expand.png" width="800"/>

2. Close the Disclaimer.

3. Select the database `DEMO_COL` in the AI chatbox **(a)**.

   <img src="images/SIM-select-db-chatbot.png" width="400"/>

4. In the chat input, enter:

   ```
   Why are the queries in queue?
   ```

5. Watch the **Todo List** as the assistant autonomously works through each step — triaging the issue, identifying the domain, and delivering a root cause with evidence.

   <img src="images/SIM-queuing-question-1-results.png" width="400"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 6 — Review Root Cause and Resolution Steps</h3>

1. Scroll down in the response to review the **root cause**. The assistant identifies the specific resource constraint causing queuing, with a confidence rating and supporting evidence.

2. Continue scrolling to see the **Resolution** steps — including immediate remediation actions (such as reverting a configuration change) and long-term recommendations.

   <img src="images/SIM-what-has-changed.png" width="400"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 7 — Apply the Fix and Approve</h3>

1. Ask the assistant to revert the configuration change:

   ```
   Revert SHEAPTHRES_SHR to its previous value
   ```

2. The assistant presents a **Database Configuration Update Request** showing:
   - The parameter (`SHEAPTHRES_SHR`)
   - The new value to be applied
   - The current (constrained) value
   - The exact SQL command to be executed

   Review the details carefully.

   <img src="images/SIM-generate-revert-commands.png" width="400"/>

3. When satisfied, click **Approve** to authorize the change.

   > **ℹ️ Note:** Explicit human approval is required before any database configuration change is applied — you remain in full control.

   <img src="images/SIM-copy-commands.png" width="400"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 8 — Verify the Fix</h3>

1. After approving, verify that the assistant confirms the configuration change was successfully applied.

2. Ask the assistant to confirm the queuing is resolved:

   ```
   Check if queuing issue is resolved?
   ```

   Verify that the response confirms the admission queue is now empty and all previously queued queries have been admitted.

   <img src="images/SIM-revert-commands-finished.png" width="400"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 9 — Check In-Flight Executions</h3>

1. Return to the **Monitor** tab and click **In-flight executions** again.

2. Check the **Activity state** column — all queries should now show **EXECUTING** status.

   <img src="images/SIM-revert-applied-executing.png" width="400"/>

3. Close the Agentic AI Assistant.

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
| **Agentic AI Simulator** | Used the AI assistant to find and reclaim wasted tablespace space with approval at each step, then triggered a WLM sort memory queuing scenario, used the AI assistant to diagnose the root cause, approved a configuration revert, and verified all queries returned to EXECUTING state |

---

🎯 **TechXchange Quick Path — Step 7 of 7:** **[← Space Management with AI](#space-management)** &nbsp;&nbsp;|&nbsp;&nbsp; ✅ End of the Quick Path

**[← Return to Introduction](00-introduction.md)**

---
