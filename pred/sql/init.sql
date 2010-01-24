CREATE DATABASE pred;
CREATE USER pred IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON pred.* TO 'pred'@'localhost' IDENTIFIED BY 'password';
USE pred;
CREATE TABLE users (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name   VARCHAR(128),
    password VARCHAR(128),
    salt VARCHAR(40),
    e_mail VARCHAR(256),
    admin BOOL
);
CREATE TABLE have_project (
    user_id INT UNSIGNED NOT NULL,
    project_id INT UNSIGNED NOT NULL
);
CREATE TABLE project (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128),
    description VARCHAR(512)
);
CREATE TABLE story (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    project_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    short_description VARCHAR(512),
    description TEXT,
    point TINYINT UNSIGNED,
    priority TINYINT UNSIGNED,
    done BOOL
);
CREATE TABLE task (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    story_id INT UNSIGNED NOT NULL,
    description TEXT
);
INSERT INTO users (name, password, e_mail, admin) VALUES ('ka2u', 'kazuhiro', 'kazuhiro@example.com', TRUE);
