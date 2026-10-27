<h1 style="padding-left:16px; border-left:8px solid #378ADD;">Query Tuning with the AI Assistant</h1>

Take a slow TPC-H query, ask the Db2 Genius Hub AI assistant to tune it, apply the recommendations, and watch the query speed up dramatically. Then clean up so the exercise can be repeated.

**The task.** Open the SQL Workbench, run a slow correlated subquery, ask the assistant to tune it, then apply the index it recommends and optionally the rewritten query. Confirm the speedup and clean up.

**The story.** The query looks up the most recent line item for each of 50 suppliers. Without an index, Db2 scans the `LINEITEM` table once per supplier — 50 full scans. The assistant identifies the bottleneck, recommends a query rewrite and a composite index, and explains why each helps. After you apply the index, the query returns in well under a second.

> **ℹ️ AI output varies.** The exact recommendations, query rewrites, and index names the assistant generates will differ from the screenshots. Focus on the overall approach.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 0 — Connect the Simulator to demo_row</h3>

The TPC-H data is already loaded in `demo_row`. You only need to connect the simulator so it knows which database to use.

1. Open the Agentic AI Simulator at `http://localhost:3000` in Firefox inside the Guacamole desktop.

2. Click **Connect DB** in the top-right corner.

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

4. Click **Test Connection**. Wait for the green **Connected** badge. Do not continue until it is green.

   <img src="images/SIM-db-creds.png" width="500"/>

5. You do not need to load data. The `TPCH1`, `TPCH2` and `TPCH3` schemas are already loaded in `demo_row` — skip **Load Data**.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 1 — Confirm No Index on L_SUPPKEY Exists</h3>

Some TPC-H loaders create foreign-key indexes. If an index already starts with `L_SUPPKEY`, the query will run fast and the assistant will have nothing to recommend. Check first.

In the Genius Hub **SQL Workbench**, run:

```sql
SELECT INDSCHEMA, INDNAME, COLNAMES
FROM   SYSCAT.INDEXES
WHERE  TABSCHEMA = 'TPCH1'
  AND  TABNAME   = 'LINEITEM'
  AND  COLNAMES LIKE '+L_SUPPKEY%';
```

> **Expected:** no rows returned. If a row is returned, go to Step 8 and drop that index first, then return here.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 2 — Run the Slow Query and Note the Time</h3>

This query looks up the most recent line item for each of 50 suppliers. Without an index, Db2 scans `LINEITEM` once per supplier.

In the **SQL Workbench**, run:

```sql
SELECT S.S_SUPPKEY,
       S.S_NAME,
       (SELECT L.L_EXTENDEDPRICE
        FROM   TPCH1.LINEITEM L
        WHERE  L.L_SUPPKEY = S.S_SUPPKEY
        ORDER BY L.L_SHIPDATE DESC
        FETCH FIRST 1 ROW ONLY) AS LATEST_LINE_PRICE
FROM   TPCH1.SUPPLIER S
WHERE  S.S_SUPPKEY BETWEEN 1 AND 50
ORDER BY S.S_SUPPKEY;
```

> **Expected:** 50 rows, after a noticeable wait (about 30 seconds). Write down the **Runtime** from the Execution log — you will compare it in Step 6.

> **ℹ️ Note:** If it finishes much faster or slower than you want, change the upper bound in `BETWEEN 1 AND 50` — a smaller number shortens the wait, a larger number lengthens it.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 3 — Ask the Assistant to Tune the Query</h3>

Open the Agentic AI Assistant in Genius Hub (click **Agentic AI Assistant** in the left menu), choose `demo_row` in the **Choose Database** field, then paste and send the prompt below. It includes the full query.

**You ask:**

```
Can you tune this query and provide optimization recommendations?

SELECT S.S_SUPPKEY,
       S.S_NAME,
       (SELECT L.L_EXTENDEDPRICE
        FROM   TPCH1.LINEITEM L
        WHERE  L.L_SUPPKEY = S.S_SUPPKEY
        ORDER BY L.L_SHIPDATE DESC
        FETCH FIRST 1 ROW ONLY) AS LATEST_LINE_PRICE
FROM   TPCH1.SUPPLIER S
WHERE  S.S_SUPPKEY BETWEEN 1 AND 50
ORDER BY S.S_SUPPKEY
```

> **Expected:** the assistant replies with:
> - **Performance impact:** the correlated subquery runs once per supplier row (50 times), causing repeated scans of `TPCH1.LINEITEM`.
> - **Primary recommendation:** a query rewrite using a `LEFT OUTER JOIN` with `ROW_NUMBER()` to eliminate the correlated execution.
> - **Index recommendation:** a composite index on `LINEITEM(L_SUPPKEY, L_SHIPDATE DESC)` to speed up both the original query and the rewritten version.
> - **Alternative:** a `LATERAL` join option for Db2 11.1+.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 4 — Review the Recommendation</h3>

Scroll through the reply. The assistant typically gives three recommendations:

**1. Query rewrite (primary)** — replaces the correlated subquery with a `LEFT OUTER JOIN` and `ROW_NUMBER()`:

```sql
SELECT S.S_SUPPKEY,
       S.S_NAME,
       L.L_EXTENDEDPRICE AS LATEST_LINE_PRICE
FROM TPCH1.SUPPLIER S
LEFT OUTER JOIN (
    SELECT L_SUPPKEY,
           L_EXTENDEDPRICE,
           ROW_NUMBER() OVER (PARTITION BY L_SUPPKEY ORDER BY L_SHIPDATE DESC) AS RN
    FROM TPCH1.LINEITEM
    WHERE L_SUPPKEY BETWEEN 1 AND 50
) L ON L.L_SUPPKEY = S.S_SUPPKEY AND L.RN = 1
WHERE S.S_SUPPKEY BETWEEN 1 AND 50
ORDER BY S.S_SUPPKEY;
```

This eliminates the 50 separate subquery executions and allows Db2 to use a single join.

**2. Composite index** — covers the join predicate and `ORDER BY`:

```sql
CREATE INDEX IDX_LINEITEM_SUPPKEY_SHIPDATE
ON TPCH1.LINEITEM(L_SUPPKEY, L_SHIPDATE DESC);
```

**3. Alternative LATERAL join** — keeps the correlated structure but may be optimized better by Db2 11.1+.

> **ℹ️ Note:** The assistant may give a different index name or column list. Use the statement it gives you.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 5 — Create the Index</h3>

In the assistant's reply, click **Open in workbench** on the `CREATE INDEX` block. The statement opens in the SQL Workbench. Select it and click **Run selected**.

```sql
CREATE INDEX IDX_LINEITEM_SUPPKEY_SHIPDATE
ON TPCH1.LINEITEM(L_SUPPKEY, L_SHIPDATE DESC);
```

> **Expected:** the statement succeeds.

> **ℹ️ Note:** The index is created in your connection's schema (`DB2DEMO`). You will need it in Step 8.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 6 — Re-Run and Compare</h3>

Run the original query from Step 2 again and compare the runtime. Then optionally run the rewritten query from Step 4 and compare that too.

**Original query (with index now in place):**

```sql
SELECT S.S_SUPPKEY,
       S.S_NAME,
       (SELECT L.L_EXTENDEDPRICE
        FROM   TPCH1.LINEITEM L
        WHERE  L.L_SUPPKEY = S.S_SUPPKEY
        ORDER BY L.L_SHIPDATE DESC
        FETCH FIRST 1 ROW ONLY) AS LATEST_LINE_PRICE
FROM   TPCH1.SUPPLIER S
WHERE  S.S_SUPPKEY BETWEEN 1 AND 50
ORDER BY S.S_SUPPKEY;
```

> **Expected:** the same 50 rows, now returned in well under a second. Compare the **Runtime** with Step 2.

**Rewritten query (assistant's primary recommendation):**

```sql
SELECT S.S_SUPPKEY,
       S.S_NAME,
       L.L_EXTENDEDPRICE AS LATEST_LINE_PRICE
FROM TPCH1.SUPPLIER S
LEFT OUTER JOIN (
    SELECT L_SUPPKEY,
           L_EXTENDEDPRICE,
           ROW_NUMBER() OVER (PARTITION BY L_SUPPKEY ORDER BY L_SHIPDATE DESC) AS RN
    FROM TPCH1.LINEITEM
    WHERE L_SUPPKEY BETWEEN 1 AND 50
) L ON L.L_SUPPKEY = S.S_SUPPKEY AND L.RN = 1
WHERE S.S_SUPPKEY BETWEEN 1 AND 50
ORDER BY S.S_SUPPKEY;
```

> **Expected:** the same 50 rows, also fast. The rewritten query eliminates the correlated subquery entirely.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 7 — Confirm the Index in the Catalog</h3>

Check that the index exists before you drop it.

```sql
SELECT INDSCHEMA, INDNAME, COLNAMES
FROM   SYSCAT.INDEXES
WHERE  TABSCHEMA = 'TPCH1'
  AND  TABNAME   = 'LINEITEM'
  AND  COLNAMES LIKE '+L_SUPPKEY%';
```

> **Expected:** one row — `DB2DEMO`, `IDX_LINEITEM_SUPPKEY_SHIPDATE`, `+L_SUPPKEY-L_SHIPDATE`.

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 8 — Clean Up: Drop the Index</h3>

Drop the index so the exercise can be run again. Substitute the index name from the Step 7 result.

```sql
DROP INDEX DB2DEMO.IDX_LINEITEM_SUPPKEY_SHIPDATE;
```

Then refresh the statistics:

```sql
CALL SYSPROC.ADMIN_CMD('RUNSTATS ON TABLE TPCH1.LINEITEM WITH DISTRIBUTION AND DETAILED INDEXES ALL');
```

> **⚠️ Warning:** Only drop the index you created in this exercise. Indexes that enforce a primary key or unique constraint cannot be dropped with `DROP INDEX` (error SQL0669N).

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Step 9 — Verify the Cleanup</h3>

Re-run the lookup from Step 1 to confirm the index is gone:

```sql
SELECT INDSCHEMA, INDNAME, COLNAMES
FROM   SYSCAT.INDEXES
WHERE  TABSCHEMA = 'TPCH1'
  AND  TABNAME   = 'LINEITEM'
  AND  COLNAMES LIKE '+L_SUPPKEY%';
```

> **Expected:** no rows. The query from Step 2 is slow again — the exercise is ready to run from Step 1.

> ✅ **Task complete.** You have used the Db2 Genius Hub AI assistant to diagnose a slow query, applied the recommended index, confirmed the speedup, and restored the database to its original state.

| Action | What You Did |
|---|---|
| **Confirmed the baseline** | Verified no index on `L_SUPPKEY` existed, then ran the slow query and noted the runtime |
| **Asked the assistant** | Pasted the query and asked for tuning recommendations |
| **Reviewed the plan** | Read the assistant's query rewrite, index recommendation, and explanation |
| **Applied the fix** | Created the composite index from the assistant's reply |
| **Confirmed the speedup** | Re-ran the original and rewritten queries and compared runtimes |
| **Cleaned up** | Dropped the index so the exercise can be repeated |

---

🎯 **TechXchange Quick Path — Step 9 of 9:** **[← Text2SQL](05-03-text2sql.md)** &nbsp;&nbsp;|&nbsp;&nbsp; ✅ End of the Quick Path

**[← Return to Introduction](00-introduction.md)**
