# Episode 2 — Data Cleaning Notes

My own explanations of what each query does, in my own words. Add to this as I work through the video.

## dim_products.sql

CASE will split the prices into catergories. end it with END AS "the title i want to change to" (WHEN,WHEN,ELSE)
Its like python if/elif/else

## dim_customers.sql
Aliases - c and g are shortcuts and will save typing dbo.customers repeatedly
 **LEFT JOIN** — keep all from left table; right side NULL if no match
- **RIGHT JOIN** — opposite — keep all from right, left NULL if no match
- **INNER JOIN** — only keep rows where both tables match
- **FULL OUTER JOIN** — keep everything from both, NULLs where missing
`ON c.GeographyID = g.GeographyID` — tells SQL how the two tables
relate.
Why LEFT JOIN?
The customers table is our primary table and we want every customer
in the result. If some customers have a GeographyID that doesn't
exist in the geography table, LEFT JOIN keeps them (with NULL
location), while INNER JOIN would silently drop them. Dashboards will be fake ish

## fact_customer_reviews.sql

_(TBD)_

## fact_engagement_data.sql

_(TBD)_

## fact_customer_journey.sql

_(TBD)_

## SQL concepts 

- [ ] `SELECT *` vs. naming columns explicitly
