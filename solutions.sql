-- We want to reward our users who have been around the longest.  

-- Find the 5 oldest users.

SELECT 
    *
FROM
    users
ORDER BY created_at
LIMIT 5;

-- We need to figure out when to schedule an ad campgain

-- What day of the week do most users register on?

SELECT 
    DAYNAME(created_at) AS day, COUNT(*) AS total
FROM
    users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

-- We want to target our inactive users with an email campaign.

-- Find the users who have never posted a photo

SELECT 
    username
FROM
    users
        LEFT JOIN
    photos ON photos.user_id = users.id
WHERE
    photos.id IS NULL;

-- We're running a new contest to see who can get the most likes on a single photo.

-- WHO WON??!!

SELECT username, photos.id, photos.image_url, COUNT(*) AS total FROM photos
INNER JOIN likes ON likes.photo_id = photos.id
INNER JOIN users ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- Our Investors want to know...

-- How many times does the average user post?

SELECT 
    (SELECT 
            COUNT(*)
        FROM
            photos) / (SELECT 
            COUNT(*)
        FROM
            users) AS average;
            
-- A brand wants to know which hashtags to use in a post

-- What are the top 5 most commonly used hashtags?

SELECT 
    tag_name, COUNT(*) AS count
FROM
    photo_tags
        JOIN
    tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY count DESC
LIMIT 7;

-- We have a small problem with bots on our site...

-- Find users who have liked every single photo on the site

SELECT username, COUNT(*) AS num_likes FROM users
INNER JOIN likes ON likes.user_id = users.id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);