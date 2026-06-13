<h1 style="padding-left:16px; border-left:8px solid #378ADD;">IBM Db2 Genius Hub — Hands-On Lab</h1>

**Author:** Daniel Hancock — Daniel.Hancock@us.ibm.com  
**Role:** World-wide Technology Sales — Databases

---

> **© 2026 International Business Machines Corporation.**  
> No part of this document may be reproduced or transmitted in any form without written permission from IBM. U.S. Government Users Restricted Rights — use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM.
>
> This document is distributed "as is" without any warranty, either express or implied. IBM products and services are warranted per the terms and conditions of the agreements under which they are provided. Performance data and client examples are presented for illustrative purposes only. Actual performance results may vary depending on specific configurations and operating conditions.
>
> Any statements regarding IBM's future direction, intent, or product plans are subject to change or withdrawal without notice. References to IBM products, programs, or services do not imply that IBM intends to make such products available in all countries in which IBM operates.
>
> IBM, the IBM logo, and ibm.com are trademarks of International Business Machines Corporation, registered in many jurisdictions worldwide. A current list of IBM trademarks is available at [www.ibm.com/legal/copytrade.shtml](https://www.ibm.com/legal/copytrade.shtml).

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Table of Contents</h2>

**[Introduction](00-introduction.md)**

**[1 — The Setup](01-setup.md)**

**2 — The Basics**
- [2.1 — Login and Repository Setup](02-01-login-and-repo.md)
- [2.2 — Interface Tour](02-02-interface-tour.md)
- [2.3 — Database Connections](02-03-database-connections.md)
- [2.4 — Monitor Dashboard](02-04-monitor-dashboard.md)
- [2.5 — AI Configuration and Event Monitors](02-05-ai-configuration.md)

**3 — SQL Workbench**
- [3.1 — SQL Editor](03-01-sql-editor.md)
- [3.2 — Visual Explain](03-02-visual-explain.md)
- [3.3 — Query Tuning](03-03-query-tuning.md)

**4 — Monitoring Databases**
- [4.1 — Drill-Down Investigation](04-01-drill-down.md)
- [4.2 — Reports](04-02-reports.md)
- [4.3 — Agentic AI Assistant](04-03-agentic-ai-assistant.md)
- [4.4 — Alerts and Jobs](04-04-alerts-and-jobs.md)

**[5 — Agentic AI Simulator](05-agentic-ai-simulator.md)**

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Introduction</h2>

IBM Db2 Genius Hub is a web-based, AI-driven management console for Db2 LUW. It provides intelligent recommendations, data usage insights, and automation tools for quality and performance tuning. By bringing AI-powered observability and guidance, it simplifies administration, enhances performance, reduces operational costs, and lowers management complexity — helping DBAs of all levels manage databases more efficiently and make better decisions.

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Key Capabilities</h3>

| Capability | Description |
|---|---|
| **Unified Monitoring** | Monitor all aspects of your databases with graphs, alerts, and metrics in a single view |
| **Drill-Down Analysis** | Drill down from graphs to understand what was happening at a specific point in time |
| **Multi-Environment Support** | Monitor and manage all Db2 instances from a single interface: on-prem, cloud, or hybrid |
| **AI Query Tuner** | Improve query performance with recommended indexes, what-if scenarios, and impact analysis |
| **Intelligent Alerting** | Receive threshold-based alerts with fast diagnostics and resolution recommendations |
| **Backup Management** | Manage database backups centrally |
| **Q Replication Integration** | Create, start, stop, and monitor data replication between source and target systems |
| **Custom Dashboards** | Compare behavior across databases using flexible, customizable dashboards |
| **Job Management** | Comprehensive scheduling, execution, monitoring, and alerting for database jobs |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">About This Hands-On Lab</h2>

This lab showcases the new features of Db2 Genius Hub and how they assist DBAs in administering Db2 databases using AI. The lab is organized into five parts:

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">The Setup</h3>

> Work within a pre-configured environment providing access to IBM Db2, Db2 Genius Hub, and an Agentic AI application. Become familiar with the environment and perform initial configuration of Db2 Genius Hub.

**[→ Go to Section 1: The Setup](01-setup.md)**

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">The Basics</h3>

> Learn the fundamentals of Db2 Genius Hub pages and configure event monitors to collect additional performance data.

**[→ 2.1: Login and Repository Setup](02-01-login-and-repo.md)**

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">SQL Workbench</h3>

> Use the Workbench to manage tables and the AI Query Tuner to generate index recommendations, analyze impact using what-if analysis, and review impact analysis reports.

Topics include:
- Exploring SQL Workbench
- Visual Explain
- Query Tuner
- What-if Analysis
- Impact Analysis Report

**[→ 3.1: SQL Editor](03-01-sql-editor.md)**

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Monitoring Databases</h3>

> Analyze database performance issues by drilling into detailed graphs. Leverage recommendations to prevent future occurrences and configure alerts for proactive monitoring.

Topics include:
- Graphs and Filters
- Reports
- Database Assistant
- Alerts and Jobs

**[→ 4.1: Drill-Down Investigation](04-01-drill-down.md)**

---

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Agentic AI Simulator</h3>

> Interact with the Db2 Agentic AI Simulator to trigger performance scenarios and see how the AI service detects and resolves issues.

Capabilities include:
- Loading TPC-H benchmark data for testing
- Simulating WLM queuing scenarios
- Triggering query spilling events
- Creating locking contention
- Testing space management issues
- Demonstrating blocking scenarios
- Running runstats operations

> **ℹ️ About the Simulator:** The **Db2 Agentic AI Simulator** is a separate, as-is application (not part of Db2 Genius Hub) provided for hands-on lab tasks. It allows you to trigger events that demonstrate how the Db2 agentic AI service solves problems.

**[→ Go to Section 5: Agentic AI Simulator](05-agentic-ai-simulator.md)**

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Available Datasets</h2>

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Text2SQL</h3>

| Dataset | Description |
|---|---|
| **Cricket Statistics** | Batting, bowling, and fielding records |
| **Supply Chain Data** | Products, inventory, orders, and shipments |
| **TPC-H Benchmark** | Decision support data: suppliers, customers, orders, and parts |

<h3 style="padding-left:14px; border-left:5px solid #EF9F27;">Performance Simulator</h3>

| Dataset | Description |
|---|---|
| **TPC-H Dataset** *(prerequisite)* | Load TPC-H benchmark data required by all performance simulators |
| **Cricket Statistics** | Detailed cricket statistics for performance testing |
| **Supply Chain Data** | Supply chain data for performance testing |
| **TPC-H Benchmark** | Full TPC-H decision support benchmark dataset |

**Available performance simulation scenarios:**

| Scenario | Description |
|---|---|
| WLM Queuing | Simulate workload manager sort memory queuing |
| Query Spilling | Trigger sort spill-to-disk events |
| Locking | Create locking contention between sessions |
| Space Management | Test tablespace space management issues |
| Blocking | Demonstrate transaction blocking scenarios |
| Runstats | Run statistics collection operations |

---

<h2 style="padding-left:14px; border-left:6px solid #1D9E75;">Next Steps</h2>

This completes the introduction to Db2 Genius Hub.

**[→ Start the lab: Section 1 — The Setup](01-setup.md)**

---
