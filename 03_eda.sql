USE cfpb_complaints_db;

-- =====================================================
-- STEP 1: DATASET OVERVIEW
-- =====================================================

-- 1. Total Complaints
SELECT COUNT(*) AS total_complaints
FROM complaints;


-- 2. Complaint Date Range
SELECT
    MIN(date_received) AS first_complaint,
    MAX(date_received) AS latest_complaint
FROM complaints;


-- 3. Total Companies
SELECT COUNT(DISTINCT company) AS total_companies
FROM complaints;


-- 4. Total Products
SELECT COUNT(DISTINCT product) AS total_products
FROM complaints;


-- 5. Total Sub-Products
SELECT COUNT(DISTINCT sub_product) AS total_sub_products
FROM complaints;


-- 6. Total Issues
SELECT COUNT(DISTINCT issue) AS total_issues
FROM complaints;


-- 7. Total Sub-Issues
SELECT COUNT(DISTINCT sub_issue) AS total_sub_issues
FROM complaints;


-- 8. Total States
SELECT COUNT(DISTINCT state) AS total_states
FROM complaints;


-- 9. Submission Channels
SELECT COUNT(DISTINCT submitted_via) AS total_submission_channels
FROM complaints;


-- 10. Company Response Types
SELECT COUNT(DISTINCT company_response_to_consumer) AS total_response_types
FROM complaints;


-- 11. Company Public Responses
SELECT COUNT(DISTINCT company_public_response) AS total_public_response_types
FROM complaints;


-- 12. Timely Response Categories
SELECT COUNT(DISTINCT timely_response) AS total_timely_response_categories
FROM complaints;

-- =====================================================
-- STEP 2: DATA QUALITY ANALYSIS
-- =====================================================

USE cfpb_complaints_db;


-- 1. Check duplicate Complaint IDs
SELECT 
    complaint_id,
    COUNT(*) AS duplicate_count
FROM complaints
GROUP BY complaint_id
HAVING COUNT(*) > 1;


-- 2. Count duplicate Complaint IDs
SELECT 
    COUNT(*) AS duplicate_complaint_ids
FROM (
    SELECT complaint_id
    FROM complaints
    GROUP BY complaint_id
    HAVING COUNT(*) > 1
) d;


-- 3. Missing values by column
SELECT
    SUM(CASE WHEN complaint_id IS NULL THEN 1 ELSE 0 END) AS missing_complaint_id,
    SUM(CASE WHEN date_received IS NULL THEN 1 ELSE 0 END) AS missing_date_received,
    SUM(CASE WHEN product IS NULL OR product = '' THEN 1 ELSE 0 END) AS missing_product,
    SUM(CASE WHEN sub_product IS NULL OR sub_product = '' THEN 1 ELSE 0 END) AS missing_sub_product,
    SUM(CASE WHEN issue IS NULL OR issue = '' THEN 1 ELSE 0 END) AS missing_issue,
    SUM(CASE WHEN sub_issue IS NULL OR sub_issue = '' THEN 1 ELSE 0 END) AS missing_sub_issue,
    SUM(CASE WHEN consumer_complaint_narrative IS NULL OR consumer_complaint_narrative = '' THEN 1 ELSE 0 END) AS missing_narrative,
    SUM(CASE WHEN company_public_response IS NULL OR company_public_response = '' THEN 1 ELSE 0 END) AS missing_public_response,
    SUM(CASE WHEN company IS NULL OR company = '' THEN 1 ELSE 0 END) AS missing_company,
    SUM(CASE WHEN state IS NULL OR state = '' THEN 1 ELSE 0 END) AS missing_state,
    SUM(CASE WHEN zip_code IS NULL OR zip_code = '' THEN 1 ELSE 0 END) AS missing_zip_code,
    SUM(CASE WHEN tags IS NULL OR tags = '' THEN 1 ELSE 0 END) AS missing_tags,
    SUM(CASE WHEN submitted_via IS NULL OR submitted_via = '' THEN 1 ELSE 0 END) AS missing_submitted_via,
    SUM(CASE WHEN date_sent_to_company IS NULL THEN 1 ELSE 0 END) AS missing_date_sent_to_company,
    SUM(CASE WHEN company_response_to_consumer IS NULL OR company_response_to_consumer = '' THEN 1 ELSE 0 END) AS missing_company_response,
    SUM(CASE WHEN timely_response IS NULL OR timely_response = '' THEN 1 ELSE 0 END) AS missing_timely_response
FROM complaints;

-- 4. Invalid date check
SELECT 
    COUNT(*) AS invalid_date_received
FROM complaints
WHERE date_received = '0000-00-00 00:00:00'
   OR date_received IS NULL;
   
SELECT
    COUNT(*) AS invalid_date_received
FROM complaints
WHERE YEAR(date_received) = 0;

SELECT
    MIN(date_received) AS first_valid_complaint,
    MAX(date_received) AS latest_valid_complaint
FROM complaints;

SELECT
    MIN(date_received) AS first_valid_complaint,
    MAX(date_received) AS latest_valid_complaint
FROM complaints
WHERE YEAR(date_received) > 0;


-- 5. Valid date range only
SELECT
    MIN(date_sent_to_company) AS first_valid_date_sent,
    MAX(date_sent_to_company) AS latest_valid_date_sent
FROM complaints
WHERE YEAR(date_sent_to_company) > 0;


-- 6. Invalid date sent to company
SELECT
    COUNT(*) AS invalid_date_sent_to_company
FROM complaints
WHERE YEAR(date_sent_to_company) = 0;


-- 7. Blank string check
SELECT
    SUM(CASE WHEN TRIM(product) = '' THEN 1 ELSE 0 END) AS blank_product,
    SUM(CASE WHEN TRIM(issue) = '' THEN 1 ELSE 0 END) AS blank_issue,
    SUM(CASE WHEN TRIM(company) = '' THEN 1 ELSE 0 END) AS blank_company,
    SUM(CASE WHEN TRIM(state) = '' THEN 1 ELSE 0 END) AS blank_state,
    SUM(CASE WHEN TRIM(submitted_via) = '' THEN 1 ELSE 0 END) AS blank_submitted_via,
    SUM(CASE WHEN TRIM(timely_response) = '' THEN 1 ELSE 0 END) AS blank_timely_response
FROM complaints;


-- 8. Check values in timely_response
SELECT 
    timely_response,
    COUNT(*) AS complaint_count
FROM complaints
GROUP BY timely_response
ORDER BY complaint_count DESC;


-- 9. Check submission channels
SELECT 
    submitted_via,
    COUNT(*) AS complaint_count
FROM complaints
GROUP BY submitted_via
ORDER BY complaint_count DESC;


-- 10. Check company response categories
SELECT 
    company_response_to_consumer,
    COUNT(*) AS complaint_count
FROM complaints
GROUP BY company_response_to_consumer
ORDER BY complaint_count DESC;


-- 11. Data quality summary
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT complaint_id) AS unique_complaint_ids,
    COUNT(*) - COUNT(DISTINCT complaint_id) AS duplicate_rows,

    SUM(
        CASE
            WHEN YEAR(date_received) = 0 THEN 1
            ELSE 0
        END
    ) AS invalid_date_received,

    SUM(
        CASE
            WHEN YEAR(date_sent_to_company) = 0 THEN 1
            ELSE 0
        END
    ) AS invalid_date_sent_to_company

FROM complaints;

-- =====================================================
-- STEP 3 : COMPLAINT TREND ANALYSIS
-- =====================================================

-- 1. Complaints by Year
SELECT
    YEAR(date_received) AS complaint_year,
    COUNT(*) AS total_complaints
FROM complaints
WHERE YEAR(date_received) > 0
GROUP BY YEAR(date_received)
ORDER BY complaint_year;


-- 2. Complaints by Month
SELECT
    YEAR(date_received) AS complaint_year,
    MONTH(date_received) AS complaint_month,
    COUNT(*) AS total_complaints
FROM complaints
WHERE YEAR(date_received) > 0
GROUP BY
    YEAR(date_received),
    MONTH(date_received)
ORDER BY
    complaint_year,
    complaint_month;


-- 3. Complaints by Quarter
SELECT
    YEAR(date_received) AS complaint_year,
    QUARTER(date_received) AS complaint_quarter,
    COUNT(*) AS total_complaints
FROM complaints
WHERE YEAR(date_received) > 0
GROUP BY
    YEAR(date_received),
    QUARTER(date_received)
ORDER BY
    complaint_year,
    complaint_quarter;
    
-- =====================================================
-- STEP 4 : PRODUCT ANALYSIS
-- =====================================================

-- 1. Complaints by Product
SELECT
    product,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY product
ORDER BY total_complaints DESC;


-- 2. Top 10 Sub-Products
SELECT
    sub_product,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY sub_product
ORDER BY total_complaints DESC
LIMIT 10;


-- 3. Complaints by Product and Sub-Product
SELECT
    product,
    sub_product,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY
    product,
    sub_product
ORDER BY total_complaints DESC;


-- 4. Product Share (%)
SELECT
    product,
    COUNT(*) AS total_complaints,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM complaints),
        2
    ) AS complaint_percentage
FROM complaints
GROUP BY product
ORDER BY total_complaints DESC;

-- =====================================================
-- STEP 5 : ISSUE ANALYSIS
-- =====================================================

-- 1. Complaints by Issue
SELECT
    issue,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY issue
ORDER BY total_complaints DESC;


-- 2. Top 20 Sub-Issues
SELECT
    sub_issue,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY sub_issue
ORDER BY total_complaints DESC
LIMIT 20;


-- 3. Issue by Product
SELECT
    product,
    issue,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY
    product,
    issue
ORDER BY total_complaints DESC
LIMIT 50;


-- 4. Sub-Issue by Product
SELECT
    product,
    sub_issue,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY
    product,
    sub_issue
ORDER BY total_complaints DESC
LIMIT 50;

-- =====================================================
-- STEP 6 : COMPANY ANALYSIS
-- =====================================================

-- 1. Top 20 Companies by Complaint Volume
SELECT
    company,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY company
ORDER BY total_complaints DESC
LIMIT 20;


-- 2. Company Complaint Share (%)
SELECT
    company,
    COUNT(*) AS total_complaints,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM complaints),
        2
    ) AS complaint_percentage
FROM complaints
GROUP BY company
ORDER BY total_complaints DESC
LIMIT 20;


-- 3. Companies with Untimely Responses
SELECT
    company,
    COUNT(*) AS untimely_responses
FROM complaints
WHERE timely_response = 'No'
GROUP BY company
ORDER BY untimely_responses DESC
LIMIT 20;


-- 4. Companies by Response Type
SELECT
    company,
    company_response_to_consumer,
    COUNT(*) AS complaint_count
FROM complaints
GROUP BY
    company,
    company_response_to_consumer
ORDER BY complaint_count DESC
LIMIT 50;


-- 5. Companies Offering Monetary Relief
SELECT
    company,
    COUNT(*) AS monetary_relief_cases
FROM complaints
WHERE company_response_to_consumer = 'Closed with monetary relief'
GROUP BY company
ORDER BY monetary_relief_cases DESC
LIMIT 20;

-- =====================================================
-- STEP 7 : GEOGRAPHIC ANALYSIS
-- =====================================================

-- 1. Complaints by State
SELECT
    state,
    COUNT(*) AS total_complaints
FROM complaints
WHERE state IS NOT NULL
GROUP BY state
ORDER BY total_complaints DESC;


-- 2. Top 20 States
SELECT
    state,
    COUNT(*) AS total_complaints
FROM complaints
WHERE state IS NOT NULL
GROUP BY state
ORDER BY total_complaints DESC
LIMIT 20;


-- 3. Complaint Share by State
SELECT
    state,
    COUNT(*) AS total_complaints,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM complaints),
        2
    ) AS complaint_percentage
FROM complaints
WHERE state IS NOT NULL
GROUP BY state
ORDER BY total_complaints DESC;


-- 4. State-wise Product Analysis
SELECT
    state,
    product,
    COUNT(*) AS total_complaints
FROM complaints
WHERE state IS NOT NULL
GROUP BY
    state,
    product
ORDER BY total_complaints DESC
LIMIT 50;


-- 5. State-wise Issue Analysis
SELECT
    state,
    issue,
    COUNT(*) AS total_complaints
FROM complaints
WHERE state IS NOT NULL
GROUP BY
    state,
    issue
ORDER BY total_complaints DESC
LIMIT 50;


-- 6. State-wise Timely Response
SELECT
    state,
    timely_response,
    COUNT(*) AS complaint_count
FROM complaints
WHERE state IS NOT NULL
GROUP BY
    state,
    timely_response
ORDER BY complaint_count DESC
LIMIT 50;

-- =====================================================
-- STEP 8 : RESPONSE & RESOLUTION ANALYSIS
-- =====================================================

-- 1. Company Response Distribution
SELECT
    company_response_to_consumer,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY company_response_to_consumer
ORDER BY total_complaints DESC;


-- 2. Timely Response Distribution
SELECT
    timely_response,
    COUNT(*) AS total_complaints,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM complaints),
        2
    ) AS percentage
FROM complaints
GROUP BY timely_response
ORDER BY total_complaints DESC;


-- 3. Timely Response by Product
SELECT
    product,
    timely_response,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY
    product,
    timely_response
ORDER BY total_complaints DESC
LIMIT 50;


-- 4. Timely Response by Company
SELECT
    company,
    timely_response,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY
    company,
    timely_response
ORDER BY total_complaints DESC
LIMIT 50;


-- 5. Company Response by Product
SELECT
    product,
    company_response_to_consumer,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY
    product,
    company_response_to_consumer
ORDER BY total_complaints DESC
LIMIT 50;


-- 6. Company Response by State
SELECT
    state,
    company_response_to_consumer,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY
    state,
    company_response_to_consumer
ORDER BY total_complaints DESC
LIMIT 50;

-- =====================================================
-- STEP 9 : ADVANCED BUSINESS ANALYTICS
-- =====================================================

-- 1. Top 20 Companies with Highest Complaints
SELECT
    company,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY company
ORDER BY total_complaints DESC
LIMIT 20;


-- 2. Top 20 Products with Highest Complaints
SELECT
    product,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY product
ORDER BY total_complaints DESC
LIMIT 20;


-- 3. Top 20 States with Highest Complaints
SELECT
    state,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY state
ORDER BY total_complaints DESC
LIMIT 20;


-- 4. Complaint Percentage by Product
SELECT
    product,
    COUNT(*) AS total_complaints,
    ROUND(
        COUNT(*) * 100 / (SELECT COUNT(*) FROM complaints),
        2
    ) AS complaint_percentage
FROM complaints
GROUP BY product
ORDER BY total_complaints DESC;


-- 5. Top 10 Companies in Each Product (Window Function)
SELECT *
FROM (
    SELECT
        product,
        company,
        COUNT(*) AS total_complaints,
        DENSE_RANK() OVER (
            PARTITION BY product
            ORDER BY COUNT(*) DESC
        ) AS company_rank
    FROM complaints
    GROUP BY product, company
) ranked
WHERE company_rank <= 10;


-- 6. Top 10 Issues in Each Product
SELECT *
FROM (
    SELECT
        product,
        issue,
        COUNT(*) AS total_complaints,
        DENSE_RANK() OVER (
            PARTITION BY product
            ORDER BY COUNT(*) DESC
        ) AS issue_rank
    FROM complaints
    GROUP BY product, issue
) ranked
WHERE issue_rank <= 10;


-- 7. Year-over-Year Complaint Growth
SELECT
    YEAR(date_received) AS complaint_year,
    COUNT(*) AS total_complaints,
    LAG(COUNT(*)) OVER (ORDER BY YEAR(date_received)) AS previous_year,
    ROUND(
        (
            COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY YEAR(date_received))
        ) * 100.0 /
        LAG(COUNT(*)) OVER (ORDER BY YEAR(date_received)),
        2
    ) AS growth_percentage
FROM complaints
WHERE YEAR(date_received) > 0
GROUP BY YEAR(date_received)
ORDER BY complaint_year;


-- 8. Monthly Running Total
SELECT
    YEAR(date_received) AS complaint_year,
    MONTH(date_received) AS complaint_month,
    COUNT(*) AS monthly_complaints,
    SUM(COUNT(*)) OVER (
        ORDER BY YEAR(date_received), MONTH(date_received)
    ) AS cumulative_complaints
FROM complaints
WHERE YEAR(date_received) > 0
GROUP BY
    YEAR(date_received),
    MONTH(date_received)
ORDER BY
    complaint_year,
    complaint_month;


-- 9. Pareto Analysis (Top Companies)
SELECT
    company,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY company
ORDER BY total_complaints DESC
LIMIT 20;