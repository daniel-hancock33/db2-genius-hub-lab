<h1 style="padding-left:16px; border-left:8px solid #378ADD;">Visual Explain</h1>


1. Go back to the **second tab (a)**. Select the query with the **CODE = 2512** WHERE clause **(b)** and click **Explain the statement (c)**.

   <img src="images/WB-explain-query.png" width="800"/>

2. The **Run Visual Explain** window opens. Click **OK (a)**.

   <img src="images/WB-run-explain-window.png" width="400"/>

3. The **Visual Explain** window opens. For this query, the optimizer will use a **full table scan (a)** to find the rows.

   <img src="images/WB-full-table-scan.png" width="800"/>

   > **ℹ️ Note:** The Visual Explain window is a separate floating window — you can resize and move it. Notice the table scan, which is how Db2 will retrieve the rows based on the query and the structure of the table.

---

---

**[← SQL Editor](03-01-sql-editor.md)** &nbsp;&nbsp;|&nbsp;&nbsp; **[→ Query Tuning](03-03-query-tuning.md)**

---
