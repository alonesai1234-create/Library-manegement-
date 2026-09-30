CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;
CREATE TABLE IF NOT EXISTS users(id INT AUTO_INCREMENT PRIMARY KEY,username VARCHAR(50) UNIQUE NOT NULL,password_hash VARCHAR(255) NOT NULL,role ENUM('admin','librarian') DEFAULT 'librarian');
CREATE TABLE IF NOT EXISTS books(id INT AUTO_INCREMENT PRIMARY KEY,isbn VARCHAR(30) UNIQUE,title VARCHAR(200) NOT NULL,author VARCHAR(150) NOT NULL,category VARCHAR(100),publisher VARCHAR(150),publication_year YEAR,total_copies INT DEFAULT 1,available_copies INT DEFAULT 1,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS members(id INT AUTO_INCREMENT PRIMARY KEY,member_code VARCHAR(30) UNIQUE NOT NULL,name VARCHAR(150) NOT NULL,email VARCHAR(150),phone VARCHAR(30),address TEXT,status ENUM('active','inactive') DEFAULT 'active',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS loans(id INT AUTO_INCREMENT PRIMARY KEY,book_id INT NOT NULL,member_id INT NOT NULL,issue_date DATETIME DEFAULT CURRENT_TIMESTAMP,due_date DATE NOT NULL,returned_at DATETIME NULL,fine_amount DECIMAL(10,2) DEFAULT 0,issued_by INT,returned_to INT,FOREIGN KEY(book_id) REFERENCES books(id),FOREIGN KEY(member_id) REFERENCES members(id),FOREIGN KEY(issued_by) REFERENCES users(id) ON DELETE SET NULL,FOREIGN KEY(returned_to) REFERENCES users(id) ON DELETE SET NULL);
-- Default login: admin / admin123. The bcrypt hash below is for admin123.
INSERT IGNORE INTO users(username,password_hash,role) VALUES('admin','$2a$10$5uQv5x7YvZ1jXhQYv8L8Me8J3rV8wVxkV7YVxQJmM4mQwR5mJ0p6y','admin');
INSERT IGNORE INTO books(isbn,title,author,category,publisher,publication_year,total_copies,available_copies) VALUES('9780132350884','Clean Code','Robert C. Martin','Programming','Prentice Hall',2008,5,5);
INSERT IGNORE INTO members(member_code,name,email,phone,address) VALUES('MEM001','Demo Member','demo@example.com','9000000000','Demo Address');
