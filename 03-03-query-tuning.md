<h1 style="padding-left:16px; border-left:8px solid #378ADD;">Query Tuning</h1>


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

   <img src="images/WB-apply-indexes.png" width="400"/>

9. The **Create on-demand tuning task** window opens. Change the tuning task name *(a)* to something identifiable and click **Next (b)**.

   <img src="images/WB-tuning-task-name.png" width="400"/>

10. Review the summary page and click **Finish (a)**.

    <img src="images/WB-tuning-finish.png" width="400"/>

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

19. This time, there are no recommendations — the query is already optimized.

    <img src="images/WB-no-index-recommendation.png" width="800"/>

20. Return to the tab with the tuned query (a). Select the query where `CODE = 2512` (b) and click **Explains the statement (c)***.

    <img src="images/WB-retune-explain.png" width="800"/>

21. Review the **Run Visual Explain Options** and click **OK (a)**.  

    <img src="images/WB-rerun-explain-ok.png" width="800"/>

22. Review the explain — the index is now being used.

    **With Index:**

    <img src="images/WB-retune-explain-index.png" width="800"/>

23. Compare to the original explain before the index was applied.

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

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Impact Analysis *(Coming Soon)*</h2>

> **📌 Placeholder:** This section is reserved for future lab tasks.

The Impact Analysis report shows how the recommended index will affect the performance of your existing queries — which queries will gain performance and which may be impacted if the index is applied.

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Query Workload *(Coming Soon)*</h2>

> **📌 Placeholder:** This section is reserved for future lab tasks.

The Query Workload feature tunes several queries simultaneously and recommends indexes based on the overall workload — not just a single query.

---

---

**[← Visual Explain](03-02-visual-explain.md)** &nbsp;&nbsp;|&nbsp;&nbsp; **[→ Drill-Down Investigation](04-01-drill-down.md)**

---
