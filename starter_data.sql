DROP DATABASE ig_clone;
CREATE DATABASE ig_clone;
USE ig_clone;

CREATE TABLE users (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE comments (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    comment_text VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    photo_id INTEGER NOT NULL,
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE likes (
	user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    photo_id INTEGER NOT NULL,
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (user_id, photo_id)
);

CREATE TABLE follows (
	follower_id INTEGER NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    followee_id INTEGER NOT NULL,
    FOREIGN KEY (followee_id) REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (follower_id, followee_id)
);

CREATE TABLE tags (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
	photo_id INTEGER NOT NULL,
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    tag_id INTEGER NOT NULL,
    FOREIGN KEY (tag_id) REFERENCES tags(id),
    PRIMARY KEY (photo_id, tag_id)
);

INSERT INTO users (username) VALUES
('BlueTheCat'),
('CharlieBrown'),
('ColtSteele');

INSERT INTO photos (image_url, user_id) VALUES
('/dsada', 1),
('/ddsvd', 2),
('/dcsdc', 2);

INSERT INTO comments (comment_text, user_id, photo_id) VALUES
('Meow!', 1, 2),
('Amazing Shot!', 3, 2),
('I <3 This', 2, 1);

INSERT INTO likes (user_id, photo_id) VALUES 
(1,1),
(2,1),
(1,2),
(1,3),
(3,3);

INSERT INTO follows (follower_id, followee_id) VALUES
(1,2),
(1,3),
(3,1),
(2,3);

INSERT INTO tags (tag_name) VALUES
('adorable'),
('cute'),
('sunrise');

INSERT INTO photo_tags (photo_id, tag_id) VALUES 
(1,1),
(1,2),
(2,3),
(3,2);

