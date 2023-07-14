CREATE TABLE IF NOT EXISTS users (
  id serial PRIMARY KEY,
  name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  password text NOT NULL,
  address varchar(255),
  phone varchar(255),
   date varchar(255),
  code varchar(255),
  role varchar(255)
);
CREATE TABLE IF NOT EXISTS book (
  ID serial PRIMARY KEY,
  Ten_sach varchar(255) NOT NULL,
  Mo_ta text,
  ngay_xuataban varchar(255),
  So_trang integer,
  IBSN varchar(255),
  Loai_sach varchar(255),
  Nha_xuat_ban varchar(255)
);


CREATE TABLE IF NOT EXISTS manage_book (
  ID serial PRIMARY KEY,
  user_id integer,
  registration_date varchar(255),
  book_name varchar(255),
  book_id integer,
  quantity integer,
  borrow_code varchar(255)
  
);
INSERT INTO manage_book (user_id, registration_date, book_name, book_id, quantity, borrow_code)
VALUES (1, '2023-07-09', 'Book A', 101, 3, 'BC001');
INSERT INTO manage_book (user_id, registration_date, book_name, book_id, quantity, borrow_code)
VALUES (2, '2023-07-10', 'Book B', 102, 1, NULL);
INSERT INTO manage_book (user_id, registration_date, book_name, book_id, quantity, borrow_code)
VALUES (3, '2023-07-11', 'Book C', 103, 2, 'BC003');



UPDATE users SET role = 'Admin' WHERE id=3;
drop table manage_book;
select*from users;
select*from manage_book;
select*from book;
INSERT INTO manage_book (user_id, registration_date, book_name, book_id, quantity, borrow_code)
VALUES (1, '2023-07-09', 'Book Title', 123, 5, 'ABC123');
SELECT * FROM manage_book WHERE user_id =1;
SELECT * FROM book WHERE ID =1;
SELECT pg_stat_reset();




