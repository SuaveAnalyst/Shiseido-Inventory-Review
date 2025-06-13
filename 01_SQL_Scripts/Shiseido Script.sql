/*
Ad Hoc Report Description Script: "Demand Planning Intelligence – Operational Snapshot"

At Shiseido, aligning supply with demand is critical to maintaining customer satisfaction 
while managing costs. The following ad hoc report has been prepared to support key operational 
decisions by identifying performance gaps, cost inefficiencies, and top opportunities across the supply chain.

This report answers five strategic business questions designed to support the Demand Planning and Inventory Management teams:
	•	Which SKUs are most at risk of stockouts by month?
	•	How accurate were our forecasts vs. actual sales by product type and region?
	•	What is the EOQ (Economic Order Quantity) for each supplier’s SKUs?
	•	How does holding cost vary by product type?
	•	What are the top 10 revenue-driving SKUs per quarter?
*/

-- ######################################
-- [KPI 1] SKU Stockout Risk by Month
-- ######################################

CREATE OR REPLACE VIEW vw_SKU_Stockout_Risk_By_Month AS
SELECT 
    d.YearMonth,
    f.SKU,
    f.StockLevel,
    f.ProductsSold,
    ROUND((f.StockLevel / NULLIF(f.ProductsSold, 0)) * 100, 1) AS StockCoverPct,
    CASE 
        WHEN (f.StockLevel / NULLIF(f.ProductsSold, 0)) < 0.5 THEN 'High Risk'
        WHEN (f.StockLevel / NULLIF(f.ProductsSold, 0)) BETWEEN 0.5 AND 1.0 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS StockoutRiskLevel
FROM 
    Fact_InventoryTransaction f
JOIN Dim_Date d ON f.DateKey = d.DateKey
WHERE 
    f.ProductsSold > 0;


-- [KPI 1B] Stockout Risk Rate by Product Type
CREATE OR REPLACE VIEW vw_Stockout_Risk_Rate_By_ProductType AS
SELECT 
    d.YearMonth,
    p.ProductType,
    COUNT(CASE WHEN f.StockLevel < f.OrderQty THEN 1 END) AS StockoutCount,
    COUNT(*) AS TotalSKUs,
    ROUND(COUNT(CASE WHEN f.StockLevel < f.OrderQty THEN 1 END) / COUNT(*) * 100, 2) AS StockoutRatePct,
    CASE
        WHEN COUNT(CASE WHEN f.StockLevel < f.OrderQty THEN 1 END) / COUNT(*) < 0.5 THEN 'Low Risk'
        WHEN COUNT(CASE WHEN f.StockLevel < f.OrderQty THEN 1 END) / COUNT(*) BETWEEN 0.5 AND 1 THEN 'Medium Risk'
        ELSE 'High Risk'
    END AS StockoutRiskLevel
FROM 
    Fact_InventoryTransaction f
JOIN Dim_Product p ON f.SKU = p.SKU
JOIN Dim_Date d ON f.DateKey = d.DateKey
GROUP BY 
    d.YearMonth, p.ProductType;


-- ######################################
-- [KPI 2] Forecast Accuracy by Region & Gender
-- ######################################

CREATE OR REPLACE VIEW vw_Forecast_Accuracy_By_Region AS
SELECT 
    d.YearMonth,
    p.ProductType,
    s.Location AS SupplierRegion,
    SUM(f.ProductsSold) AS ActualSales,
    ROUND(SUM(f.ProductsSold) * 1.1, 0) AS ForecastedSales,
    ROUND(ABS(ROUND(SUM(f.ProductsSold) * 1.1, 0) - SUM(f.ProductsSold)) / NULLIF(SUM(f.ProductsSold), 0), 2) AS ForecastErrorRate
FROM 
    Fact_InventoryTransaction f
JOIN Dim_Product p ON f.SKU = p.SKU
JOIN Dim_Date d ON f.DateKey = d.DateKey
JOIN Dim_Supplier s ON f.SupplierKey = s.SupplierKey
GROUP BY 
    d.YearMonth, p.ProductType, s.Location;

-- Forecast Accuracy by Gender
CREATE OR REPLACE VIEW vw_Forecast_Accuracy_By_Gender AS
SELECT 
    d.YearMonth,
    p.ProductType,
    c.Demographics AS CustomerGender,
    SUM(f.ProductsSold) AS ActualSales,
    ROUND(SUM(f.ProductsSold) * 1.1, 0) AS ForecastedSales,
    ROUND(ABS(SUM(f.ProductsSold * 1.1) - SUM(f.ProductsSold)) / NULLIF(SUM(f.ProductsSold), 0), 2) AS ForecastErrorRate
FROM 
    Fact_InventoryTransaction f
JOIN Dim_Product p ON f.SKU = p.SKU
JOIN Dim_Date d ON f.DateKey = d.DateKey
JOIN Dim_Customer c ON f.CustomerKey = c.CustomerKey
GROUP BY 
    d.YearMonth, p.ProductType, c.Demographics;

-- Forecast Bias Overview
CREATE OR REPLACE VIEW vw_Forecast_Bias_Overview AS
SELECT 
    d.YearMonth,
    p.ProductType,
    ROUND(SUM(f.ProductsSold * 1.1 - f.ProductsSold), 0) AS ForecastBias,
    CASE 
        WHEN SUM(f.ProductsSold * 1.1 - f.ProductsSold) > 0 THEN 'Overforecast'
        WHEN SUM(f.ProductsSold * 1.1 - f.ProductsSold) < 0 THEN 'Underforecast'
        ELSE 'Accurate'
    END AS ForecastBiasType
FROM 
    Fact_InventoryTransaction f
JOIN Dim_Product p ON f.SKU = p.SKU
JOIN Dim_Date d ON f.DateKey = d.DateKey
GROUP BY 
    d.YearMonth, p.ProductType;

-- ######################################
-- [KPI 3] Economic Order Quantity (EOQ)
-- ######################################
CREATE OR REPLACE VIEW vw_EOQ_By_SKU AS
SELECT 
    f.SKU,
    s.SupplierName,
    SUM(f.ProductsSold) AS AnnualDemand,
    s.OrderingCost,
    p.Price * p.HoldingRate AS HoldingCostPerUnit,
    ROUND(SQRT((2 * s.OrderingCost * SUM(f.ProductsSold)) / (p.Price * p.HoldingRate)), 2) AS EOQ
FROM 
    Fact_InventoryTransaction f
JOIN Dim_Supplier s ON f.SupplierKey = s.SupplierKey
JOIN Dim_Product p ON f.SKU = p.SKU
WHERE
    f.ProductsSold > 0
GROUP BY 
    f.SKU, s.SupplierName, s.OrderingCost, p.Price, p.HoldingRate;


-- EOQ Summary by Product Type
CREATE OR REPLACE VIEW vw_EOQ_Summary_By_ProductType AS
SELECT 
    p.ProductType,
    COUNT(DISTINCT f.SKU) AS NumSKUs,
    ROUND(AVG(SQRT((2 * s.OrderingCost * f.ProductsSold) / (p.Price * p.HoldingRate))), 0) AS AvgEOQ
FROM 
    Fact_InventoryTransaction f
JOIN Dim_Product p ON f.SKU = p.SKU
JOIN Dim_Supplier s ON f.SupplierKey = s.SupplierKey
WHERE 
    f.ProductsSold > 0
GROUP BY 
    p.ProductType;


-- ######################################
-- [KPI 4] Holding Cost Variation
-- ######################################
CREATE OR REPLACE VIEW vw_HoldingCost_Summary_By_ProductType AS
SELECT
    p.ProductType,
    COUNT(*) AS NumSKUs,
    MIN(p.HoldingRate) AS MinHoldingRate,
    MAX(p.HoldingRate) AS MaxHoldingRate,
    ROUND(AVG(p.HoldingRate), 3) AS AvgHoldingRate,
    MIN(p.Price) AS MinPrice,
    MAX(p.Price) AS MaxPrice,
    ROUND(AVG(p.Price), 2) AS AvgPrice,
    ROUND(SUM(p.HoldingRate * p.Price), 2) AS TotalHoldingCost,
    ROUND(AVG(p.HoldingRate * p.Price), 2) AS AvgHoldingCostPerUnit
FROM Dim_Product p
GROUP BY p.ProductType
ORDER BY AvgHoldingCostPerUnit DESC;


-- Detailed Holding Cost by SKU
CREATE OR REPLACE VIEW vw_HoldingCost_By_SKU AS
SELECT 
    p.SKU,
    p.ProductType,
    ROUND(p.HoldingRate * p.Price, 2) AS HoldingCostPerUnit,
    ROUND((p.HoldingRate * p.Price) / NULLIF(p.Price, 0) * 100, 2) AS HoldingCostPct
FROM Dim_Product p
ORDER BY HoldingCostPct DESC;


-- ######################################
-- [KPI 5] Top Revenue-Generating SKUs
-- ######################################
CREATE OR REPLACE VIEW vw_QuarterlyRevenue_By_SKU AS
SELECT 
    d.Year,
    d.Quarter,
    f.SKU,
    SUM(f.Revenue) AS TotalRevenue
FROM Fact_InventoryTransaction f
JOIN Dim_Date d ON f.DateKey = d.DateKey
GROUP BY d.Year, d.Quarter, f.SKU
ORDER BY d.Year, d.Quarter, TotalRevenue DESC;


-- Rolling 3-Month Revenue Trend
CREATE OR REPLACE VIEW vw_Rolling3MonthRevenue_By_SKU AS
WITH RevenueBySKU AS (
    SELECT
        f.SKU,
        d.YearMonth,
        SUM(f.Revenue) AS MonthlyRevenue
    FROM Fact_InventoryTransaction f
    JOIN Dim_Date d ON f.DateKey = d.DateKey
    GROUP BY f.SKU, d.YearMonth
),
RollingRevenue AS (
    SELECT
        r.SKU,
        r.YearMonth,
        r.MonthlyRevenue,
        ROUND(
            SUM(r.MonthlyRevenue) OVER (
                PARTITION BY r.SKU
                ORDER BY r.YearMonth
                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
            ), 2
        ) AS Rolling3MonthRevenue,
        ROW_NUMBER() OVER (PARTITION BY r.SKU ORDER BY r.YearMonth DESC) AS RowNum
    FROM RevenueBySKU r
)
SELECT 
    SKU, 
    YearMonth, 
    MonthlyRevenue, 
    Rolling3MonthRevenue
FROM RollingRevenue
WHERE RowNum = 1
ORDER BY Rolling3MonthRevenue DESC;


/*
HEALTH CHECK ACROSS INVENTORY, SUPPLIER PERFORMANCE, LOGISTICS, AND COST CONTROL.
*/

-- Inventory Turnover Ratio by Product Type
CREATE OR REPLACE VIEW vw_InventoryTurnover_ByProductType AS
SELECT 
    p.ProductType,
    ROUND(SUM(f.ProductsSold) / NULLIF(SUM(f.StockLevel), 0), 2) AS InventoryTurnover
FROM 
    Fact_InventoryTransaction f
JOIN Dim_Product p ON f.SKU = p.SKU
GROUP BY 
    p.ProductType
ORDER BY 
    InventoryTurnover DESC;

    
-- Average Lead Time by Supplier
CREATE OR REPLACE VIEW vw_AvgLeadTime_BySupplier AS
SELECT 
    s.SupplierName,
    s.Location,
    ROUND(AVG(s.LeadTime), 1) AS AvgLeadTime_Days
FROM 
    Dim_Supplier s
GROUP BY 
    s.SupplierName, s.Location
ORDER BY 
    AvgLeadTime_Days DESC; -- Highlights which suppliers slow down fulfillment.

-- Top 5 Suppliers by Total Product Value Supplied
CREATE OR REPLACE VIEW vw_TopSuppliers_ByTotalValue AS
SELECT 
    s.SupplierName,
    SUM(f.ProductsSold * p.Price) AS TotalValueSupplied
FROM 
    Fact_InventoryTransaction f
JOIN Dim_Supplier s ON f.SupplierKey = s.SupplierKey
JOIN Dim_Product p ON f.SKU = p.SKU
GROUP BY 
    s.SupplierName
ORDER BY 
    TotalValueSupplied DESC; -- Reveals strategic supplier dependencies.

--  Order Fulfillment Efficiency
CREATE OR REPLACE VIEW vw_OrderFulfillmentEfficiency AS
SELECT 
    COUNT(*) AS TotalOrders,
    COUNT(CASE WHEN f.StockLevel >= f.OrderQty THEN 1 END) AS OrdersFulfilledOnTime,
    ROUND(COUNT(CASE WHEN f.StockLevel >= f.OrderQty THEN 1 END) / COUNT(*) * 100, 2) AS FulfillmentRatePct
FROM 
    Fact_InventoryTransaction f; -- KPI to monitor fulfillment accuracy.
    
-- Demand vs. Supply Gap by Product Type
CREATE OR REPLACE VIEW vw_DemandSupplyGap_ByProductType AS
SELECT 
    p.ProductType,
    SUM(f.OrderQty) AS TotalOrdered,
    SUM(f.StockLevel) AS TotalStockAvailable,
    SUM(f.OrderQty - f.StockLevel) AS DemandSupplyGap
FROM 
    Fact_InventoryTransaction f
JOIN Dim_Product p ON f.SKU = p.SKU
GROUP BY 
    p.ProductType
ORDER BY 
    DemandSupplyGap DESC; -- Identifies where demand exceeds supply, risk of lost sales.

-- Shipping Lead Time Reliability
CREATE OR REPLACE VIEW vw_ShippingLeadTimeReliability AS
SELECT
    s.ShippingCarriers,
    COUNT(*) AS TotalShipments,
    ROUND(
        AVG(CASE 
            WHEN f.ActualShipDate <= f.PlannedShipDate THEN 1 
            ELSE 0 
        END) * 100, 2
    ) AS OnTimeShippingPct
FROM
    fact_inventorytransaction f
JOIN 
    dim_shipping s ON f.ShippingKey = s.ShippingKey
GROUP BY
    s.ShippingCarriers
ORDER BY
    OnTimeShippingPct DESC;


-- Average Delay per Shipping Carrier
CREATE OR REPLACE VIEW vw_AvgDelay_ByShippingCarrier AS
SELECT
    s.ShippingCarriers,
    COUNT(*) AS TotalShipments,
    ROUND(AVG(DATEDIFF(f.ActualShipDate, f.PlannedShipDate)), 2) AS AvgDelay_Days
FROM
    fact_inventorytransaction f
JOIN 
    dim_shipping s ON f.ShippingKey = s.ShippingKey
WHERE 
    f.ActualShipDate IS NOT NULL 
    AND f.PlannedShipDate IS NOT NULL
GROUP BY
    s.ShippingCarriers
ORDER BY
    AvgDelay_Days DESC; -- Positive values = Late deliveries, Negative values = Early deliveries, Zero = On time

-- On-Time Delivery by Route
CREATE OR REPLACE VIEW vw_OnTimeDelivery_ByRoute AS
SELECT
    s.Routes,
    COUNT(*) AS TotalShipments,
    ROUND(AVG(CASE 
        WHEN f.ActualShipDate <= f.PlannedShipDate THEN 1 
        ELSE 0 
    END) * 100, 2) AS OnTimePct
FROM
    fact_inventorytransaction f
JOIN 
    dim_shipping s ON f.ShippingKey = s.ShippingKey
GROUP BY
    s.Routes
ORDER BY
    OnTimePct DESC;


-- Monthly Shipping Punctuality Trend
CREATE OR REPLACE VIEW vw_MonthlyShippingPunctualityTrend AS
SELECT
    d.YearMonth,
    ROUND(AVG(CASE 
        WHEN f.ActualShipDate <= f.PlannedShipDate THEN 1 
        ELSE 0 
    END) * 100, 2) AS OnTimePct
FROM
    fact_inventorytransaction f
JOIN 
    dim_date d ON f.DateKey = d.DateKey
GROUP BY
    d.YearMonth
ORDER BY
    d.YearMonth;


-- Deadstock Detection (no sales in past 3 months)
CREATE OR REPLACE VIEW vw_DeadstockDetection AS
SELECT 
    f.SKU,
    MAX(d.YearMonth) AS LastSoldMonth
FROM 
    fact_inventorytransaction f
JOIN dim_date d ON f.DateKey = d.DateKey
WHERE 
    f.ProductsSold > 0
GROUP BY 
    f.SKU
HAVING 
    MAX(d.YearMonth) < '202401';


-- Lead Time Volatility
CREATE OR REPLACE VIEW vw_LeadTimeVolatility_BySupplier AS
SELECT 
    s.SupplierName,
    ROUND(STDDEV(f.LeadTimes), 2) AS LeadTimeVolatility
FROM 
    fact_inventorytransaction f
JOIN dim_supplier s ON f.SupplierKey = s.SupplierKey
GROUP BY 
    s.SupplierName
ORDER BY 
    LeadTimeVolatility DESC; -- Shows supplier inconsistency
