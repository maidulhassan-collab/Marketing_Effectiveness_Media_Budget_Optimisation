# Marketing Effectiveness & Media Budget Optimisation

<p align="center">
  <b>An End-to-End Marketing Mix Modelling, Econometric Analysis & Budget Optimisation Project</b>
</p>

<p align="center">
  PostgreSQL • SQL • Python • Pandas • NumPy • Statsmodels • SciPy • Matplotlib
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Python-Analytics-3776AB?logo=python&logoColor=white" alt="Python">
  <img src="https://img.shields.io/badge/PostgreSQL-Database-4169E1?logo=postgresql&logoColor=white" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/Pandas-Data%20Analysis-150458?logo=pandas&logoColor=white" alt="Pandas">
  <img src="https://img.shields.io/badge/Statsmodels-Econometrics-4B8BBE" alt="Statsmodels">
  <img src="https://img.shields.io/badge/SciPy-Optimisation-8CAAE6?logo=scipy&logoColor=white" alt="SciPy">
</p>

![Overview](https://github.com/maidulhassan-collab/Marketing_Effectiveness_Media_Budget_Optimisation/blob/main/presentation_dash_gif.gif)

---

## Executive Summary

Marketing teams often invest across multiple channels without a clear view of how much each channel contributes to **incremental sales**, where **diminishing returns** begin, or whether the existing media mix is efficient.

This project builds an end-to-end **Marketing Mix Modelling (MMM)** framework using a synthetic but business-realistic weekly dataset. The analysis combines **PostgreSQL, Python, econometrics, adstock, saturation, counterfactual attribution, ROAS analysis, response curves, and constrained optimisation**.

The central business question is:

> **Can the existing media budget be reallocated more efficiently without increasing total spend?**

Under a practical ±30% channel-level reallocation constraint, the model estimates an approximately **11.5% uplift in media-driven sales while keeping the total media budget unchanged**.

> **Important:** This is a model-estimated scenario based on synthetic portfolio data. It is not a guaranteed business outcome and does not represent any real organisation.

---

## Table of Contents

- [Business Problem](#business-problem)
- [Project Objectives](#project-objectives)
- [Dataset](#dataset)
- [Technology Stack](#technology-stack)
- [Repository Structure](#repository-structure)
- [Analytical Workflow](#analytical-workflow)
- [1. Data Quality Validation](#1-data-quality-validation)
- [2. Data Cleaning & Preparation](#2-data-cleaning--preparation)
- [3. Exploratory Data Analysis](#3-exploratory-data-analysis)
- [4. Econometric Sales Model](#4-econometric-sales-model)
- [5. Model Diagnostics](#5-model-diagnostics)
- [6. Adstock](#6-adstock)
- [7. Saturation](#7-saturation)
- [8. Marketing Mix Model](#8-marketing-mix-model)
- [9. Baseline vs Incremental Sales](#9-baseline-vs-incremental-sales)
- [10. Channel Contribution](#10-channel-contribution)
- [11. ROAS Analysis](#11-roas-analysis)
- [12. Response Curves & Marginal Returns](#12-response-curves--marginal-returns)
- [13. Budget Optimisation](#13-budget-optimisation)
- [14. Sensitivity Analysis](#14-sensitivity-analysis)
- [Key Business Recommendations](#key-business-recommendations)
- [Limitations](#limitations)
- [How to Run the Project](#how-to-run-the-project)
- [Project Deliverables](#project-deliverables)
- [Skills Demonstrated](#skills-demonstrated)
- [Interview-Ready Project Summary](#interview-ready-project-summary)
- [Future Enhancements](#future-enhancements)
- [Author](#author)
- [Disclaimer](#disclaimer)

---

# Business Problem

The hypothetical business invests across five media channels:

- TV
- Paid Search
- Meta
- YouTube
- Out-of-Home (OOH)

Management wants to understand:

- What drives weekly sales?
- How much incremental sales does each media channel generate?
- Which channels appear most efficient?
- Where do diminishing returns occur?
- Which channels may be over- or under-funded?
- Can the existing budget be reallocated to improve sales without increasing total spend?

The goal of the project is therefore to convert historical marketing data into a **measurable, decision-oriented media allocation strategy**.

---

# Project Objectives

The project was designed to:

1. Build a reliable analytical dataset from raw weekly marketing data.
2. Validate data quality before modelling.
3. Identify important business and marketing drivers of sales.
4. Build an econometric sales model with trend and seasonality controls.
5. Capture advertising carryover using **adstock**.
6. Capture diminishing returns using **saturation**.
7. Compare model specifications.
8. Estimate baseline and incremental media-driven sales.
9. Estimate channel-level contribution using counterfactual prediction.
10. Calculate historical media efficiency and ROAS.
11. Build media response curves.
12. Estimate marginal returns at current spending levels.
13. Optimise the media budget under realistic constraints.
14. Translate model outputs into business recommendations.

---

# Dataset

This project uses a **synthetic, business-realistic weekly marketing dataset** created for educational and portfolio purposes.

| Dataset Characteristic | Value |
|---|---:|
| Frequency | Weekly |
| Time span | ~3 years |
| Observations | 156 weeks |
| Media channels | 5 |
| Primary KPI | Sales Units |

## Primary KPI

- `Sales_Units`

## Media Variables

- `TV_Spend_BDT_M`
- `Search_Spend_BDT_M`
- `Meta_Spend_BDT_M`
- `YouTube_Spend_BDT_M`
- `OOH_Spend_BDT_M`

## Business / Control Variables

- `Avg_Price_BDT`
- `Promo_Discount_Pct`
- `Distribution_Pct`
- `Holiday_Index`
- `Competitor_Activity_Index`
- `Revenue_BDT_M`

Additional engineered variables include:

- Trend
- Seasonal Fourier terms
- Adstocked media
- Saturated media
- Baseline sales
- Incremental media contribution
- Marginal response

> The dataset does not contain confidential information from any real organisation.

---

# Technology Stack

| Area | Tools |
|---|---|
| Database | PostgreSQL |
| Querying | SQL |
| Data Manipulation | Python, Pandas, NumPy |
| Statistical Modelling | Statsmodels |
| Optimisation | SciPy |
| Visualisation | Matplotlib |
| Development | Jupyter Notebook |
| Documentation | Word / PDF |
| Presentation | PowerPoint |

---

# Repository Structure

```text
marketing-effectiveness-media-optimisation/
│
├── data/
│   ├── marketing_mix_raw.csv
│   └── marketing_mix_clean.csv
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_data_quality_checks.sql
│   └── 03_data_cleaning.sql
│
├── notebooks/
│   ├── 01_exploratory_data_analysis.ipynb
│   ├── 02_regression_econometrics.ipynb
│   └── 03_marketing_mix_model.ipynb
│
├── outputs/
│   ├── figures/
│   │   ├── 01_sales_trend.png
│   │   ├── 05_model_comparison.png
│   │   ├── 08_baseline_media.png
│   │   ├── 09_spend_contribution.png
│   │   ├── 10_roas.png
│   │   ├── 11_response_curves.png
│   │   ├── 12_budget_optimisation.png
│   │   └── 13_sensitivity.png
│   ├── budget_optimisation.csv
│   └── model_results/
│
├── report/
│   └── Marketing_Effectiveness_Media_Budget_Optimisation_Report.pdf
│
├── presentation/
│   └── Marketing_Effectiveness_Media_Budget_Optimisation_Presentation.pdf
│
├── requirements.txt
├── .gitignore
└── README.md
```

> **Tip:** Rename your local files to match this structure before uploading to GitHub. This keeps the repository clean and recruiter-friendly.

---

# Analytical Workflow

```text
Business Problem
      ↓
Raw Data
      ↓
PostgreSQL Import
      ↓
Data Quality Validation
      ↓
Data Cleaning
      ↓
Exploratory Data Analysis
      ↓
Econometric Regression
      ↓
Trend & Seasonality Controls
      ↓
Adstock Transformation
      ↓
Saturation Transformation
      ↓
Marketing Mix Model
      ↓
Model Diagnostics
      ↓
Counterfactual Attribution
      ↓
Baseline vs Incremental Sales
      ↓
Channel Contribution
      ↓
ROAS
      ↓
Response Curves
      ↓
Marginal Returns
      ↓
Budget Optimisation
      ↓
Sensitivity Analysis
      ↓
Business Recommendations
```

---

# 1. Data Quality Validation

Before modelling, the raw dataset was validated in PostgreSQL.

The validation framework included:

- Row-count validation
- Duplicate detection
- Missing-value analysis
- Invalid-range checks
- Negative media-spend detection
- Business-rule validation
- Weekly time-series continuity
- Category consistency
- Cross-field revenue reconciliation

Examples of issues identified in the raw data included:

- Duplicate weekly observations
- Missing media values
- Missing distribution values
- Negative media spend
- Implausible promotional values

Instead of modifying the source directly, the raw table was preserved and all cleaning actions were documented.

### Key Principle

> **Validate first, clean second, validate again.**

---

# 2. Data Cleaning & Preparation

A separate clean analytical table was created after investigation.

Cleaning actions included:

- Removing exact duplicate observations
- Interpolating isolated missing time-series values where justified
- Correcting invalid negative media values
- Applying business-rule checks to promotional values
- Rechecking missingness after cleaning
- Rechecking weekly continuity
- Adding database constraints to the clean table

A data-quality audit log was used to retain:

- Original value
- Replacement value
- Cleaning method
- Business rationale

This created a transparent and reproducible data-preparation process.

---

# 3. Exploratory Data Analysis

EDA was used to understand the business before building the model.

Main areas investigated:

- Weekly sales trend
- Year-over-year sales performance
- Promotions vs sales
- Holiday demand
- Price-demand relationship
- Distribution vs sales
- Media investment
- Correlation between drivers
- Correlation between media channels

## Sales Trend

![Weekly Sales Trend](https://github.com/maidulhassan-collab/Marketing_Effectiveness_Media_Budget_Optimisation/blob/main/python%20outputs/weekly_sales_over_time.png)

Average weekly sales increased approximately from:

| Year | Average Weekly Sales |
|---|---:|
| 2023 | ~105K |
| 2024 | ~115K |
| 2025 | ~122K |

Sales increased over time even though media investment did not rise proportionally.

This suggested that marketing spend alone could not explain business growth and that other factors needed to be controlled for.

## Important EDA Findings

- Promotions were associated with higher sales.
- Holiday periods showed stronger demand.
- Distribution had a positive relationship with sales.
- Price had a negative relationship with unit demand.
- Media spend was positively related to sales, but the relationship was imperfect.
- Several media channels moved together, raising potential multicollinearity concerns.

> Correlation was treated as exploratory evidence, not proof of causality.

---

# 4. Econometric Sales Model

A multiple-regression model was developed to separate the influence of multiple drivers.

The conceptual specification was:

\[
Sales_t =
\beta_0
+ \beta_1 Price_t
+ \beta_2 Promotion_t
+ \beta_3 Distribution_t
+ \beta_4 Holiday_t
+ \beta_5 Competition_t
+ Trend_t
+ Seasonality_t
+ Media_t
+ \epsilon_t
\]

The model controlled for:

- Price
- Promotion
- Distribution
- Holiday demand
- Competitor activity
- Long-term trend
- Annual seasonality

## Business Relationships

The econometric model produced broadly sensible relationships:

- Higher distribution → higher sales
- Holiday periods → higher sales
- Higher price → lower unit demand
- Stronger competitor activity → lower sales

The base model explained approximately:

- **R² ≈ 0.816**
- **Adjusted R² ≈ 0.804**

---

# 5. Model Diagnostics

Model quality was evaluated using more than a single goodness-of-fit statistic.

Diagnostics included:

- R²
- Adjusted R²
- RMSE
- AIC
- Coefficient plausibility
- p-values
- Confidence intervals
- Variance Inflation Factor (VIF)
- Residual analysis
- Durbin-Watson statistic
- Breusch-Pagan test
- Q-Q plots

These checks were used to evaluate:

- statistical fit
- coefficient stability
- multicollinearity
- heteroscedasticity
- autocorrelation
- business plausibility

The goal was not simply to maximise R², but to produce a model that was both **statistically defensible and commercially interpretable**.

---

# 6. Adstock

Raw same-week media spend assumes that advertising affects sales only in the week it occurs.

That is often unrealistic.

To capture advertising carryover, geometric adstock was applied:

\[
Adstock_t =
Spend_t +
\lambda \times Adstock_{t-1}
\]

where:

- \(Spend_t\) = current-period spend
- \(\lambda\) = carryover / decay parameter
- \(Adstock_{t-1}\) = remaining effect from prior periods

## Interpretation

- Higher \(\lambda\) → longer advertising memory
- Lower \(\lambda\) → faster decay

Different channels were assigned different starting decay assumptions based on expected media behaviour.

For example, TV was allowed to retain a longer carryover effect than Paid Search.

---

# 7. Saturation

Marketing investment usually experiences diminishing returns.

The project therefore applied a saturation transformation:

\[
S(x) =
\frac{x}{x+\theta}
\]

where:

- \(x\) = adstocked media activity
- \(\theta\) = half-saturation parameter

This creates a nonlinear response curve where:

- initial investment may generate strong additional response
- later investment still increases response
- but each additional unit produces progressively smaller gains

This is essential for realistic media-budget planning.

---

# 8. Marketing Mix Model

The modelling process compared increasingly realistic specifications.


| Model | R² | Adjusted R² | Approx. RMSE |
|---|---:|---:|---:|
| Base Model | 0.816 | 0.804 | 5,896 |
| Raw Media Model | 0.833 | 0.815 | 5,627 |
| Adstock Model | 0.846 | 0.830 | 5,391 |
| Adstock + Saturation MMM | **0.849** | **0.833** | **5,339** |

The final adstock + saturation model improved both:

- statistical fit
- behavioural realism

The improvement was not judged on R² alone; diagnostics and business plausibility were also considered.

---

# 9. Baseline vs Incremental Sales

Counterfactual predictions were used to decompose modelled sales into:

\[
Total\ Sales =
Baseline\ Sales
+
Incremental\ Media\ Sales
\]

![Baseline vs Media](https://github.com/maidulhassan-collab/Marketing_Effectiveness_Media_Budget_Optimisation/blob/main/python%20outputs/baseline_vs_media.png)

Approximate results:

| Component | Share |
|---|---:|
| Baseline / Non-Media | **70.6%** |
| Measured Media | **29.4%** |

Across the analysed period:

- Total modelled sales ≈ **17.8M units**
- Incremental media sales ≈ **5.23M units**

Average weekly values:

- Baseline ≈ **80.6K units**
- Media contribution ≈ **33.6K units**
- Total ≈ **114.1K units**

> Baseline should not be interpreted as demand completely unaffected by historical marketing. It is a model construct representing sales without the incremental contribution of measured media in the modelled period.

---

# 10. Channel Contribution

Channel contribution was estimated using counterfactual prediction:

\[
Contribution_i =
Prediction_{Observed}
-
Prediction_{Without\ Channel_i}
\]

This approach preserves the nonlinear adstock and saturation transformations.

![Spend Share vs Contribution Share](https://github.com/maidulhassan-collab/Marketing_Effectiveness_Media_Budget_Optimisation/blob/main/python%20outputs/channel_contribution_chart.png)

Approximate channel findings:

| Channel | Spend Share | Estimated Contribution Share |
|---|---:|---:|
| TV | 38.1% | 17.9% |
| Search | 15.1% | 8.1% |
| Meta | 20.2% | Not reliably isolated |
| YouTube | 12.4% | 32.4% |
| OOH | 14.2% | 41.6% |

A key business finding was:

> **High spend did not automatically correspond to high incremental contribution.**

### Meta Interpretation

The unconstrained specification produced an unstable / negative independent Meta coefficient.

For commercial attribution, a non-negative media constraint was applied. Under that specification, Meta's independent contribution was approximately zero.

This should be interpreted as:

> **insufficient evidence to isolate Meta's independent incremental effect under the current data and model specification**

—not as proof that Meta has no value.

---

# 11. ROAS Analysis

ROAS was defined as:

\[
ROAS =
\frac{Incremental\ Revenue}
{Media\ Spend}
\]


Approximate historical model-estimated ROAS:

| Channel | ROAS |
|---|---:|
| TV | 0.55 |
| Search | 0.63 |
| Meta | Not reliably isolated |
| YouTube | 3.09 |
| OOH | 3.45 |

OOH and YouTube showed the strongest historical revenue efficiency under the fitted model.

## ROAS vs ROI

This project reports **ROAS**, not true profit-based ROI.

A defensible ROI calculation would require:

- Contribution margin
- Cost of goods sold
- Variable costs
- Other commercial cost information

Therefore:

> **ROAS is reported where revenue is available; profit-based ROI is not claimed without margin data.**

---

# 12. Response Curves & Marginal Returns

Historical average efficiency is not enough for future budget decisions.

As spend rises, channels move further along their saturation curves and marginal returns fall.

![Media Response Curves](https://github.com/maidulhassan-collab/Marketing_Effectiveness_Media_Budget_Optimisation/blob/main/python%20outputs/media_response_curves.png)

The planning response function combines:

- adstock
- saturation
- channel coefficient

This enables the model to answer:

> **What is the expected response to the next additional unit of investment?**

Approximate incremental units from the next BDT 1M at current spend levels:

| Channel | Marginal Units / BDT 1M |
|---|---:|
| TV | ~495 |
| Search | ~760 |
| Meta | Not reliably isolated |
| YouTube | ~3,344 |
| OOH | ~3,790 |

This indicated stronger marginal opportunity in OOH and YouTube under the current specification.

A central lesson is:

\[
\boxed{Average\ ROAS \neq Marginal\ ROAS}
\]

Budget decisions should therefore consider the **next unit of investment**, not only historical averages.

---

# 13. Budget Optimisation

The optimisation objective was:

\[
\max \sum_i Response_i(Spend_i)
\]

subject to:

\[
\sum_i Spend_i
=
Current\ Total\ Budget
\]

and practical channel-level constraints.

To avoid unrealistic reallocations, each channel was restricted to approximately:

\[
\pm30\%
\]

of its historical average spend.

![Current vs Optimised Allocation](https://github.com/maidulhassan-collab/Marketing_Effectiveness_Media_Budget_Optimisation/blob/main/python%20outputs/current_vs_optimised_media_allocation.png)

## Current vs Optimised Weekly Allocation

| Channel | Current BDT M | Optimised BDT M | Change |
|---|---:|---:|---:|
| TV | 5.95 | 4.94 | -17% |
| Search | 2.37 | 3.08 | +30% |
| Meta | 3.16 | 2.21 | -30% |
| YouTube | 1.94 | 2.52 | +30% |
| OOH | 2.22 | 2.88 | +30% |
| **Total** | **15.63** | **15.63** | **0%** |

### Model-Estimated Scenario Impact

- **~11.5% increase in media-driven sales**
- **0% increase in total media budget**
- **~3.9K additional units per week**
- **~204K additional units per year**
- **~BDT 112M estimated annual revenue opportunity**

> These are model-estimated scenario outputs under steady-state assumptions and should not be interpreted as guaranteed future business performance.

---

# 14. Sensitivity Analysis

The optimisation was repeated under different channel-level reallocation limits.


| Maximum Channel Change | Estimated Media-Sales Uplift |
|---:|---:|
| ±15% | ~6.2% |
| ±30% | ~11.5% |
| ±50% | ~17.6% |

The results demonstrate the trade-off between:

- expected optimisation gain
- operational feasibility
- model uncertainty
- departure from historical strategy

A larger allowed budget movement creates more modelled upside, but also increases execution and model risk.

---

# Key Business Recommendations

## 1. Rebalance Before Increasing Total Spend

The model suggests that the current media mix contains efficiency opportunities.

Management should first consider improving allocation before increasing the overall budget.

## 2. Shift Budget Gradually Toward Stronger Marginal Opportunities

OOH and YouTube currently show stronger model-estimated marginal returns.

Any reallocation should be gradual and tested rather than implemented as an extreme one-time change.

## 3. Validate Uncertain Attribution Experimentally

Where independent channel effects are difficult to isolate—particularly Meta—use additional evidence such as:

- Geo experiments
- Holdout tests
- Lift studies
- A/B experiments
- Platform incrementality studies

## 4. Refresh the Model Regularly

Marketing effectiveness changes over time.

The model should be refreshed as new data becomes available so that:

- response curves
- channel efficiency
- attribution
- optimal allocation

remain relevant.

---

# Limitations

This project should be interpreted with several important limitations:

1. **Synthetic dataset**  
   The dataset was created for learning and portfolio purposes.

2. **Observational modelling**  
   Regression and MMM improve attribution but do not automatically establish perfect causality.

3. **Channel correlation**  
   Multiple channels may move together, making independent effects difficult to isolate.

4. **Adstock assumptions**  
   Decay parameters are modelling assumptions and should ideally be calibrated using validation and experiments.

5. **Saturation assumptions**  
   Response-curve shape depends on the selected saturation parameters.

6. **Omitted variables**  
   Potentially relevant factors such as weather, macroeconomic conditions, creative quality, competitor pricing, and inventory constraints may not be included.

7. **Steady-state optimisation**  
   Budget optimisation assumes relatively stable weekly spending rather than optimising timing week by week.

8. **ROAS, not true ROI**  
   Profit-based ROI cannot be estimated responsibly without cost and margin information.

9. **Scenario uncertainty**  
   The estimated uplift is a decision-support scenario, not a guaranteed outcome.

---

# How to Run the Project

## 1. Clone the Repository

```bash
git clone YOUR_REPOSITORY_URL
cd marketing-effectiveness-media-optimisation
```

## 2. Create a Virtual Environment

### Windows

```bash
python -m venv .venv
.venv\Scripts\activate
```

### macOS / Linux

```bash
python3 -m venv .venv
source .venv/bin/activate
```

## 3. Install Dependencies

```bash
pip install -r requirements.txt
```

Recommended `requirements.txt`:

```text
pandas
numpy
matplotlib
sqlalchemy
psycopg2-binary
statsmodels
scikit-learn
scipy
jupyter
```

## 4. Create the PostgreSQL Database

Run the SQL files in order:

```text
sql/01_create_database.sql
sql/02_data_quality_checks.sql
sql/03_data_cleaning.sql
```

## 5. Configure Database Credentials Safely

Do **not** hard-code passwords in notebooks or commit them to GitHub.

Recommended environment variables:

```text
DB_HOST
DB_PORT
DB_NAME
DB_USER
DB_PASSWORD
```

Example Python pattern:

```python
import os
from sqlalchemy import create_engine

engine = create_engine(
    f"postgresql+psycopg2://"
    f"{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@"
    f"{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/"
    f"{os.getenv('DB_NAME')}"
)
```

## 6. Run the Notebooks

Recommended order:

```text
1. notebooks/01_exploratory_data_analysis.ipynb
2. notebooks/02_regression_econometrics.ipynb
3. notebooks/03_marketing_mix_model.ipynb
```

---

# Recommended `.gitignore`

Create a `.gitignore` file containing:

```gitignore
# Python
__pycache__/
*.py[cod]
*.pyo

# Virtual environments
.venv/
venv/
env/

# Jupyter
.ipynb_checkpoints/

# Environment variables / secrets
.env
.env.*
*.env

# Database / credentials
config.ini
credentials.json
secrets.json

# OS files
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/

# Temporary files
*.tmp
*.temp
~$*

# Logs
*.log
```

---

# Project Deliverables

This repository includes:

- SQL database setup
- Data-quality validation queries
- Data-cleaning workflow
- Clean analytical dataset
- EDA notebook
- Regression / econometrics notebook
- Marketing Mix Model notebook
- Model diagnostics
- Adstock transformations
- Saturation transformations
- Counterfactual channel attribution
- ROAS analysis
- Response curves
- Marginal-return analysis
- Constrained budget optimisation
- Sensitivity analysis
- Professional report
- Business presentation

### Full Report

[View Project Report](https://github.com/maidulhassan-collab/Marketing_Effectiveness_Media_Budget_Optimisation/blob/main/Marketing_Effectiveness_Media_Budget_Optimisation_Report.pdf)

### Presentation

[View Presentation](https://github.com/maidulhassan-collab/Marketing_Effectiveness_Media_Budget_Optimisation/blob/main/Marketing_Effectiveness_Media_Budget_Optimisation_presentation.pptx)

> Update the presentation filename above if your actual uploaded file uses a different name.

---

# Skills Demonstrated

## SQL & Data Engineering

- PostgreSQL
- Data extraction
- CTEs
- Window functions
- `LAG()` / `LEAD()`
- Data validation
- Duplicate detection
- Missing-value checks
- Business-rule validation
- Database constraints
- Data-quality audit trails

## Python Analytics

- Pandas
- NumPy
- Matplotlib
- SQLAlchemy
- Statsmodels
- SciPy

## Statistics & Econometrics

- Multiple regression
- Coefficient interpretation
- Statistical significance
- Confidence intervals
- R²
- Adjusted R²
- RMSE
- AIC
- Multicollinearity
- VIF
- Residual diagnostics
- Heteroscedasticity
- Autocorrelation
- Trend
- Seasonality
- Fourier terms

## Marketing Analytics

- Marketing Mix Modelling
- Adstock
- Carryover effects
- Saturation
- Diminishing returns
- Baseline sales
- Incremental sales
- Counterfactual attribution
- Sales effects
- ROAS
- Response curves
- Marginal returns

## Decision Science

- Scenario analysis
- Constrained optimisation
- Sensitivity analysis
- Media-budget allocation
- Business recommendations
- Model-risk communication

---


# Future Enhancements

Possible extensions include:

- Formal hyperparameter optimisation for adstock and saturation
- Time-series cross-validation
- Bayesian Marketing Mix Modelling
- Regularised regression
- Hierarchical / geo-level MMM
- Creative-level variables
- Weather and macroeconomic variables
- Contribution-margin data for profit optimisation
- Geo-experiment calibration
- Channel interaction effects
- Weekly channel-and-time budget optimisation
- Interactive dashboard for scenario planning

---

# Final Takeaway

This project demonstrates how analytics can progress from:

```text
Raw Data
→ Reliable Data
→ Statistical Evidence
→ Marketing Attribution
→ Channel Economics
→ Budget Decision
```

The final model suggests that the existing media mix contains opportunities for improved efficiency and estimates that a constrained reallocation of the same total media budget could improve media-driven sales by approximately **11.5%**, subject to the assumptions and limitations of the model.

The most important lesson is that marketing analytics is not only about explaining historical performance—it is about converting evidence into **better future decisions**.

---

# Author

**Md. Maidul Hassan Shanto**

Data Analytics | Business Analytics | Econometrics | Marketing Analytics

- LinkedIn: `www.linkedin.com/in/maidulhassan`
- GitHub: `https://github.com/maidulhassan-collab`

---

# Disclaimer

This project was created for educational and portfolio purposes using synthetic business-realistic data.

All analytical results, model outputs, attribution estimates, ROAS values, and optimisation scenarios are illustrative model-based findings. They do not represent the performance, strategy, clients, customers, or confidential information of any real organisation.
