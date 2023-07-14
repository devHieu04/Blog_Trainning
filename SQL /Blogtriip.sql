-- Tạo bảng admins
CREATE TABLE admins (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

-- Tạo bảng users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL
);

-- Tạo bảng articles
CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  banner VARCHAR(255) NOT NULL,
  introduction TEXT NOT NULL,
  content TEXT NOT NULL,
  admin_id INTEGER REFERENCES admins(id) NOT NULL
);

-- Tạo bảng comments
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  image VARCHAR(255) NOT NULL,
  user_id INTEGER REFERENCES users(id) NOT NULL,
  article_id INTEGER REFERENCES articles(id) NOT NULL
);
select*from admins;
select*from comments;