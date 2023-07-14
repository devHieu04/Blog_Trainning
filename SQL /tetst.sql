select*from users;
ALTER TABLE users
DROP COLUMN password_digest;
ALTER TABLE users ADD COLUMN password text;

ALTER TABLE users 
RENAME COLUMN name TO username;
drop table admins;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  phone VARCHAR(20) 
);
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  banner VARCHAR(255) NOT NULL,
  introduction TEXT NOT NULL,
  content TEXT NOT NULL,
  users_id INTEGER REFERENCES users(id) 
);
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  image VARCHAR(255) NOT NULL,
  user_id INTEGER REFERENCES users(id) NOT NULL,
  post_id INTEGER REFERENCES posts(id) NOT NULL
);
