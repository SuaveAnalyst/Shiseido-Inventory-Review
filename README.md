# Inventory Optimization Request

Company: Shiseido
To: Data Analytics Team
From: Shiseido Operations & Supply Chain Leadership
Subject: Strategic Demand Planning Analysis Initiative
Date: April 3, 2025

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

[![image](https://github.com/user-attachments/assets/59ee072a-03be-4241-8b46-03200631702e)
]



# Executive Summary

### Overview of Findings

Explain the overarching findings, trends, and themes in 2-3 sentences here. This section should address the question: "If a stakeholder were to take away 3 main insights from your project, what are the most important things they should know?" You can put yourself in the shoes of a specific stakeholder - for example, a marketing manager or finance director - to think creatively about this section.

[Visualization, including a graph of overall trends or snapshot of a dashboard]



# Insights Deep Dive
### Category 1:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

[Visualization specific to category 1]


### Category 2:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

[Visualization specific to category 2]


### Category 3:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

[Visualization specific to category 3]


### Category 4:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

[Visualization specific to category 4]



# Recommendations:

Based on the insights and findings above, we would recommend the [stakeholder team] to consider the following: 

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
