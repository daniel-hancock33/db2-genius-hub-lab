## 4. SQL Workbench

You can use the Workbench to run SQL statements, generate Visual Explains, tune queries, generate what-if analysis, and run Impact Analysis reports.

> **Note:** The Activity Event monitor must be enabled for the Impact Analysis report. Make sure you have completed [Section 2.7 Turning on Event Monitors](02_basics.md#27-turning-on-event-monitors) before proceeding.

1. From the side menu, select **SQL Workbench (a)**.

   <img src="images/WB-side-menu.png" width="200"/>

2. The Workbench window opens. Create a new tab by clicking **+ (b)**.

   <img src="images/WB-new-tab.png" width="800"/>

---

### 4.1 SQL Editor

There are several ways to create a table in Db2 Genius Hub:

- Using the smart SQL Editor to generate the create statement via the table list items option.
      
   <img src="images/WB-smart-table-editor.png" width="800"/>

   (a) Database  
   (b) Schema  
   (c) List tables items (if tables exist click the three vertical dots and select List items)
   (d) Create table  
      
- Create the table by typing the command manually

For this lab, we will use the second option.

1. Use the tab you opened and create a new table and insert the first 3 rows using the following SQL statements.

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

2. Click **Run all (a)**.

   <img src="images/WB-run-all.png" width="800"/>

3. Check the execution results at the **lower part (b)** of the page.

   <img src="images/WB-execution-results.png" width="800"/>

4. Now that your table is created, check the table details on the left side of the screen. Reload the object list.

   (a) Click `demo_col`  
   (b) Click three vertical dots  
   (c) Select **Reload items**  

   <img src="images/WB-refresh-objects.png" width="800"/>

5. `MYTABLE` should now be displayed.

   <img src="images/WB-mytable-reloaded.png" width="800"/>

6. This is the tables list view, showing the tables list for the `DB2DEMO` schema in the `demo_row` database.
   Table shown:

   `MYTABLE` — a single table with:

   Tablespace: `TS4MONITOR` (Block type)  
   Row count: `0` (empty)  
   Owner: `DB2DEMO`  
   Created: `June 8, 2026 1:26 PM`   

   `MYTABLE` table is selected (checkbox checked), which activates the action toolbar at the top showing: Add column, Generate DDL, Access control, Update statistics, and Drop.
   
   The three-dot context menu (⋮) is also open on the row, showing the same per-table actions:

      - Add column
      - Generate DDL
      - Access control
      - Update statistics
      - Drop

   This is a standard table management screen where you can perform administrative actions on a table either via the top toolbar (when selected) or the row-level context menu.

   <img src="images/WB-table-options.png" width="800"/>


7. Select **`MYTABLE` (a)** to view the details.

    <img src="images/WB-select-MYTABLE-details.png" width="800"/>

    **Columns**  

    <img src="images/WB-mytable-columns.png" width="800"/>

    **Data preview**  

    <img src="images/WB-mytable-preview.png" width="800"/>

    **Properties**  

    <img src="images/WB-mytable-properties.png" width="800"/>

    **Dependencies**  

    <img src="images/WB-mytable-dependencies.png" width="800"/>

    **Statistics**  

    <img src="images/WB-mytable-stats.png" width="800"/>


8. On the **demo_row - DB2DEMO - Table** tab, uncheck `MYTABLE` if checked.  Notice the **Create table +** option, this is another option for creating tables.

    <img src="images/WB-mytable-create-table-option.png" width="800"/>

9. On to the left side of the screen right click `MYTABLE` *(b)*.  Select Generate DML (c) and select (d) **Select**:

    <img src="images/WB-mytable-generate-dml.png" width="800"/>



10. Copy and paste the select statement **(a)** a second time and add the following WHERE clauses:

      ```sql
         WHERE CODE = 2512;

         WHERE GRADE = 10;
      ```

      Also add the following statement:

      ```sql
      SELECT DISTINCT(SPEAKER) FROM DB2DEMO.MYTABLE ORDER BY SPEAKER;
      ```

    <img src="images/WB-queries.png" width="800"/>

      These queries check: all rows in the table, entries for the 2512 session, sessions with grade 10, and all speakers in the conference.

11. Click **Run all (a)**.

    <img src="images/WB-run-all-queries.png" width="800"/>

12. View the results at the bottom of the page **(a)**.

    <img src="images/WB-query-results-1.png" width="800"/>

    <img src="images/WB-query-results-2.png" width="800"/>

    <img src="images/WB-query-results-3.png" width="800"/>

13. Copy/paste insert statements **(b)** with different CODE values to generate 17,000 rows:

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

    > **Note:** We need a table large enough so the Query Tuner can recommend an index. This INSERT will generate 17,000 records.

    <img src="images/WB-new-inserts.png" width="800"/>
    
14. Select the new insert statements **(c)**, click the drop down next to **Run all (d)**  and click **Run selected (e)**.

     <img src="images/WB-inserts-run-selected.png" width="800"/>

15. Review the query results.

    <img src="images/WB-inserts-review-results.png" width="800"/>

---

### 4.2 Visual Explain

1. Go back to the **second tab (a)**. Select the query with the **CODE = 2512** WHERE clause **(b)** and click **Explain the statement (c)**.

   <img src="images/WB-explain-query.png" width="800"/>

2. The **Run Visual Explain** window opens. If you are familiar with Db2 Visual Explain, you can make changes here. Click **OK (a)**.

   <img src="images/WB-run-explain-window.png" width="400"/>

3. The **Visual Explain** window opens. For this query, the optimizer will use a **full table scan (a)** to find the rows.

   <img src="images/WB-full-table-scan.png" width="800"/>

   > **Note**: The **Visual Explain** window is a separate window. You can resize it and move it around the screen.  Notice the table scan which is how Db2 will retrieve the rows based on the query and the sturcture of the table.

---

### 4.3 Query Tuning

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

7. Go back to the **Advisor recommendation (a)** tab and select **Indexes (b)**.  Select index for `MYTABLE` (b).

   <img src="images/WB-table-apply-indexes.png" width="800"/>

8. From the **Advisor scripts select **On-demand(a)** and click **Run (b)**.

   <img src="images/WB-apply-indexes.png" width="800"/>

9. The **Create on-demand tuning task** window opens. Change the tuning task name (a) to something you can identify and click **Next (b)**.

    <img src="images/WB-tuning-task-name.png" width="800"/>

10. Review the summary page and click **Finish (a)**.

    <img src="images/WB-tuning-finish.png" width="800"/>

11. A message confirms the task was created successfully. Click **Tuning results (a)**.

    <img src="images/WB-tuning-created.png" width="800"/>

12. Click Tuning results to see the list of tasks.

    <img src="images/Return-tuning-tasks.png" width="800"/>

13. Select the index task to review the results.

    <img src="images/WB-tuning-results-list.png" width="800"/>

14. The **View result** window opens. Click **Close (a)**.

    <img src="images/WB-index-results-and-close.png" width="400"/>

    Now that the statistics are updated, retune the query to check for index recommendations.

15. Select your single-query tuning task and click **Retune**.

    <img src="images/WB-retune.png" width="800"/>

16. Enter a **Name (a)** you can easily identify and click **OK (b)**.

    <img src="images/WB-retune-name.png" width="800"/>

17. The information window opens. Click **Close (a)**.

    <img src="images/WB-retune-close.png" width="600"/>

18. Select your **retune task (a)** and click **View result (b)**.

    <img src="images/WB-retune-result.png" width="800"/>

19. This time no recommendations since the query is not optimized.

    <img src="images/WB-no-index-recommendation.png" width="800"/>

20. Return to the tab with the tuned query and rerun the explains.

    <img src="images/WB-retune-explain.png" width="800"/>

21. Review the explain and notice the index is now being used.

    **With Index**  
    <img src="images/WB-retune-explain-index.png" width="800"/>

22. Review the new explain to the older explain before the index was applied.

    **Without Index**  
    <img src="images/WB-full-table-scan.png" width="800"/>

### IBM Db2 Query Plan Comparison

#### Execution Plan Overview

   | Aspect | Plan 1 (Image 1) | Plan 2 (Image 2) |
   |---|---|---|
   | **Operator chain** | Return → Ixscan → Table | Return → Tq → Tbscan → Table |
   | **Scan type** | **Index scan (Ixscan)** | **Table scan (Tbscan)** |
   | **Cumulative total cost** | −0.00 | 7.07 |
   | **Cumulative CPU cost** | 48,530 | 271,833 |
   | **Cumulative I/O cost** | 0.00 | 1.00 |
   | **Estimated output cardinality** | 2.00 rows | 1.00 row |
   | **Extra operator** | None | Tq (table queue — parallel) |
   | **PLANID** | `ff1f9de6295fb22` | `13c96b740a9173f8` |

---

### 4.4 What-If Analysis (SKIP)

> **Note:** This is a place holder for future lab tasks. 

The what-if analysis shows how a query will behave if the index is applied, without actually creating the index. It can also show what would happen if an existing index is dropped.


---

### 4.5 Impact Analysis (SKIP)

The Impact Analysis report shows how the recommended index will affect the performance of your existing queries — which queries will gain performance and which may be impacted if the index is applied.

> **Note:** This is a place holder for future lab tasks. 

---

### 4.6 Query Workload (SKIP)

The Query Workload feature tunes several queries simultaneously and recommends indexes based on the overall workload — not just a single query.
ß
   > **Note:** This is a place holder for future lab tasks.

### 4.7 Next

This completes the Workbench lab proceed to [Section 4. Monitoring](04-monitoring.md).
