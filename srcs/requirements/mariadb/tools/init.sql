-- WordPress database initialization script

-- Create database
CREATE DATABASE IF NOT EXISTS wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create WordPress user
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppassword123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';

-- Create admin user
CREATE USER IF NOT EXISTS 'superuser'@'%' IDENTIFIED BY 'adminpassword123';
GRANT ALL PRIVILEGES ON *.* TO 'superuser'@'%' WITH GRANT OPTION;

-- Flush privileges
FLUSH PRIVILEGES;