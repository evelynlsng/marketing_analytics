# Marketing Analytics — Learning Project

End-to-end data analytics project using a marketing dataset: SQL Server for data cleaning, Power BI for dashboards, Python for enrichment.

## Origin

This project starts with [Ali Ahmad's Data Analyst Portfolio Project series](https://www.youtube.com/playlist?list=PLMfXakCUhXsHxNShtz2ucsR69RCJqMnnd) as a guided introduction to the tooling. I'm using it to learn SQL Server, Power BI, and Python on a realistic marketing dataset.

After working through the tutorial, I extend the analysis with my own queries and dashboard angles (see `my_analysis/`).

## Dataset

Marketing analytics data from Ali Ahmad's GitHub repo:
- `dim_customers` — customer demographics
- `dim_products` — product catalog
- `fact_customer_reviews` — review records
- `fact_customer_journey` — customer interaction timeline
- `fact_engagement_data` — marketing engagement events

**To reproduce:** Download `Episode 2 - PortfolioProject_MarketingAnalytics.bak` from [the source repo](https://github.com/aliahmad-1987/DataAnalystPortfolioProject_PBI_SQL_Python_MarketingAnalytics), restore it in SQL Server Management Studio.

## Structure

```
marketing_analytics/
├── tutorial_work/      # Code & queries from following the tutorial
│   └── 02_data_cleaning/
├── my_analysis/        # My own SQL queries beyond the tutorial
├── powerbi/            # Power BI dashboard files (.pbix)
├── screenshots/        # Dashboard previews for README
└── README.md
```

## Tooling

- **SQL Server 2022** (with SSMS 22)
- **Power BI Desktop**
- **Python** (pandas, for enrichment scripts)
- **Excel** (pivot table companion analysis)

## What I'm learning

- [ ] Restoring a SQL Server database from a `.bak` file
- [ ] Writing data-cleaning queries (CASE, JOIN, COALESCE)
- [ ] Star schema (dim vs. fact tables)
- [ ] Building Power BI data models and DAX measures
- [ ] Designing a multi-page dashboard
- [ ] Pivot tables in Excel

## My extensions (in progress)

_To be added as I complete the tutorial and start my own analysis._

## Credits

- Tutorial: [Ali Ahmad](https://www.youtube.com/@AliAhmadAnalytics)
- Dataset: Provided in [his GitHub repo](https://github.com/aliahmad-1987/DataAnalystPortfolioProject_PBI_SQL_Python_MarketingAnalytics)
