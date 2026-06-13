<h1 style="padding-left:16px; border-left:8px solid #378ADD;">3.1 — SQL Editor</h1>


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

---

**[← 2.5: AI Configuration and Event Monitors](02-05-ai-configuration.md)** &nbsp;&nbsp;|&nbsp;&nbsp; **[→ 3.2: Visual Explain](03-02-visual-explain.md)**

---
