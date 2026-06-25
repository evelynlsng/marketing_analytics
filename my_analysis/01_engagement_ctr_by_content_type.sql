/*
=============================================================================
Original Analysis #01 — Engagement Click-Through Rate (CTR) by Content Type
=============================================================================

Author : Evelyn Ng
Purpose: Find which marketing content types drive the most engagement on
         a per-view basis (not just total volume).

Why this question matters:
    Raw view counts favour high-volume content types (e.g., Social Media
    posts may get the most views simply because they're posted most often).
    Click-through rate (CTR) controls for volume and shows EFFICIENCY:
    which content type actually converts viewers into clickers?

    For a marketing or governance team, this is a more decision-useful
    metric than "Social Media has 1M views" — it tells you where to spend
    creative and budget effort.

What the query does:
    1. Cleans the engagement data (same logic as the tutorial: splits the
       ViewsClicksCombined field, standardises ContentType).
    2. Aggregates per ContentType: total views, total clicks, total likes.
    3. Calculates CTR as Clicks / Views (rounded to 4 dp for readability).
    4. Orders by CTR descending so the most efficient content types
       appear first.

Notes:
    - I exclude Newsletter (same as the tutorial) because newsletter
      engagement patterns are very different from web/social.
    - CTR is multiplied by 100 to display as a percentage.
    - I use NULLIF(Views, 0) to prevent divide-by-zero errors in case
      any row has 0 views.
=============================================================================
*/

WITH CleanedEngagement AS (
    SELECT
        UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,
        CAST(LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS INT) AS Views,
        CAST(RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS INT) AS Clicks,
        Likes
    FROM dbo.engagement_data
    WHERE ContentType <> 'Newsletter'
)

SELECT
    ContentType,
    COUNT(*)                                   AS NumPosts,
    SUM(Views)                                 AS TotalViews,
    SUM(Clicks)                                AS TotalClicks,
    SUM(Likes)                                 AS TotalLikes,
    ROUND(
        100.0 * SUM(Clicks) / NULLIF(SUM(Views), 0),
        2
    )                                          AS CTR_Percent,
    ROUND(
        1.0 * SUM(Likes) / NULLIF(SUM(Views), 0),
        4
    )                                          AS LikesPerView
FROM CleanedEngagement
GROUP BY ContentType
ORDER BY CTR_Percent DESC;

/*
=============================================================================
What I'd do next (interpretation / follow-up):

  - If one ContentType has a much higher CTR but low NumPosts, that's a
    signal to invest more in producing that type.
  - If a ContentType has high TotalViews but low CTR, the content is
    reaching people but not converting — worth investigating the call to
    action.
  - LikesPerView gives a softer engagement signal — a post can have low
    CTR but high likes (good for brand) or vice versa.
  - To dig deeper: join with CampaignID to see which campaigns drive the
    best per-content-type CTR.
=============================================================================
*/
