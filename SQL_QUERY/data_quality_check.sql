-- Creating Tables

CREATE TABLE marketing_mix_raw(
	week_start DATE,
	week_id VARCAHR(10),
	market V,
	sales_unit,
	revenue_bdt_m,
	avg_price_bdt,
	promo_discount_pct,
	holiday_index,
	competitor_activity_index,
	tv_spend_bdt_m,
	search_spend_bdt_m,
	meta_spend_bdt_m,
	youtube_spend_bdt_m,
	ooh_spend_bdt_m,
);

-- Checking 

SELECT * 
FROM marketing_mix_raw
LIMIT 10;

-- Total row 
SELECT COUNT(*) AS total_row
FROM marketing_mix_raw;

-- Time preiod
SELECT 
	MIN(week_start) AS first_week,
	MAX(week_start) AS last_week,
	COUNT(*) AS total_rows
FROM marketing_mix_raw;

-- Check Unique week
SELECT 
	COUNT(*) AS total_rows,
	COUNT(DISTINCT week_id) AS unique_week_ds
FROM marketing_mix_raw;

-- Finding duplicate id & identify them
SELECT 
	COUNT(*) AS occurrences
FROM marketing_mix_raw
GROUP BY week_id
HAVING COUNT(*) >1;

SELECT 
	*
FROM marketing_mix_raw
WHERE week_id IN (
	SELECT week_id
	FROM marketing_mix_raw
	GROUP BY week_id
	HAVING COUNT(*) >1
)
ORDER BY week_id;

-- Check null or missing values

SELECT 
	COUNT(*) AS total_rows,
	COUNT(*) - COUNT(week_start) AS missing_week_start,
	COUNT(*) - COUNT(week_id) AS missing_week_id,
	COUNT(*) - COUNT(sales_unit) AS missing_sales_unit,
	COUNT(*) - COUNT(revenue_bdt_m) AS missing_revenue_bdt_m,
	COUNT(*) - COUNT(avg_price_bdt) AS missing_avg_price,
	COUNT(*) - COUNT(promo_discount_pct) AS missing_promo,
	COUNT(*) - COUNT(distribution_pct) AS missing_distribution,
	COUNT(*) - COUNT(holiday_index) AS missing_hoiliday,
	COUNT(*) - COUNT(competitor_activity_index) AS missing_competitor,
	COUNT(*) - COUNT(tv_spend_bdt_m) AS missing_tv,
	COUNT(*) - COUNT(search_spend_bdt_m) AS missing_search,
	COUNT(*) - COUNT(meta_spend_bdt_m) AS missing_meta,
	COUNT(*) - COUNT(youtube_spend_bdt_m) AS missing_youtube,
	COUNT(*) - COUNT(ooh_spend_bdt_m) AS missing_ooh
FROM marketing_mix_raw;

-- Find out them
SELECT *
FROM marketing_mix_raw
WHERE week_start IS NULL
	OR week_id IS NULL
	OR sales_unit IS NULL
	OR revenue_bdt_m IS NULL
	OR avg_price_bdt IS NULL
	OR promo_discount_pct IS NULL
	OR distribution_pct IS NULL
	OR holiday_index IS NULL
	OR competitor_activity_index IS NULL
	OR tv_spend_bdt_m IS NULL
	OR search_spend_bdt_m IS NULL
	OR meta_spend_bdt_m IS NULL
	OR youtube_spend_bdt_m IS NULL
	OR ooh_spend_bdt_m IS NULL;

-- Check impossible media spend

SELECT *
FROM marketing_mix_raw
WHERE tv_spend_bdt_m < 0
	OR search_spend_bdt_m < 0
	OR meta_spend_bdt_m < 0
	OR youtube_spend_bdt_m < 0
	OR ooh_spend_bdt_m < 0;

-- Validate percentage
SELECT *
FROM marketing_mix_raw
WHERE 
	promo_discount_pct < 0
	OR promo_discount_pct > 100
	OR distribution_pct < 0
	OR distribution_pct > 100;

SELECT *
FROM marketing_mix_raw
WHERE promo_discount_pct > 40;

-- Check hliday index
SELECT * 
FROM marketing_mix_raw
WHERE 
	holiday_index < 0
	OR holiday_index > 1;

-- Basic descriptive Statistics
SELECT 
	MIN(sales_unit) AS min_sales,
	MAX(sales_unit) AS max_sales,
	ROUND(AVG(sales_unit),2) AS avg_sales,
	MIN(avg_price_bdt),
	MAX(avg_price_bdt),
	ROUND(AVG(avg_price_bdt),2)
FROM marketing_mix_raw;

-- Media spend summary
SELECT
	ROUND(AVG(tv_spend_bdt_m),2) AS avg_tv,
	ROUND(AVG(search_spend_bdt_m),2) AS avg_search,
	ROUND(AVG(meta_spend_bdt_m),2) AS avg_meta,
	ROUND(AVG(youtube_spend_bdt_m),2) AS avg_youtube,
	ROUND(AVG(ooh_spend_bdt_m),2) AS avg_ooh
FROM marketing_mix_raw;

-- Total media investment
SELECT
	week_id,
	COALESCE(tv_spend_bdt_m,0) + 
	COALESCE(search_spend_bdt_m,0) +
	COALESCE(meta_spend_bdt_m,0) +
	COALESCE(youtube_spend_bdt_m,0) +
	COALESCE(ooh_spend_bdt_m,0) AS total_media_spend
FROM marketing_mix_raw
ORDER BY week_start;

-- Suspecious Sales observation
-- Highest saling products
SELECT 
	week_start,
	week_id,
	sales_unit,
	promo_discount_pct,
	holiday_index,
	tv_spend_bdt_m,
	search_spend_bdt_m,
	meta_spend_bdt_m
FROM marketing_mix_raw
ORDER BY 3 DESC
LIMIT 10;

-- Lowest selling products
SELECT 
	week_start,
	week_id,
	sales_unit,
	promo_discount_pct,
	holiday_index,
	tv_spend_bdt_m,
	search_spend_bdt_m,
	meta_spend_bdt_m
FROM marketing_mix_raw
ORDER BY 3 ASC
LIMIT 10;

-- Check missing weeks
WITH ordered_week AS (
	SELECT 
		week_start,
		LAG(week_start) OVER(ORDER BY week_start) AS previous_week
	FROM marketing_mix_raw
)
SELECT 
	week_start,
	previous_week,
	week_start - previous_week AS gap_days
FROM ordered_week
WHERE week_start - previous_week <> 7;

-- Check revenue consistency
SELECT
	week_id,
	sales_unit,
	avg_price_bdt,
	revenue_bdt_m,
	ROUND(
		sales_unit * avg_price_bdt / 1000000
		,2
	) AS calculated_revenue,
	ROUND(
		revenue_bdt_m - (sales_unit * avg_price_bdt / 1000000)
		,2
	) AS difference
FROM marketing_mix_raw
ORDER BY 6 DESC;

-- Check category

SELECT
	market,
	COUNT(*) AS records
FROM marketing_mix_raw
GROUP BY 1;