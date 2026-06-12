# Learning All New Capabilities of AI Empowered Db2 Genius Hub

**Daniel Hancock**  
Daniel.Hancock@us.ibm.com  
World-wide Technology Sales — Databases

---

> © 2026 International Business Machines Corporation. No part of this document may be reproduced or transmitted in any form without written permission from IBM. U.S. Government Users Restricted Rights — use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM.
>
> This document is distributed "as is" without any warranty, either express or implied. IBM products and services are warranted per the terms and conditions of the agreements under which they are provided. Performance data and client examples are presented for illustrative purposes only. Actual performance results may vary depending on specific configurations and operating conditions.
>
> Any statements regarding IBM's future direction, intent, or product plans are subject to change or withdrawal without notice. References to IBM products, programs, or services do not imply that IBM intends to make such products available in all countries in which IBM operates.
>
> IBM, the IBM logo, and ibm.com are trademarks of International Business Machines Corporation, registered in many jurisdictions worldwide. A current list of IBM trademarks is available at: [www.ibm.com/legal/copytrade.shtml](https://www.ibm.com/legal/copytrade.shtml).

---

## Table of Contents

- [Introduction](#introduction)
  - [About This Hands-On Lab](#about-this-hands-on-lab)
- [1. The Setup](01_setup.md)
  - [1.1 Environment Overview](01_setup.md#11-environment-overview)
  - [1.2 Accessing the Lab Environment](01_setup.md#12-accessing-the-lab-environment)
  - [1.3 Default Credentials](01_setup.md#13-default-credentials)
  - [1.4 Setup and Configuration](01_setup.md#14-setup-and-configuration)
    - [1.4.1 Student SSH Access](01_setup.md#141-student-ssh-access)
    - [1.4.2 Start Genius Hub Services](01_setup.md#142-start-genius-hub-services)
    - [1.4.3 Login to Genius Hub Console](01_setup.md#143-login-to-genius-hub-console)
    - [1.4.4 Configure the REPO Database](01_setup.md#144-configure-the-repo-database)
    - [1.4.5 Login to Agentic AI Hub Console](01_setup.md#145-login-to-agentic-ai-hub-console)
  - [1.5 Architecture Summary](01_setup.md#15-architecture-summary)
  - [1.6 What You Will Achieve](01_setup.md#16-what-you-will-achieve)
- [2. The Basics](02_basics.md)
  - [2.1 Genius Hub Login](02_basics.md#21-genius-hub-login)
  - [2.2 Configure Repository (First Login Setup)](02_basics.md#22-configure-repository-first-login-setup)
  - [2.3 Getting to Know the Main Interfaces of Db2 Genius Hub](02_basics.md#23-getting-to-know-the-main-interfaces-of-db2-genius-hub)
    - [2.3.1 Db2 Genius Hub Home Page](02_basics.md#231-db2-genius-hub-home-page)
    - [2.3.2 Top 5 Busiest Databases](02_basics.md#232-top-5-busiest-databases)
    - [2.3.3 Heading Icons](02_basics.md#233-heading-icons)
    - [2.3.4 Exploring the Menus](02_basics.md#234-exploring-the-menus)
      - [2.3.4.1 Side Menu](02_basics.md#2341-side-menu)
      - [2.3.4.2 Help Menu](02_basics.md#2342-help-menu)
      - [2.3.4.3 APIs](02_basics.md#2343-apis)
      - [2.3.4.4 IBM Documentation](02_basics.md#2344-ibm-documentation)
      - [2.3.4.5 Community](02_basics.md#2345-community)
  - [2.4 Database Connections](02_basics.md#24-database-connections)
    - [2.4.1 Database Tags](02_basics.md#241-database-tags)
    - [2.4.2 Customize Columns](02_basics.md#242-customize-columns)
    - [2.4.3 Add a Database](02_basics.md#243-add-a-database)
    - [2.4.4 Add a Tag to the New Database](02_basics.md#244-add-a-tag-to-the-new-database)
  - [2.5 Monitor Dashboard](02_basics.md#25-monitor-dashboard)
    - [2.5.1 Filters](02_basics.md#251-filters)
    - [2.5.2 Details Tabs and Manage Tabs](02_basics.md#252-details-tabs-and-manage-tabs)
    - [2.5.3 Refresh and Pause](02_basics.md#253-refresh-and-pause)
    - [2.5.4 Charts](02_basics.md#254-charts)
  - [2.6 Set Up Your AI Configuration and Select a Model](02_basics.md#26-set-up-your-ai-configuration-and-select-a-model)
  - [2.7 Turning on Event Monitors](02_basics.md#27-turning-on-event-monitors)
  - [2.8 Configure Tabs for Utilities Monitoring](02_basics.md#28-configure-tabs-for-utilities-monitoring)
- [3. SQL Workbench](03_workbench.md)
  - [3.1 Exploring SQL Workbench](03_workbench.md#31-exploring-sql-workbench)
  - [3.2 Visual Explain](03_workbench.md#32-visual-explain)
  - [3.3 Query Tuner](03_workbench.md#33-query-tuner)
  - [3.4 What-if Analysis](03_workbench.md#34-what-if-analysis)
  - [3.5 Impact Analysis Report](03_workbench.md#35-impact-analysis-report)
- [4. Monitoring Databases](04_monitoring.md)
  - [4.1 Using Drill-Down for Investigation](04_monitoring.md#41-using-drill-down-for-investigation)
    - [4.1.1 Checking the Utilities](04_monitoring.md#411-checking-the-utilities)
  - [4.2 Reports](04_monitoring.md#42-reports)
  - [4.3 Using Agentic AI Assistant](04_monitoring.md#43-using-agentic-ai-assistant)
    - [4.3.1 Agentic AI Assistant Operation Modes](04_monitoring.md#431-agentic-ai-assistant-operation-modes)
      - [4.3.1.1 Agent Mode Sample Questions](04_monitoring.md#4311-agent-mode-sample-questions)
      - [4.3.1.2 Deep Research Sample Questions](04_monitoring.md#4312-deep-research-sample-questions)
- [5. Agentic AI Simulator](06_agentic_ai_simulator.md)

---

## Introduction

IBM Db2 Genius Hub is a web-based, AI-driven management console for Db2 LUW. It provides intelligent recommendations, data usage insights, and automation tools for quality and performance tuning. By bringing AI-powered observability and guidance, it simplifies administration, enhances performance, reduces operational costs, and lowers management complexity — helping DBAs of all levels manage databases more efficiently and make better decisions.

Key capabilities include:

- Monitor all aspects of your databases with graphs, alerts, and metrics in a single view
- Drill down from graphs to understand what was happening at a specific point in time
- Monitor and manage all Db2 instances from a single interface: on-prem, cloud, or hybrid
- Improve query performance with the AI Query Tuner: recommended indexes, what-if scenarios, and impact analysis
- Receive alerts when problems occur based on threshold configuration, with fast diagnostics and resolution recommendations from the Database Assistant
- Manage database backups
- Create, start, stop, and monitor data replication between source and target systems via Q Replication integration
- Compare behavior across databases using custom dashboards
- Comprehensive job management: scheduling, execution, monitoring, and alerting

---

### About This Hands-On Lab

This lab showcases the new features of Db2 Genius Hub and how they assist DBAs in administering Db2 databases using AI. The lab is organized into five parts:

**Part 1 — The Setup**
Work within a pre-configured environment providing access to IBM Db2, Db2 Genius Hub, and an Agentic AI application. Become familiar with the environment and perform initial configuration of Db2 Genius Hub.

**Part 2 — The Basics**
Learn the fundamentals of Db2 Genius Hub pages and configure event monitors to collect additional performance data.

**Part 3 — SQL Workbench**
Use the Workbench to manage tables and the AI Query Tuner to generate index recommendations, analyze impact using what-if analysis, and review impact analysis reports. Topics include:
- Exploring SQL Workbench
- Visual Explain
- Query Tuner
- What-if Analysis
- Impact Analysis Report

**Part 4 — Monitoring Databases**
Analyze database performance issues by drilling into detailed graphs. Leverage recommendations to prevent future occurrences and configure alerts for proactive monitoring. Topics include:
- Graphs and Filters
- Reports
- Database Assistant
- Alerts and Jobs

**Part 5 — Db2 Agentic AI Simulator**
Interact with the Db2 Agentic AI Simulator to trigger performance scenarios and see how the AI service detects and resolves issues. Capabilities include:
- Loading TPC-H benchmark data for testing
- Simulating WLM queuing scenarios
- Triggering query spilling events
- Creating locking contention
- Testing space management issues
- Demonstrating blocking scenarios
- Running runstats operations

> **About the Simulator:** The **Db2 Agentic AI Simulator** is a separate, as-is application (not part of Db2 Genius Hub) provided for hands-on lab tasks. It allows you to trigger events that demonstrate how the Db2 agentic AI service solves problems.

#### Available Datasets

##### Text2SQL

| Dataset | Description |
|---|---|
| **Cricket Statistics** | Batting, bowling, and fielding records |
| **Supply Chain Data** | Products, inventory, orders, and shipments |
| **TPC-H Benchmark** | Decision support data: suppliers, customers, orders, and parts |

##### Performance Simulator

| Dataset | Description |
|---|---|
| **TPC-H Dataset** *(prerequisite)* | Load TPC-H benchmark data required by all performance simulators |
| **Cricket Statistics** | Detailed cricket statistics for performance testing |
| **Supply Chain Data** | Supply chain data for performance testing |
| **TPC-H Benchmark** | Full TPC-H decision support benchmark dataset |

Available performance simulation scenarios:

- WLM Queuing
- Query Spilling
- Locking
- Space Management
- Blocking
- Runstats

---
### Next Steps

This completes the introduction of Db2 Genius Hub. Proceed to [Section 2. The Setup](01_setup.md).

---
