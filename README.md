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

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

![SKU's at Risk](https://github.com/user-attachments/assets/128c7594-60b4-4ae7-994a-ff1254a8c9d6)


### Category 2:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

[![Average Forecast Error Rate by Product Type and Region](https://github.com/user-attachments/assets/a360d509-832e-45d1-a7df-0317009099ca)]


### Category 3:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

![Supplier EOQ vs Demand Analysis](https://github.com/user-attachments/assets/06bd78d3-93f1-46f3-847a-14f3b2eebf9a)


### Category 4:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

![Prioritizing SKU's Driving Holding Cost Disparity](https://github.com/user-attachments/assets/a497a9f7-3466-4814-85b7-48789e661b6b)


### Category 5:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

![Dead Stock Prioritization](https://github.com/user-attachments/assets/114aeb25-7656-484e-a435-3eb7bab47371)

# Recommendations:

![Inventory Optimization Recommendations](https://github.com/user-attachments/assets/7048ab86-bf64-4796-8a71-b82c4ab38af8)

Based on the insights and findings above, we would recommend the [Shiseido team] to consider the following: 

* Specific observation that is related to a recommended action. **Recommendation or general guidance based on this observation.**
  
* Specific observation that is related to a recommended action. **Recommendation or general guidance based on this observation.**
  
* Specific observation that is related to a recommended action. **Recommendation or general guidance based on this observation.**
  
* Specific observation that is related to a recommended action. **Recommendation or general guidance based on this observation.**
  
* Specific observation that is related to a recommended action. **Recommendation or general guidance based on this observation.**
  


# Assumptions and Caveats:

Throughout the analysis, multiple assumptions were made to manage challenges with the data. These assumptions and caveats are noted below:

* Assumption 1 (ex: missing country records were for customers based in the US, and were re-coded to be US citizens)
  
* Assumption 1 (ex: data for December 2021 was missing - this was imputed using a combination of historical trends and December 2020 data)
  
* Assumption 1 (ex: because 3% of the refund date column contained non-sensical dates, these were excluded from the analysis)
