# My Analysis — original queries beyond the tutorial

This folder holds SQL queries I write myself to answer questions about the marketing dataset. Each file is a standalone query with:

- A header explaining the business question
- The SQL itself, commented
- A "what I'd do next" section with my interpretation and follow-up ideas

## Queries

| # | File | Question |
|---|---|---|
| 01 | `01_engagement_ctr_by_content_type.sql` | Which content types have the best click-through rate (CTR)? |
| 02 | _(coming)_ | Top-rated products by category — joining `dim_products` and `fact_customer_reviews` |
| 03 | _(coming)_ | Customer journey conversion rate (Awareness → Consideration → Purchase) |

## My approach to writing these

For each question, I try to:
1. **State the business reason** for the question, not just the SQL recipe
2. **Show my reasoning** in comments (why I chose this JOIN, why I excluded this row)
3. **Note edge cases** (NULL handling, divide-by-zero guards)
4. **Sketch follow-up analyses** so the query becomes a starting point, not a dead-end
