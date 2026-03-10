CREATE DATABASE InstagramAnalysis;
GO
USE InstagramAnalysis;
GO
CREATE DATABASE InstagramAnalytics;
GO
USE InstagramAnalytics;
GO
CREATE TABLE users (
user_id INT PRIMARY KEY,
username VARCHAR(50),
email VARCHAR(100),
signup_date DATE
);

CREATE TABLE posts (
post_id INT PRIMARY KEY,
user_id INT,
caption VARCHAR(255),
post_date DATE,
FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE likes (
like_id INT PRIMARY KEY,
user_id INT,
post_id INT,
like_date DATE,
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (post_id) REFERENCES posts(post_id)
);
CREATE TABLE comments (
comment_id INT PRIMARY KEY,
user_id INT,
post_id INT,
comment_text VARCHAR(255),
comment_date DATE,
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (post_id) REFERENCES posts(post_id)
);
CREATE TABLE followers (
follower_id INT,
following_id INT,
follow_date DATE,
PRIMARY KEY (follower_id, following_id)
);
INSERT INTO users VALUES
(1,'khushi','khushi@gmail.com','2024-01-01'),
(2,'rita','rahritu@gmail.com','2024-01-10'),
(3,'anju','anju@gmail.com','2024-02-05'),
(4,'john','joh@gmail.com','2024-02-20'),
(5,'sarama','sarammaa@gmail.com','2024-03-01');
INSERT INTO posts VALUES
(101,1,'sunset view','2024-03-01'),
(102,2,'gym workout','2024-03-02'),
(103,3,'travel vlog','2024-03-03'),
(104,1,'nature photography','2024-03-05'),
(105,4,'food blogging','2024-03-06');
INSERT INTO likes VALUES
(1,2,101,'2024-03-02'),
(2,3,101,'2024-03-02'),
(3,4,102,'2024-03-03'),
(4,5,103,'2024-03-04'),
(5,1,105,'2024-03-07');
INSERT INTO comments VALUES
(1,2,101,'Amazing picture!','2024-03-02'),
(2,3,102,'Great workout!','2024-03-03'),
(3,4,103,'Nice travel vlog','2024-03-04'),
(4,5,101,'Beautiful sunset','2024-03-05');
INSERT INTO followers VALUES
(2,1,'2024-03-01'),
(3,1,'2024-03-01'),
(4,1,'2024-03-02'),
(5,2,'2024-03-03'),
(1,3,'2024-03-03');
SELECT u.username, COUNT(p.post_id) AS total_posts
FROM users u
JOIN posts p ON u.user_id = p.user_id
GROUP BY u.username
ORDER BY total_posts DESC;
SELECT p.post_id, COUNT(l.like_id) AS total_likes
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id
ORDER BY total_likes DESC;
SELECT following_id AS user_id, COUNT(follower_id) AS followers
FROM followers
GROUP BY following_id
ORDER BY followers DESC;
SELECT username
FROM users
WHERE user_id NOT IN (
SELECT DISTINCT user_id FROM posts
);
SELECT p.post_id
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
WHERE l.like_id IS NULL;
SELECT u.username, COUNT(c.comment_id) AS total_comments
FROM users u
JOIN comments c ON u.user_id = c.user_id
GROUP BY u.username
ORDER BY total_comments DESC;
SELECT * FROM users;
SELECT * FROM posts;
SELECT * FROM likes;