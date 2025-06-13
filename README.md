# Inventory Optimization Request

**Company:** Shiseido
**To:** Data Analytics Team
**From:** Shiseido Operations & Supply Chain Leadership
**Subject:** Strategic Demand Planning Analysis Initiative
**Date:** April 3, 2025

As part of Shiseido’s continued commitment to operational excellence and responsive supply chain management, we are requesting an analytical deep dive into five critical areas of our demand planning process. The goal is to identify risks, improve forecast accuracy, reduce inefficiencies, and ultimately support better inventory and procurement decisions across our revive store locations.

## Insights and recommendations are provided on the following key areas:

- **Category 1:** Inventory Optimization 
- **Category 2:** Forecast Accuracy & Bias 
- **Category 3:** Supply Chain Cost Efficiency 
- **Category 4:** Cost to Serve / Holding Cost Analytics
- **Category 5:** Revenue Optimization
 

The SQL queries used to inspect and clean the data for this analysis can be found in [SQL Scripts Folder](https://github.com/SuaveAnalyst/Shiseido-Inventory-Review/tree/main/01_SQL_Scripts).

Targeted SQL queries regarding various business questions can be found here:

- **[Which SKUs are most at risk of stockouts by month?](https://github.com/SuaveAnalyst/Shiseido-Inventory-Review/blob/23f53acd2a940d77cf00f62f6d2dfeac651ba604/01_SQL_Scripts/Shiseido%20Script.sql#L16-L58)**
- **[How accurate were our forecasts vs. actual sales by product type and region?](https://github.com/SuaveAnalyst/Shiseido-Inventory-Review/blob/23f53acd2a940d77cf00f62f6d2dfeac651ba604/01_SQL_Scripts/Shiseido%20Script.sql#L60-L114)**
- **[What is the EOQ (Economic Order Quantity) for each supplier’s SKUs?](https://github.com/SuaveAnalyst/Shiseido-Inventory-Review/blob/ae00c968ddab3186ad1387c7fc9fefca693ec9fc/01_SQL_Scripts/Shiseido%20Script.sql#L115-L150)**
- **[How does holding cost vary by product type?](https://github.com/SuaveAnalyst/Shiseido-Inventory-Review/blob/2e671e48b30339f9f722093dbd50d3dddefb339a/01_SQL_Scripts/Shiseido%20Script.sql#L152-L181)**
- **[Which SKUs show the greatest risk of capital being tied up?](https://github.com/SuaveAnalyst/Shiseido-Inventory-Review/blob/dd24adb2943fb3349e3a8eecffee7d5084670060/01_SQL_Scripts/Shiseido%20Script.sql#L183-L231)**


An interactive Power BI dashboard used to report and explore sales trends can be found here:
### 📊 Shiseido Inventory Dashboard  [🔎 **View Interactive Power BI Dashboard**](https://app.powerbi.com/view?r=eyJrIjoiYjVhYWQzMzQtZGVkMy00MDM0LWI5YmMtMDg5MDJjNGQxY2U3IiwidCI6ImMyMDdhMmFjLWZiYjMtNDdkZC04OTU1LWQyODRjMDJkYWQ1OSJ9)



# Data Structure & Initial Checks

The company’s main database is structured around eight relational tables, each serving a specific function in tracking inventory operations, suppliers, shipping, and transactions. A total row count of 5129 records was observed. Below is a description of each table:

- **fact_inventorytransaction:** Central fact table capturing inventory movements, order volumes, costs, and shipment data.

- **dim_product:** Describes SKUs, product types, pricing, and holding rates.

- **dim_supplier:** Contains supplier metadata including names, locations, lead times, and ordering costs.

- **dim_shipping:** Stores shipping carriers, transportation modes, and route information.

- **dim_date:** Calendar dimension table used for date-based analysis (day, month, quarter, year, etc.).

- **dim_customer:** Provides customer segmentation data for fulfillment performance.

- **dim_inspection:** Tracks inspection outcomes relevant to product quality and compliance.

- **dim_inspection:** Contains quality assurance data, specifically inspection results tied to products and suppliers, enabling analysis of defect trends, compliance rates, and supplier reliability.

![image](https://github.com/user-attachments/assets/59ee072a-03be-4241-8b46-03200631702e)



# Executive Summary

### Overview of Findings

This inventory performance review for Shiseido identifies critical inefficiencies spanning SKU management, forecasting precision, and cost containment. The analysis revealed five core patterns impacting operational performance: excess stock accumulation in underperforming SKUs driven by misaligned reorder logic, forecasting bias concentrated in specific product-region combinations, and disproportionate EOQs that hinder supplier efficiency. Additionally, a significant share of holding costs is tied to a small subset of SKUs, while several products remain in stock long after their reorder thresholds have passed. These findings inform actionable recommendations to right-size inventory, enhance forecast accuracy, and improve overall cost-to-serve across Shiseido’s supply chain.

![Shiseido](https://github.com/user-attachments/assets/9d7c8fd6-c253-439d-a255-fce60eb02d61)



# Insights Deep Dive
### Category 1:

* **Main insight 1.** SKUs like SKU8 and SKU49 have not sold in 7+ months yet maintain excess stock of 600+ units, highlighting dead stock risk.
  
* **Main insight 2.** Items like SKU3 and SKU97 show recent sales but remain overstocked, indicating reorder misalignment.
  
* **Main insight 3.** ROP-based alerting can help categorize SKUs into understock / on-target / overstock.
  
![SKU's at Risk](https://github.com/user-attachments/assets/128c7594-60b4-4ae7-994a-ff1254a8c9d6)


### Category 2:

* **Main insight 1.** Cosmetics in Bangalore show the highest forecast error rate (10.24%), requiring model recalibration.
  
* **Main insight 2.** Skincare has the lowest error variability across regions, indicating stable and reliable demand patterns.
  
* **Main insight 3.** Chennai has moderate errors across all product types, suggesting possible regional forecast noise.

[![Average Forecast Error Rate by Product Type and Region](https://github.com/user-attachments/assets/a360d509-832e-45d1-a7df-0317009099ca)]


### Category 3:

* **Main insight 1.** SKU28 (S1) has an EOQ of 409 units with only ~1000 in annual demand, suggesting batch ordering or inefficiency.
  
* **Main insight 2.** SKU44 (S2) and SKU69 (S4) reflect well-balanced EOQ-to-demand ratios, supporting lean inventory strategies.
  
* **Main insight 3.**  Suppliers contributing to over-ordering patterns can be flagged using EOQ vs Demand plots.

![Supplier EOQ vs Demand Analysis](https://github.com/user-attachments/assets/06bd78d3-93f1-46f3-847a-14f3b2eebf9a)


### Category 4:

* **Main insight 1.** The top 10 SKUs account for 80%+ of cumulative holding cost, with SKU14, SKU41, and SKU52 leading.
  
* **Main insight 2.** These SKUs show high holding cost per unit, often driven by excess stock and slow turnover.
  
* **Main insight 3.** The Pareto threshold at 80% clearly segments cost-intensive inventory for targeted actions.

![Prioritizing SKU's Driving Holding Cost Disparity](https://github.com/user-attachments/assets/a497a9f7-3466-4814-85b7-48789e661b6b)


### Category 5:

* **Main insight 1.** Top 10 revenue-generating SKUs vary quarterly, indicating shifting demand and possible promotional effects.
  
* **Main insight 2.** Many high-revenue SKUs overlap with forecast error or excess stock, requiring dual optimization.
  
* **Main insight 3.** Cross-matching dead stock with revenue drivers highlights missed revenue recovery opportunities.

![Dead Stock Prioritization](https://github.com/user-attachments/assets/114aeb25-7656-484e-a435-3eb7bab47371)

# Recommendations:

![Inventory Optimization Recommendations](https://github.com/user-attachments/assets/7048ab86-bf64-4796-8a71-b82c4ab38af8)


# Assumptions and Caveats:

Throughout the analysis, multiple assumptions were made to manage challenges with the data. These assumptions and caveats are noted below:

* Assumption 1 (Missing demand or sales records for certain SKUs were assumed to represent zero demand, rather than data entry errors.)
  
* Assumption 2 (Products with no recorded transactions over time but positive stock balances were considered dead stock.)
  
* Assumption 1 (Forecast error was measured using available forecast vs. actual data without differentiating between over- and under-forecasting bias unless explicitly visualized.)
