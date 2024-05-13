SELECT user_id,
tweet_date,
round(avg(tweet_count) OVER(PARTITION BY user_id ORDER BY tweet_date
rows BETWEEN 2 preceding and current row),2) rolling_avg_3d
FROM tweets;
