# Episode 2 — Data Cleaning Notes

My own explanations of what each query does, written in my own words to confirm I actually understand the concepts (not just copy-pasting).

## dim_products.sql

The CASE statement buckets prices into categories: Low (<$50), Medium ($50–$200), and High (>$200). End the CASE block with `END AS PriceCategory` to give the new column a name.

CASE works like Python's `if / elif / else`: each row is evaluated top to bottom, and the first matching WHEN wins.

**Why this matters:** Raw prices are continuous — hard to group or chart. Bucketing into categories enables downstream questions like "are most of our products in the Medium tier?" or "what's the average rating per price tier?".

## dim_customers.sql

This query enriches the customers table by attaching country and city from the geography table.

### Aliases
`as c` and `g` are shortcuts so I don't have to type `dbo.customers` and `dbo.geography` every time. Saves typing and keeps the JOIN logic readable.

### LEFT JOIN
Combines two tables. **LEFT JOIN keeps every customer row even if there is no matching geography** — those rows just get NULL for Country and City.

### The four JOIN types
- **LEFT JOIN** — keep all from left table; right side NULL if no match
- **RIGHT JOIN** — opposite — keep all from right, left NULL if no match
- **INNER JOIN** — only keep rows where both tables match
- **FULL OUTER JOIN** — keep everything from both, NULLs where missing

### ON clause
`ON c.GeographyID = g.GeographyID` tells SQL how the two tables relate. Geography rows attach to customers wherever the IDs match.

### Why LEFT JOIN here (not INNER)?
The customers table is our primary table and we want every customer in the result. If some customers have a GeographyID that doesn't exist in the geography table, LEFT JOIN keeps them (with NULL location), while INNER JOIN would silently drop them. Dashboards built on silently-dropped data become misleading.

**Rule of thumb:** when attaching lookup info to a main table, default to LEFT JOIN. Switch to INNER only if you have a specific reason to want the rows dropped.

## fact_customer_reviews.sql

A simple but useful query that cleans whitespace in the `ReviewText` column. The `REPLACE(ReviewText, '  ', ' ')` swaps double spaces for single spaces.

**Why this matters:** Sloppy review text causes downstream pain — text searches miss words because of extra spaces, sentiment analysis tokenises wrongly, and joining/grouping on text fields silently fails. Standardising whitespace early prevents these bugs later.

This is a real-world data hygiene step. Most messy datasets I've seen have some form of inconsistent whitespace.

## fact_engagement_data.sql

This one is doing **a lot** in one query — combining cleaning, splitting, and standardisation:

### Standardising content type
`UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media'))` first fixes a typo (no space) and then uppercases everything. Now "Socialmedia" / "social media" / "SOCIAL MEDIA" all become `SOCIAL MEDIA`.

This handles a common data quality issue — categorical values that should be the same but were entered slightly differently.

### Splitting a combined field
The `ViewsClicksCombined` column stuffs two metrics into one field separated by a `-`. The query splits it into separate `Views` and `Clicks` columns using `LEFT` and `RIGHT` with `CHARINDEX('-', ...)`.

- `LEFT(ViewsClicksCombined, CHARINDEX('-', ...) - 1)` — take everything before the dash
- `RIGHT(ViewsClicksCombined, LEN(...) - CHARINDEX('-', ...))` — take everything after the dash

**Why this matters:** You can't aggregate or chart Views vs Clicks if they're stuck in the same string. Splitting them at ingest enables real engagement analysis.

### Date formatting
`FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy')` ensures consistent date display. Different databases store dates differently, and reports often need specific formats.

### Filtering out Newsletter
The WHERE clause excludes Newsletter content — likely because newsletters have different engagement patterns and would skew analyses of social/web content.

**What I'd want to add:** at minimum, a quick check on how many rows have weird `ViewsClicksCombined` formats (missing dash? extra dashes?) before assuming the LEFT/RIGHT split always works.

## fact_customer_journey.sql

The most complex query in this set. It uses a **Common Table Expression (CTE)** and **window functions** to find and remove duplicate customer journey entries while also imputing missing durations.

### Step 1: Find duplicates with ROW_NUMBER()
```sql
ROW_NUMBER() OVER (
    PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action
    ORDER BY JourneyID
) AS row_num
```

`PARTITION BY` groups rows that should be unique. If two rows have the same customer, product, date, stage, and action, they're considered duplicates. `ROW_NUMBER()` assigns 1 to the first occurrence and 2, 3, ... to subsequent duplicates.

**Then keep only `row_num = 1`** to deduplicate.

### Step 2: Impute missing Durations
```sql
COALESCE(Duration, avg_duration) AS Duration
```

For rows where Duration is NULL, use the daily average duration as a fallback. The daily average is computed with another window function:

```sql
AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration
```

This calculates the average for each date and broadcasts it to every row of that date.

### Why this matters
Raw event data often has both duplicates (from logging glitches) and missing values (from broken sessions). This query handles both in one pass — much cleaner than running separate dedup and imputation steps.

### What I learned
- CTEs (`WITH ... AS`) make complex queries readable by breaking them into named steps
- Window functions (`PARTITION BY`, `ROW_NUMBER()`, `AVG() OVER`) are how you do "group-aware" calculations without losing row-level detail
- `COALESCE` is the SQL equivalent of "use X, but if X is NULL, fall back to Y"

## SQL concepts I've now covered

- [x] `SELECT *` vs naming columns explicitly
- [x] Table aliases (`as c`, `as g`)
- [x] `CASE WHEN ... THEN ... ELSE ... END` for value bucketing
- [x] The four JOIN types and when to use each (especially LEFT vs INNER)
- [x] String cleaning: `REPLACE`, `UPPER`, `LEFT`/`RIGHT` with `CHARINDEX`
- [x] Date formatting: `FORMAT(CONVERT(DATE, ...), 'dd.MM.yyyy')`
- [x] WHERE clauses for filtering
- [x] Common Table Expressions (`WITH ... AS`)
- [x] Window functions (`ROW_NUMBER()`, `AVG() OVER`, `PARTITION BY`)
- [x] Duplicate detection via partitioning
- [x] Handling NULLs with `COALESCE`

## What I want to do with this dataset on my own

- [ ] Calculate engagement click-through rate (CTR) by content type → see `my_analysis/01_engagement_ctr_by_content_type.sql`
- [ ] Find top-rated products by category (joining dim_products + fact_customer_reviews)
- [ ] Look at customer journey conversion rates (Awareness → Consideration → Purchase)
- [ ] Identify customers who reviewed but never purchased (suggests review bombing or wishlist users)
