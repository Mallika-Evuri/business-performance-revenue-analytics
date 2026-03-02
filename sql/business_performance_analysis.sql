/* ============================================================
   BUSINESS PERFORMANCE & REVENUE ANALYTICS
   Dataset: Cleaned Retail Transactions
   ============================================================ */


/* ============================================================
   1️⃣ TOTAL REVENUE
   ============================================================ */

SELECT
    SUM(Revenue) AS total_revenue
FROM retail_transactions;



/* ============================================================
   2️⃣ MONTHLY REVENUE & MoM GROWTH
   Uses CTE + Window Function (LAG)
   ============================================================ */

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', InvoiceDate) AS month,
        SUM(Revenue) AS revenue
    FROM retail_transactions
    GROUP BY 1
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month) * 100,
        2
    ) AS mom_growth_pct
FROM monthly_revenue
ORDER BY month;



/* ============================================================
   3️⃣ AVERAGE ORDER VALUE (AOV)
   ============================================================ */

SELECT
    AVG(order_revenue) AS avg_order_value
FROM (
    SELECT
        InvoiceNo,
        SUM(Revenue) AS order_revenue
    FROM retail_transactions
    GROUP BY InvoiceNo
) t;



/* ============================================================
   4️⃣ REPEAT PURCHASE RATE
   ============================================================ */

WITH customer_orders AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS order_count
    FROM retail_transactions
    GROUP BY CustomerID
)

SELECT
    ROUND(
        SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS repeat_purchase_rate_pct
FROM customer_orders;



/* ============================================================
   5️⃣ CUSTOMER REVENUE RANKING (Window Function)
   ============================================================ */

SELECT
    CustomerID,
    SUM(Revenue) AS total_revenue,
    RANK() OVER (ORDER BY SUM(Revenue) DESC) AS revenue_rank
FROM retail_transactions
GROUP BY CustomerID
ORDER BY revenue_rank
LIMIT 20;



/* ============================================================
   6️⃣ TOP 20% REVENUE CONTRIBUTION (Pareto)
   ============================================================ */

WITH customer_revenue AS (
    SELECT
        CustomerID,
        SUM(Revenue) AS total_revenue
    FROM retail_transactions
    GROUP BY CustomerID
),
ranked_customers AS (
    SELECT
        CustomerID,
        total_revenue,
        NTILE(5) OVER (ORDER BY total_revenue DESC) AS revenue_quintile
    FROM customer_revenue
)

SELECT
    ROUND(
        SUM(CASE WHEN revenue_quintile = 1 THEN total_revenue END)
        / SUM(total_revenue) * 100,
        2
    ) AS top_20pct_revenue_share
FROM ranked_customers;



/* ============================================================
   7️⃣ COHORT RETENTION ANALYSIS
   ============================================================ */

WITH first_purchase AS (
    SELECT
        CustomerID,
        DATE_TRUNC('month', MIN(InvoiceDate)) AS cohort_month
    FROM retail_transactions
    GROUP BY CustomerID
),
customer_activity AS (
    SELECT
        r.CustomerID,
        DATE_TRUNC('month', r.InvoiceDate) AS activity_month,
        f.cohort_month
    FROM retail_transactions r
    JOIN first_purchase f
        ON r.CustomerID = f.CustomerID
)

SELECT
    cohort_month,
    activity_month,
    COUNT(DISTINCT CustomerID) AS active_customers
FROM customer_activity
GROUP BY cohort_month, activity_month
ORDER BY cohort_month, activity_month;
