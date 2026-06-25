# Marketing Analytics — SQL & Power BI Learning Portfolio

A self-directed learning project where I build my SQL Server, Power BI, and data modelling skills on a realistic multi-table marketing dataset. The work covers data cleaning, dimensional modelling (dim/fact star schema), and downstream visualisation.

## What this project demonstrates

- ✅ SQL Server fundamentals (CASE, JOINs, CTEs, window functions, string cleaning, date formatting)
- ✅ Multi-table relational thinking (5 dim/fact tables, customer journey, engagement)
- ✅ Working with a realistic, messy marketing dataset
- ✅ Documentation discipline (explaining what each query does and why)
- ✅ Active commit history showing in-progress learning
- ⏭️ Power BI dashboard build (next phase)
- ⏭️ Original analytical queries beyond the tutorial (in progress under `my_analysis/`)

## How this project is structured

I'm using [Ali Ahmad's Data Analyst Portfolio Project series](https://www.youtube.com/playlist?list=PLMfXakCUhXsHxNShtz2ucsR69RCJqMnnd) as a guided framework to learn SQL Server and Power BI. To make this a real learning artefact (rather than copy-paste), I do three things:

1. **Re-explain every concept in my own words** — see `tutorial_work/02_data_cleaning/notes.md`. If I can't explain it in plain English, I don't understand it.
2. **Extend the analysis with my own queries** — under `my_analysis/`, I write original SQL queries that go beyond what the tutorial shows.
3. **Maintain transparent documentation** — README clearly distinguishes tutorial-derived work from my own additions.

## Dataset

A relational marketing dataset (5 tables) covering:

| Table | Type | Contents |
|---|---|---|
| `dim_customers` | Dimension | Customer demographics |
| `dim_products` | Dimension | Product catalogue with prices |
| `fact_customer_reviews` | Fact | Customer review records with ratings |
| `fact_customer_journey` | Fact | Customer interaction timeline (Awareness → Consideration → Purchase) |
| `fact_engagement_data` | Fact | Marketing engagement events (views, clicks, content types) |

**To reproduce:** Download `Episode 2 - PortfolioProject_MarketingAnalytics.bak` from [the source repo](https://github.com/aliahmad-1987/DataAnalystPortfolioProject_PBI_SQL_Python_MarketingAnalytics) and restore it in SQL Server Management Studio.

## Repository structure

```
marketing_analytics/
├── tutorial_work/      Code & explanatory notes from following the tutorial
│   └── 02_data_cleaning/
│       ├── *.sql       SQL queries with my added commentary
│       └── notes.md    My own explanations of each concept
├── my_analysis/        Original SQL queries that go beyond the tutorial
├── powerbi/            Power BI dashboard files (.pbix)
└── screenshots/        Dashboard previews (when built)
```

## Tooling

- **SQL Server 2022** (with SSMS 22)
- **Power BI Desktop**
- **Git / GitHub** (this repo)
- **Cursor IDE** for SQL editing and documentation

## SQL concepts covered so far

- `SELECT` and column aliasing
- `CASE WHEN ... THEN ... ELSE ... END` for value bucketing (e.g., price tiers)
- `LEFT JOIN` and the reasoning behind LEFT vs INNER (avoiding silent data loss)
- String cleaning (`REPLACE`, `UPPER`, `LEFT`/`RIGHT` with `CHARINDEX`)
- Date formatting (`FORMAT(CONVERT(DATE, ...), 'dd.MM.yyyy')`)
- Common Table Expressions (`WITH ... AS`)
- Window functions (`ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...)`)
- Duplicate detection via partitioning
- Handling NULLs with `COALESCE` and computed fallbacks (e.g., daily average duration)

## What I'm working on next

- [ ] Build Power BI dashboard with KPIs (engagement CTR, customer journey conversion, review sentiment)
- [ ] Add more original queries under `my_analysis/`
- [ ] Document my analytical reasoning per query

## Credits

Tutorial framework: [Ali Ahmad](https://www.youtube.com/@AliAhmadAnalytics) — [original GitHub repo](https://github.com/aliahmad-1987/DataAnalystPortfolioProject_PBI_SQL_Python_MarketingAnalytics)

All learning notes, commentary, and `my_analysis/` queries are my own work.

## About me

Evelyn Ng — Year 1 NTU undergraduate, Chemistry & Biological Chemistry with a Second Major in Data Analytics. Building data and analytics skills outside coursework through self-directed projects like this one.

🔗 [LinkedIn](https://www.linkedin.com/in/evelynlsng)
