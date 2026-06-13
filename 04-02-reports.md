<h1 style="padding-left:16px; border-left:8px solid #378ADD;">Reports</h1>


Now that you have identified the cause of the CPU spike, generate a report to document the findings. Reports can be shared, kept for historical reference, or scheduled to run automatically.

1. From the side menu, select **Reports (a)**.

   <img src="images/GH-report-side-menu.png" width="200"/>

2. Click **Create report (b)**.

   <img src="images/GH-create-report.png" width="800"/>

3. Select **On-demand (c)** to create a report immediately.

   <img src="images/GH-create-on-demand-report.png" width="400"/>

   **Available report types:**

   | Report | Description |
   |---|---|
   | **Database performance** | Overall status and key metrics: CPU, memory, storage, throughput, SQL statements |
   | **Enterprise trends** | Top 10 statements by CPU, memory, storage, and log space usage |
   | **Top statements** | Monitoring metrics for top N SQL statements from package cache |
   | **Table usage** | Top N table objects and related key metrics |
   | **Disk space usage** | Storage usage information for the database |

4. Fill in the report details:

   | Label | Field | Value |
   |---|---|---|
   | **a** | Name | `CPU Spike` |
   | **b** | Type | Database performance |
   | **c** | Database | `demo_col` |

   Click **Next (d)**.

   <img src="images/GH-report-config.png" width="800"/>

5. Leave the default metrics and click **Next (a)**.

   <img src="images/GH-report-metrics.png" width="800"/>

6. Ensure **CPU (a)** is selected. Keep the Interval as **12 hours (b)**. Skip the **Notifications** field and click **Next (c)**.

   <img src="images/GH-report-metrics-custom.png" width="800"/>

7. Review the summary and click **Finish (a)**.

   <img src="images/GH-report-summary.png" width="800"/>

8. The report status bar shows blue (running).

   <img src="images/GH-report-running.png" width="800"/>

9. Once the report disappears from **Active**, click the **Completed (b)** tab.

   <img src="images/GH-report-completed-tab.png" width="800"/>

10. Confirm the status is **Complete (a)**, select your report **(b)**, and click **View (c)**.

    <img src="images/GH-report-selected.png" width="800"/>

11. The report opens showing the CPU anomaly and the top 10 longest running, most expensive, and most run queries.

    <img src="images/GH-report-output.png" width="800"/>

    Scroll down to the **Resource usage** chart and hover over the CPU spike *(a)*. This is the same spike observed in real-time monitoring.

    <img src="images/GH-report-cpu-spike.png" width="800"/>

12. Return to the Genius Hub tab and click **Share (b)**.

    <img src="images/GH-report-share.png" width="800"/>

13. Available sharing options:

    | Tab | Description |
    |---|---|
    | **URL** | Direct link — share with anyone who has Genius Hub console access |
    | **Python** | Embed in a Jupyter Notebook using an `IFrame` |
    | **JavaScript** | Dynamically inject the report into any web page |
    | **Html** | Embed using an `<iframe>` tag in any web page or markdown file |

    <img src="images/GH-report-share-dialog.png" width="400"/>

---

---

**[← Drill-Down Investigation](04-01-drill-down.md)** &nbsp;&nbsp;|&nbsp;&nbsp; **[→ Agentic AI Assistant](04-03-agentic-ai-assistant.md)**

---
