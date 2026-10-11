-- DATA CLEANING
-- Inspect missing search value

SELECT
	week_start,
	week_id,
	search_spend_bdt_m
FROM marketing_mix_raw
WHERE week_id BETWEEN 'W021' AND 'WO25'
ORDER BY 1;

-- Missing Distribution
SELECT
	week_start,
	week_id,
	distribution_pct
FROM marketing_mix_raw
WHERE week_id BETWEEN 'W066' AND 'WO70'
ORDER BY 1;

-- Missing meta spend
SELECT
	week_start,
	week_id,
	meta_spend_bdt_m
FROM marketing_mix_raw
WHERE week_id BETWEEN 'W117' AND 'W121'
ORDER BY 1;

-- Negative OOH spend
SELECT
	week_start,
	week_id,
	ooh_spend_bdt_m
FROM marketing_mix_raw
WHERE week_id BETWEEN 'W043' AND 'WO47'
ORDER BY 1;

-- Check on 75% promotion
SELECT
	week_start,
	week_id,
	promo_discount_pct
FROM marketing_mix_raw
WHERE week_id BETWEEN 'W090' AND 'WO94'
ORDER BY 1;

-- Create a cleaning audit log
CREATE TABLE data_quality_log(
	issue_id SERIAL PRIMARY KEY,
	week_id VARCHAR(10),
	column_name VARCHAR(50),
	issue_type VARCHAR(100),
	orginal_value VARCHAR(50),
	replacement_value VARCHAR(50),
	action_taken VARCHAR(150),
	rationale TEXT
);

INSERT INTO data_quality_log(
	week_id,
	column_name,
	issue_type,
	orginal_value,
	replacement_value,
	action_taken,
	rationale
)
VALUES(
	'W023',
	'search_spend_bdt_m',
	'Missing value',
	'Null',
	'2.56',
	'Local Interpolation',
	'Isolated missing weekly media observation;
	interpret using adjacent weeks'
),
(
	'W068',
	'distribution_pct',
	'Missing value',
	'Null',
	'88.25',
	'Local Interpolation',
	'Isolated missing weekly media observation;
	interpret using adjacent weeks'
),
(
	'W119',
	'meta_spend_bdt_m',
	'Missing value',
	'Null',
	'3.15',
	'Local Interpolation',
	'Isolated missing weekly media observation;
	interpret using adjacent weeks'
),
(
	'W045',
	'ooh_spend_bdt_m',
	'Invalid negative value',
	'-0.80',
	'3.01',
	'Invalidated Local Interpolation',
	'Negative advertising expenditure is inconsistent with project business rule'
),
(
	'W092',
	'promo_discount_pct',
	'Business rule anomaly',
	'75',
	'0',
	'Replaced after local pattern review',
	'75% promotion is inconsistent with surrounding weeks
	and typical promotion level'
),
(
	'W030',
	'ROW',
	'Duplicate observation',
	'2 identical observations',
	'1 record',
	'Exact duplicate removed',
	'Both duplicate observations contained the same value'
);

SELECT *
FROM data_quality_log;

-- Create the clean dataset

DROP TABLE IF EXISTS
marketing_mix_clean;

CREATE TABLE marketing_mix_clean AS

WITH deduplicated AS(
	SELECT 
		*,
		ROW_NUMBER() OVER(PARTITION BY week_id ORDER BY week_start) AS row_num
	FROM marketing_mix_raw
),
base AS (
	SELECT
		week_start,
		week_id,
		market,
		sales_unit,
		revenue_bdt_m,
		avg_price_bdt,
		CASE
			WHEN promo_discount_pct < 0
				OR promo_discount_pct > 40
			THEN NULL
			ELSE promo_discount_pct
		END AS promo_valid,
		distribution_pct,
		holiday_index,
		competitor_activity_index,
		tv_spend_bdt_m,
		search_spend_bdt_m,
		meta_spend_bdt_m,
		youtube_spend_bdt_m,
		CASE
			WHEN ooh_spend_bdt_m < 0 THEN NULL
			ELSE ooh_spend_bdt_m
		END AS ooh_valid
	FROM deduplicated
	WHERE row_num = 1
),
neighbours AS (
	SELECT
		*,
		LAG(search_spend_bdt_m) OVER(ORDER BY week_start) AS previous_search,
		LEAD(search_spend_bdt_m) OVER(ORDER BY week_start) AS next_search,
		LAG(distribution_pct) OVER(ORDER BY week_start) AS previous_distribution,
		LEAD(distribution_pct) OVER(ORDER BY week_start) AS next_distribution,
		LAG(meta_spend_bdt_m) OVER(ORDER BY week_start) AS previous_meta,
		LEAD(meta_spend_bdt_m) OVER(ORDER BY week_start) AS next_meta,
		LAG(ooh_valid) OVER(ORDER BY week_start) AS previous_ooh,
		LEAD(ooh_valid) OVER(ORDER BY week_start) AS next_ooh
	FROM base
)
SELECT
	week_start,
	week_id,
	market,
	sales_unit,
	revenue_bdt_m,
	avg_price_bdt,
	CASE 
		WHEN week_id = 'W092' THEN 0
		ELSE promo_valid
	END AS promo_discount_pct,
	COALESCE(distribution_pct,
		ROUND((
			previous_distribution + next_distribution) / 2, 2)
		) AS distribution_pct,
	holiday_index,
	competitor_activity_index,
	tv_spend_bdt_m,
	COALESCE(search_spend_bdt_m,
		ROUND((
			previous_search + next_search) / 2, 2)
		) AS search_spend_bdt_m,
	COALESCE(meta_spend_bdt_m,
		ROUND((
			previous_meta + next_meta) / 2, 2)
		) AS meta_spend_bdt_m,
	youtube_spend_bdt_m,
	COALESCE(ooh_valid,
		ROUND((
			previous_ooh + next_ooh) / 2, 2)
		) AS ooh_spend_bdt_m
FROM neighbours
ORDER BY week_start;

-- Verify the corrected observation
SELECT
	week_id,
	search_spend_bdt_m,
	distribution_pct,
	meta_spend_bdt_m,
	promo_discount_pct,
	ooh_spend_bdt_m
FROM marketing_mix_clean
WHERE week_id IN (
	'W023',
	'W045',
	'W068',
	'W092',
	'W119',
	'W130'
)
ORDER BY week_id;

-- Final validation
SELECT 
	COUNT(*) AS total_row,
	COUNT(DISTINCT week_id) AS unique_week_id,
	COUNT(DISTINCT week_start) AS unique_week_date
FROM marketing_mix_clean;

-- Checking remaining null
SELECT 
	COUNT(*) FILTER(WHERE sales_unit IS NULL) AS missing_sales,
	COUNT(*) FILTER(WHERE avg_price_bdt IS NULL) AS missing_price,
	COUNT(*) FILTER(WHERE promo_discount_pct IS NULL) AS missing_promo,
	COUNT(*) FILTER(WHERE distribution_pct IS NULL) AS missing_distribution,
	COUNT(*) FILTER(WHERE tv_spend_bdt_m IS NULL) AS missing_tv,
	COUNT(*) FILTER(WHERE search_spend_bdt_m IS NULL) AS missing_search,
	COUNT(*) FILTER(WHERE meta_spend_bdt_m IS NULL) AS missing_meta,
	COUNT(*) FILTER(WHERE youtube_spend_bdt_m IS NULL) AS missing_youtube,
	COUNT(*) FILTER(WHERE ooh_spend_bdt_m IS NULL) AS missing_ooh
FROM marketing_mix_clean;

-- Check impossible values
SELECT 
FROM marketing_mix_clean
WHERE 
	tv_spend_bdt_m < 0
	OR search_spend_bdt_m < 0
	OR meta_spend_bdt_m < 0
	OR youtube_spend_bdt_m < 0
	OR ooh_spend_bdt_m < 0
	OR promo_discount_pct < 0
	OR promo_discount_pct > 40
	OR distribution_pct < 0
	OR distribution_pct > 100
	OR holiday_index < 0
	OR holiday_index < 0;

-- Recheck missing week
-- Check missing weeks
WITH ordered_week AS (
	SELECT 
		week_start,
		LAG(week_start) OVER(ORDER BY week_start) AS previous_week
	FROM marketing_mix_clean
)
SELECT 
	week_start,
	previous_week,
	week_start - previous_week AS gap_days
FROM ordered_week
WHERE week_start - previous_week <> 7;

-- Add constraints in database

ALTER TABLE marketing_mix_clean
	ADD CONSTRAINT pk_marketing_mix_clean
	PRIMARY KEY(week_id),
	ADD CONSTRAINT uq_marketing_mix_week
	UNIQUE(week_start),
	ADD CONSTRAINT chk_sales_postive
	CHECK(sales_unit >= 0),
	ADD CONSTRAINT chk_price_postive
	CHECK(avg_price_bdt >= 0),
	ADD CONSTRAINT chk_promotion
	CHECK(promo_discount_pct BETWEEN 0 AND 40),
	ADD CONSTRAINT chk_distribution
	CHECK(distribution_pct BETWEEN 0 AND 100),
	ADD CONSTRAINT chk_holiday
	CHECK(holiday_index BETWEEN 0 AND 1),
	ADD CONSTRAINT chk_media_spend
	CHECK(
		tv_spend_bdt_m >= 0
		AND search_spend_bdt_m >= 0
		AND meta_spend_bdt_m >= 0
		AND youtube_spend_bdt_m >= 0
		AND ooh_spend_bdt_m >= 0
	);