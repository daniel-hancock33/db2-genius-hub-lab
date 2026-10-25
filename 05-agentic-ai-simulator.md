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

The three TechXchange exercises are on their own pages:

1. [Space Management with AI](05-01-space-management.md) — find and reclaim wasted space with the AI assistant.
2. [WLM Queuing](05-02-wlm-queuing.md) — diagnose and fix a workload manager queuing problem.
3. [Text2SQL](05-03-text2sql.md) — turn a plain-English question into Db2 SQL with the AI assistant.

---

**[→ Space Management with AI](05-01-space-management.md)**
