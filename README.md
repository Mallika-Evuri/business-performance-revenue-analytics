# Business Performance & Revenue Analytics

## Overview

This project analyzes 397,884 cleaned retail transactions from the UCI Online Retail dataset to evaluate revenue growth, retention behavior, churn trends, and customer concentration.

The objective is to identify revenue drivers, retention gaps, and high-value customer segments using advanced SQL, Python-based analysis, and KPI-driven business modeling.

---

## Dataset

**Source:** UCI Online Retail Dataset  
**Raw Records:** 541,909  
**Cleaned Transactions:** 397,884  

### Data Cleaning Performed

- Removed records with missing `CustomerID`
- Excluded cancelled invoices (InvoiceNo starting with “C”)
- Removed negative quantities (returns)
- Removed zero or negative unit prices
- Created `Revenue = Quantity × UnitPrice`
- Generated monthly period column for time-series analysis

The cleaned dataset represents valid completed retail transactions suitable for revenue and retention analysis.

---

## KPI Framework

### Revenue Metrics
- Total Revenue
- Month-over-Month (MoM) Growth
- Average Order Value (AOV)
- Revenue by Region
- Contribution Margin (proxy)

### Customer Metrics
- Repeat Purchase Rate
- Cohort Retention Analysis
- Churn Trend
- Customer Lifetime Value (CLV proxy)

### Distribution & Concentration Analysis
- Customer revenue ranking
- Pareto analysis (Top 20% contribution)
- Revenue segmentation

---

## Key Business Insights

- Revenue is heavily concentrated among top customers (Pareto effect observed).
- Repeat purchase rate highlights dependence on returning buyers.
- Cohort analysis reveals noticeable retention decline after initial purchase months.
- Month-over-month growth fluctuates with identifiable peak seasons.
- Revenue concentration suggests targeted retention strategy can significantly impact growth.

---

## SQL Techniques Used

Advanced SQL queries were used to compute KPIs and business insights:

- Common Table Expressions (CTEs)
- Window functions (LAG, NTILE)
- Month-over-Month growth calculation
- Customer ranking and revenue segmentation
- Cohort retention modeling
- Pareto revenue contribution analysis

SQL file:
```
sql/business_performance_analysis.sql
```

---

## Notebook Analysis

The Jupyter Notebook includes:

- Data cleaning pipeline
- KPI computation
- Revenue trend analysis
- Repeat purchase calculation
- Cohort retention logic
- Pareto analysis
- Business interpretation summary

Notebook:
```
notebooks/business_analysis.ipynb
```

---

## Repository Structure

```
business-performance-revenue-analytics/
│
├── data/
│   └── cleaned_retail_transactions_sample.csv
│
├── notebooks/
│   └── business_analysis.ipynb
│
├── sql/
│   └── business_performance_analysis.sql
│
├── dashboard/
│   └── powerbi_dashboard_screenshot.png
│
├── requirements.txt
└── README.md
```

---

## Tools Used

- SQL
- Python (pandas, numpy)
- Matplotlib
- Power BI
- Google Colab

---

## Skills Demonstrated

- Advanced SQL analytics
- KPI framework design
- Revenue modeling
- Cohort retention analysis
- Pareto revenue analysis
- Business insight generation
- Data cleaning & transformation

---

## Business Impact Perspective

This project demonstrates how transactional data can be transformed into strategic business insights by:

- Identifying revenue concentration risk
- Quantifying retention drop-off
- Highlighting high-value customer segments
- Enabling data-driven growth and retention strategies
