<h1 style="padding-left:16px; border-left:8px solid #378ADD;">Section 3 — SQL Workbench</h1>

You can use the Workbench to run SQL statements, generate Visual Explains, tune queries, run What-If Analysis, and run Impact Analysis reports.

> **⚠️ Prerequisite:** The Activity Event Monitor must be enabled for the Impact Analysis report. Complete [Section 2 — Turning on Event Monitors](02-basics.md#turning-on-event-monitors) before proceeding.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">SQL Editor</h2>

1. From the side menu, select **SQL Workbench (a)**.

   <img src="images/WB-side-menu.png" width="200"/>

2. The Workbench window opens. Create a new tab by clicking **+ (b)**.

   <img src="images/WB-new-tab.png" width="800"/>

There are several ways to create a table in Db2 Genius Hub:

| Method | Description |
|---|---|
| **Smart SQL Editor** | Generate a CREATE statement via the table list items option |
| **Manual Entry** | Type the command directly in the SQL editor |

For this lab, we will use manual entry.

<img src="images/WB-smart-table-editor.png" width="800"/>

> *(a) Database &nbsp;&nbsp; (b) Schema &nbsp;&nbsp; (c) List table items &nbsp;&nbsp; (d) Create table*

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Create a Table and Insert Data</h3>

3. Use the new tab to create a table and insert the first rows using the following SQL:

   ```sql
   CREATE TABLE DB2DEMO.MYTABLE (
      CODE    INTEGER      NOT NULL,
      NAME    VARCHAR(30),
      SPEAKER VARCHAR(30),
      GRADE   INTEGER
   ) organize by row;

   INSERT INTO DB2DEMO.MYTABLE VALUES (2512, 'Db2 Genius Hub', 'Shes', 10);
   INSERT INTO DB2DEMO.MYTABLE VALUES (2512, 'Db2 Genius Hub', 'Cintia', 10);
   ```

4. Click **Run all (a)**.

   <img src="images/WB-run-all.png" width="800"/>

5. Check the execution results at the **lower part (b)** of the page.

   <img src="images/WB-execution-results.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Explore Table Details</h3>

6. Reload the object list to see your new table:

   **(a)** Click `demo_col` → **(b)** Click the three vertical dots → **(c)** Select **Reload items**

   <img src="images/WB-refresh-objects.png" width="800"/>

7. `MYTABLE` should now be displayed.

   <img src="images/WB-mytable-reloaded.png" width="800"/>

8. This is the tables list view for the `DB2DEMO` schema in the `demo_row` database. Selecting `MYTABLE` activates the action toolbar with the following options:

   | Action | Description |
   |---|---|
   | Add column | Add a new column to the table |
   | Generate DDL | Generate the CREATE TABLE statement |
   | Access control | Manage table access |
   | Update statistics | Run RUNSTATS on the table |
   | Drop | Delete the table |

   <img src="images/WB-table-options.png" width="800"/>

9. Select **`MYTABLE` (a)** to view the details panel.

   <img src="images/WB-select-MYTABLE-details.png" width="800"/>

   The details panel includes the following tabs:

   | Tab | Description |
   |---|---|
   | **Columns** | Column definitions and data types |
   | **Data preview** | Sample rows from the table |
   | **Properties** | Tablespace, owner, and creation details |
   | **Dependencies** | Objects that depend on this table |
   | **Statistics** | Current table statistics |

   <img src="images/WB-mytable-columns.png" width="800"/>
   <img src="images/WB-mytable-preview.png" width="800"/>
   <img src="images/WB-mytable-properties.png" width="800"/>
   <img src="images/WB-mytable-dependencies.png" width="800"/>
   <img src="images/WB-mytable-stats.png" width="800"/>

10. On the **demo_row - DB2DEMO - Table** tab, uncheck `MYTABLE` if checked. Notice the **Create table +** option — another way to create tables.

    <img src="images/WB-mytable-create-table-option.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Run Queries</h3>

11. On the left side, right-click **`MYTABLE` (b)**. Select **Generate DML (c)** → **Select (d)**.

    <img src="images/WB-mytable-generate-dml.png" width="800"/>

12. Copy and paste the SELECT statement a second time and add the following WHERE clauses:

    ```sql
    WHERE CODE = 2512;

    WHERE GRADE = 10;
    ```

    Also add:

    ```sql
    SELECT DISTINCT(SPEAKER) FROM DB2DEMO.MYTABLE ORDER BY SPEAKER;
    ```

    <img src="images/WB-queries.png" width="800"/>

    These queries check: all rows in the table, entries for the 2512 session, sessions with grade 10, and all speakers in the conference.

13. Click **Run all (a)**.

    <img src="images/WB-run-all-queries.png" width="800"/>

14. View the results at the bottom of the page **(a)**.

    <img src="images/WB-query-results-1.png" width="800"/>
    <img src="images/WB-query-results-2.png" width="800"/>
    <img src="images/WB-query-results-3.png" width="800"/>

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Generate a Large Dataset</h3>

15. Copy/paste the following insert statements **(b)** to generate 17,000 rows:

    ```sql
    INSERT INTO DB2DEMO.MYTABLE VALUES (2512, 'Db2 Genius Hub', 'Shes', 10);
    INSERT INTO DB2DEMO.MYTABLE VALUES (2512, 'Db2 Genius Hub', 'Cintia', 10);

    INSERT INTO DB2DEMO.MYTABLE2
    WITH GENERATOR(N) AS (
    SELECT 1 FROM SYSIBM.SYSDUMMY1
    UNION ALL
    SELECT N + 1 FROM GENERATOR WHERE N < 17000
    )
    SELECT
    1000 + N,
    'Db2 Genius Hub',
    CASE WHEN MOD(N, 2) = 0 THEN 'Shes' ELSE 'Cintia' END,
    N * 10
    FROM GENERATOR;
    ```

    > **ℹ️ Note:** We need a large enough table so the Query Tuner can recommend an index. This INSERT will generate 17,000 records.

    <img src="images/WB-new-inserts.png" width="800"/>

16. Select the new insert statements **(c)**, click the dropdown next to **Run all (d)**, and click **Run selected (e)**.

    <img src="images/WB-inserts-run-selected.png" width="800"/>

17. Review the query results.

    <img src="images/WB-inserts-review-results.png" width="800"/>

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Visual Explain</h2>

1. Go back to the **second tab (a)**. Select the query with the **CODE = 2512** WHERE clause **(b)** and click **Explain the statement (c)**.

   <img src="images/WB-explain-query.png" width="800"/>

2. The **Run Visual Explain** window opens. Click **OK (a)**.

   <img src="images/WB-run-explain-window.png" width="400"/>

3. The **Visual Explain** window opens. For this query, the optimizer will use a **full table scan (a)** to find the rows.

   <img src="images/WB-full-table-scan.png" width="800"/>

   > **ℹ️ Note:** The Visual Explain window is a separate floating window — you can resize and move it. Notice the table scan, which is how Db2 will retrieve the rows based on the query and the structure of the table.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Query Tuning</h2>

1. From the Visual Explain results, click **Tune query (a)** at the lower-right side of the screen.

   <img src="images/WB-tune-query.png" width="800"/>

2. The **Select tuning activities to run** window opens. Enter a **Name (a)** you can easily identify and click **OK (b)**.

   <img src="images/WB-tuning-name.png" width="400"/>

3. The information window opens. Click **Close (a)**.

   <img src="images/WB-tuning-close.png" width="400"/>

4. Go back to the Workbench and click **Query tuning log (a)**.

   <img src="images/WB-tuning-log.png" width="800"/>

5. Select **your query tuning task (a)** and click **View result (b)**.

   <img src="images/WB-tuning-view-result.png" width="800"/>

6. The tuning results window opens. Click **Report (a)** and scroll down to the **Recommended DDL for indexes (b)**.

   <img src="images/WB-tuning-results.png" width="800"/>

7. Go back to the **Advisor recommendation (a)** tab and select **Indexes (b)**. Select the index for `MYTABLE`.

   <img src="images/WB-table-apply-indexes.png" width="800"/>

8. From **Advisor scripts**, select **On-demand (a)** and click **Run (b)**.

   <img src="images/WB-apply-indexes.png" width="800"/>

9. The **Create on-demand tuning task** window opens. Change the tuning task name *(a)* to something identifiable and click **Next (b)**.

   <img src="images/WB-tuning-task-name.png" width="800"/>

10. Review the summary page and click **Finish (a)**.

    <img src="images/WB-tuning-finish.png" width="800"/>

11. A message confirms the task was created successfully. Click **Tuning results (a)**.

    <img src="images/WB-tuning-created.png" width="800"/>

12. Click **Tuning results** to see the list of tasks.

    <img src="images/Return-tuning-tasks.png" width="800"/>

13. Select the index task to review the results.

    <img src="images/WB-tuning-results-list.png" width="800"/>

14. The **View result** window opens. Click **Close (a)**.

    <img src="images/WB-index-results-and-close.png" width="400"/>

    Now that statistics are updated, retune the query to check for index recommendations.

15. Select your single-query tuning task and click **Retune**.

    <img src="images/WB-retune.png" width="800"/>

16. Enter a **Name (a)** and click **OK (b)**.

    <img src="images/WB-retune-name.png" width="800"/>

17. Click **Close (a)**.

    <img src="images/WB-retune-close.png" width="600"/>

18. Select your **retune task (a)** and click **View result (b)**.

    <img src="images/WB-retune-result.png" width="800"/>

19. This time there are no recommendations — the query is already optimized.

    <img src="images/WB-no-index-recommendation.png" width="800"/>

20. Return to the tab with the tuned query and rerun the explains.

    <img src="images/WB-retune-explain.png" width="800"/>

21. Review the explain — the index is now being used.

    **With Index:**

    <img src="images/WB-retune-explain-index.png" width="800"/>

22. Compare to the original explain before the index was applied.

    **Without Index:**

    <img src="images/WB-full-table-scan.png" width="800"/>

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Query Plan Comparison</h2>

The tables below compare the two execution plans — with and without the index applied.

| Aspect | With Index (Plan 1) | Without Index (Plan 2) |
|---|---|---|
| **Operator chain** | Return → Ixscan → Table | Return → Tq → Tbscan → Table |
| **Scan type** | **Index scan (Ixscan)** | **Table scan (Tbscan)** |
| **Cumulative total cost** | −0.00 | 7.07 |
| **Cumulative CPU cost** | 48,530 | 271,833 |
| **Cumulative I/O cost** | 0.00 | 1.00 |
| **Estimated output cardinality** | 2.00 rows | 1.00 row |
| **Extra operator** | None | Tq (table queue — parallel) |
| **PLANID** | `ff1f9de6295fb22` | `13c96b740a9173f8` |

> The index reduced CPU cost from **271,833** to **48,530** — an **82% improvement**.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">What-If Analysis *(Coming Soon)*</h2>

> **📌 Placeholder:** This section is reserved for future lab tasks.

The what-if analysis shows how a query will behave if an index is applied — without actually creating the index. It can also show what would happen if an existing index is dropped.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Impact Analysis *(Coming Soon)*</h2>

> **📌 Placeholder:** This section is reserved for future lab tasks.

The Impact Analysis report shows how the recommended index will affect the performance of your existing queries — which queries will gain performance and which may be impacted if the index is applied.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Query Workload *(Coming Soon)*</h2>

> **📌 Placeholder:** This section is reserved for future lab tasks.

The Query Workload feature tunes several queries simultaneously and recommends indexes based on the overall workload — not just a single query.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Next Steps</h2>

This completes the SQL Workbench section.

**[→ Proceed to Section 4: Monitoring Databases](04-monitoring.md)**

---
