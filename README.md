# Coffee Sales SQL Analysis 

## Project Overview
This is a SQL project I worked on to practice data cleaning and analysis using a coffee sales dataset.  
The idea was to treat it like a real business case where a coffee shop wants to understand its sales, customers, and product performance.

I used MySQL to prepare the data and then wrote different queries to answer business questions such as:
- How much total revenue was generated?
- Which coffee types sold the most?
- Who are the top customers?
- What are the peak sales hours?
- How do sales change month by month?

---

# What I Did
1. Data Preparation
   - Split `datetime` into separate `date` and `time` columns.
   - Removed unnecessary columns.
   - Created a cleaner structure for analysis.

2. Sales Analysis
   - Total sales, average price, number of unique customers.
   - Daily and monthly sales trends.
   - Revenue split by cash vs. card.

3. Customer Insights
   - Top 10 customers by revenue.
   - Repeat purchases from card users.

4. Product Insights
   - Best-selling products by units and revenue.
   - Price change tracking over time.
   - Performance compared to average monthly sales.

5. Seasonality & Trends
   - Running totals to see growth.
   - Monthly seasonality report.
   - Peak sales hours.

---

Tools Used
- MySQL for queries and analysis
- CSV dataset (sample data) from Kaggle
