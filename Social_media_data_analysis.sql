-- SOCIAL_MEDIA DATA ANALYSIS
-- PROJECT_QUESTIONS

USE social_media;

-- 1: Identify Users by Location. Hint: Focus on filtering users by location.

SELECT location, count(location)
FROM post GROUP BY location
ORDER BY count(location) DESC;

-- 2: Determine the Most Followed Hashtags. Hint: Join relevant tables to calculate the total follows for each hashtag.

SELECT tags.hashtag_name, count(follow.user_id) AS user_count
FROM hashtags AS tags
LEFT JOIN hashtag_follow AS follow ON tags.hashtag_id = follow.hashtag_id
GROUP BY tags.hashtag_name
ORDER BY count(follow.user_id) DESC LIMIT 5;

-- 3: Find the Most Used Hashtags.  Hint: Count how many times each hashtag appears in posts.

SELECT a.hashtag_id, b.hashtag_name, count(a.hashtag_id) AS hashtag_use_count
FROM post_tags AS a 
LEFT JOIN hashtags AS b ON a.hashtag_id = b.hashtag_id
GROUP BY a.hashtag_id
ORDER BY count(a.hashtag_id) DESC LIMIT 10;

-- 4: Identify the Most Inactive User. Hint: Use a subquery to identify these users.

SELECT user_id AS inactive_users, username
FROM users
WHERE user_id NOT IN (
    SELECT user_id 
    FROM post
);

-- 5:  Identify the Posts with the Most Likes. Hint: Count the number of likes for each post.

SELECT user_id, count(user_id) AS number_of_likes
FROM post_likes
GROUP BY user_id
ORDER BY count(user_id) DESC;

-- 6: Calculate Average Posts per User. Hint: Consider dividing the total number of posts by the number of unique users.

SELECT count(post_id) / count(DISTINCT user_id) AS avg_posts_per_user
FROM post;

-- 7: Track the Number of Logins per User. Hint: Join user and login tables.

SELECT u.user_id, u.username, count(l.login_time) AS number_of_logins
FROM login AS l
LEFT JOIN users AS u ON l.user_id = u.user_id
GROUP BY u.user_id;

-- 8: Identify a User Who Liked Every Single Post. Hint: Compare the number of posts with the number of likes by this user.

SELECT user_id
FROM post_likes
GROUP BY user_id
HAVING count(DISTINCT post_id) = (SELECT count(DISTINCT post_id) FROM post_likes);

-- 9: Find Users Who Never Commented. Hint: Use a subquery to exclude users who have commented.

SELECT user_id AS never_commented_user, username
FROM users
WHERE user_id NOT IN (
    SELECT user_id 
    FROM comments
);

-- 10: Identify a User Who Commented on Every Post. Hint: Compare the number of posts with the number of comments by this user.

SELECT user_id
FROM comments
GROUP BY user_id
HAVING count(DISTINCT post_id) = (SELECT count(DISTINCT post_id) FROM comments);

-- 11: Identify Users Not Followed by Anyone. Hint: Use the follows table to find users who have no followers.

SELECT followee_id
FROM follows
WHERE followee_id NOT IN (
    SELECT follower_id
    FROM follows
);

-- 12: Identify Users Who Are Not Following Anyone. Hint: Use the follows table to identify users who are not following others.

SELECT follower_id
FROM follows
WHERE follower_id NOT IN (
    SELECT followee_id
    FROM follows
);

-- 13: Find Users Who Have Posted More than 5 Times. Hint: Group the posts by user and filter the results based on the number of posts.

SELECT user_id , count(post_id) AS number_of_posts
FROM post
GROUP BY user_id
HAVING count(post_id) > 5
ORDER BY number_of_posts DESC;

-- 14: Identify Users with More than 40 Followers. Hint: Group the followers and filter the result for those with a high follower count.

SELECT count(follower_id)
FROM follows 
GROUP BY follower_id
HAVING count(follower_id) > 40;

-- 15: Search for Specific Words in Comments. Hint: Use regular expressions to search for these words.

SELECT *
FROM comments
WHERE comment_text LIKE '%good%' OR comment_text LIKE '%beautiful%';

-- 16: Identify the Longest Captions in Posts. Hint: Calculate the length of each caption and sort them to find the top 5 longest ones.

SELECT length(caption) , caption AS longest_caption
FROM post
ORDER BY length(caption) DESC LIMIT 1;

-- INSIGHTS 
/*

Introduction: 
The goal of this analysis was to understand social media trend and user behaviour using the database. 

Findings:

>Identifed most and least users by location: Most users are in- 1)Maharashtra, 2)Karnataka, 3)Gujarat
>Most used hashtag:  #festivesale
>Calculated average post per user which is 2.22%
>Identified most popular user as per followers data: 
 
*/
