Brazilian E-Commerce Sales & Delivery Dashboard



A two-page Power BI dashboard analyzing ~99,000 orders from Olist, a Brazilian e-commerce marketplace, covering September 2016 – August 2018.



Overview


This project explores two core business questions:

How is the business growing? — revenue trends, top categories, and geographic concentration.

How well is the business delivering on its promise to customers? — on-time delivery performance and its relationship to customer satisfaction.

Data was cleaned using SQL before being modeled and visualized in Power BI.



Dashboard Preview

Sales Dashboard


<img width="1427" height="800" alt="image" src="https://github.com/user-attachments/assets/9cbb1223-6813-472a-b310-63df0dd74f30" />



Delivery Satisfaction Dashboard


<img width="1427" height="798" alt="image" src="https://github.com/user-attachments/assets/3df06b84-5214-4c5b-94f3-1aa131ebb421" />

Tools Used
SQL — exploratory analysis and data validation prior to modeling, including:
Aggregate functions (COUNT, SUM, AVG, ROUND)
Common Table Expressions (CTEs) for multi-step revenue breakdowns (order → yearly → monthly)
Window functions (DENSE_RANK()) for ranking sellers by revenue
CASE statements for on-time vs. late delivery categorization, compared against review scores
Multi-table JOINs across orders, customers, products, and sellers
Power BI — data modeling (star schema), DAX measures, dashboard design
DAX — custom measures for delivery performance, on-time rate, cancellation rate, and time-intelligence calculations

Dataset

Brazilian E-Commerce Public Dataset by Olist — a real, anonymized dataset of orders made on the Olist marketplace.

Dashboard Pages

Page 1 — Sales Growth

  KPIs: Total Sales, Average Review, Total Orders, Average Order Value
  
Monthly sales trend
  Top product categories by revenue
  Sales by state
  
Page 2 — Delivery & Satisfaction

  KPIs: On-Time Delivery %, Average Delivery Delay, Late Delivery %, Cancellation Rate
  Delivery delay trend over time
  On-time delivery rate by state
  Delivery delay vs. average review score (scatter)

Key Insights

Revenue grew steadily from late 2016 through mid-2018.

São Paulo (SP) alone drives roughly a third of total revenue.

Health & Beauty and Watches & Gifts are the top two product categories by revenue.

On-time delivery is strong overall (~95%), but longer delays are associated with lower review scores.

Paraná (PR) shows both the highest average delay and lowest on-time rate among higher-volume states.

The dataset's effective coverage ends around August 2018 — later months contain only a handful of stray records and were excluded from trend visuals to avoid misleading spikes/drops.


Author

Patrick John M. Lansangan



