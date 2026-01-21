-- ###############################################
-- DATABASE CREATION SCRIPT
-- PROJECT: Online Bookstore
-- DATE: 2025-11-27
-- VERSION: 1.0
-- ###############################################

CREATE DATABASE IF NOT EXISTS online_bookstore
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE online_bookstore;

CREATE TABLE user_account (
    user_account_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(250) UNIQUE NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    last_login_at TIMESTAMP NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    user_role ENUM('Admin', 'Product Manager', 'Order Manager', 'Staff') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(150) UNIQUE NOT NULL,
    biography TEXT,
    nationality VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id)
);

CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(150) UNIQUE NOT NULL,
    category_description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id)
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(250) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    INDEX index_last_name_email (last_name, email),
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id)
);

CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    number_of_pages INT NOT NULL,
    synopsis VARCHAR(250) NOT NULL,
    publication_year YEAR NOT NULL,
    isbn VARCHAR(17) UNIQUE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    author_id_fk INT NOT NULL,
    INDEX index_title (title),
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (author_id_fk) REFERENCES author(author_id)
);

CREATE TABLE category_book (
    book_id INT NOT NULL,
    category_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id)
);

CREATE TABLE customer_address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    address_line1 VARCHAR(150) NOT NULL,
    address_line2 VARCHAR(150),
    district VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state_code CHAR(2) NOT NULL,
    postal_code VARCHAR(16) NOT NULL,
    country VARCHAR(50) NOT NULL,
    contact_phone VARCHAR(16),
    is_billing BOOLEAN NOT NULL DEFAULT FALSE,
    is_shipping BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    customer_id_fk INT NOT NULL,
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (customer_id_fk) REFERENCES customer(customer_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('Pending', 'Processing', 'Paid', 'On hold', 'Shipped', 'Delivered', 'Completed', 'Canceled', 'Refunded', 'Failed') NOT NULL DEFAULT 'Pending', 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    customer_id_fk INT NOT NULL,
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (customer_id_fk) REFERENCES customer(customer_id)
);

CREATE TABLE order_item (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) AS (quantity * unit_price) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    order_id_fk INT NOT NULL,
    book_id_fk INT NOT NULL,
    INDEX index_order_book (order_id_fk, book_id_fk),
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (order_id_fk) REFERENCES orders(order_id),
    FOREIGN KEY (book_id_fk) REFERENCES book(book_id)
);
CREATE TABLE order_address (
    order_address_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    address_id INT NOT NULL,
    address_type ENUM('Delivery', 'Billing') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    UNIQUE KEY uk_order_address_type (order_id, address_type),
    INDEX idx_order_address (order_id, address_type),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (address_id) REFERENCES customer_address(address_id),
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id)
);

CREATE TABLE order_status_log (
    log_status INT AUTO_INCREMENT PRIMARY KEY,
    old_status ENUM('Pending', 'Processing', 'Paid', 'On hold', 'Shipped', 'Delivered', 'Completed', 'Canceled', 'Refunded', 'Failed'),
    new_status ENUM('Pending', 'Processing', 'Paid', 'On hold', 'Shipped', 'Delivered', 'Completed', 'Canceled', 'Refunded', 'Failed'),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     updated_by INT NOT NULL DEFAULT 1,
    order_id_fk INT NOT NULL,
    INDEX index_order_id (order_id_fk),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (order_id_fk) REFERENCES orders(order_id)
);

CREATE TABLE storage_location (
    storage_location_id INT AUTO_INCREMENT PRIMARY KEY,
    storage_name VARCHAR(100) NOT NULL,
    storage_address_line1 VARCHAR(150) NOT NULL,
    storage_address_line2 VARCHAR(150),
    storage_district VARCHAR(50) NOT NULL,
    storage_city VARCHAR(100) NOT NULL,
    storage_state CHAR(2) NOT NULL,
    storage_postal_code VARCHAR(16) NOT NULL,
    storage_country VARCHAR(50) NOT NULL,
    storage_contact_phone VARCHAR(16),
    storage_type ENUM('Main Warehouse', 'Store', 'Distribution Center', 'Returns Center') NOT NULL,
    storage_capacity INT NOT NULL,
    storage_status BOOLEAN NOT NULL DEFAULT TRUE,
    storage_manager INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (storage_manager) REFERENCES user_account(user_account_id)
);

CREATE TABLE book_inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    book_id_fk INT NOT NULL,
    storage_location_id_fk INT NOT NULL,
    INDEX index_book_id_storage_location_id (book_id_fk, storage_location_id_fk),
    UNIQUE KEY unique_book_location (book_id_fk, storage_location_id_fk),
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (book_id_fk) REFERENCES book(book_id),
    FOREIGN KEY (storage_location_id_fk) REFERENCES storage_location(storage_location_id)
);

CREATE TABLE inventory_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_quantity INT NOT NULL CHECK (transaction_quantity > 0),
    transaction_type ENUM('purchase', 'sale', 'transfer', 'adjustment') NOT NULL,
    transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    from_storage_location_id INT NULL,
    to_storage_location_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    book_id_fk INT NOT NULL,
    created_by INT NOT NULL DEFAULT 1,
    updated_by INT NOT NULL DEFAULT 1,
    FOREIGN KEY (book_id_fk) REFERENCES book(book_id),
    FOREIGN KEY (from_storage_location_id) REFERENCES storage_location(storage_location_id),
    FOREIGN KEY (to_storage_location_id) REFERENCES storage_location(storage_location_id),
    FOREIGN KEY (created_by) REFERENCES user_account(user_account_id),
    FOREIGN KEY (updated_by) REFERENCES user_account(user_account_id)
);

CREATE TABLE audit_log (
    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    operation_type ENUM('UPDATE', 'DELETE') NOT NULL,
    record_primary_key VARCHAR(255) NOT NULL,
    old_data JSON NULL,
    new_data JSON NULL,
    changed_by INT NOT NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_table_operation (table_name, operation_type),
    INDEX idx_changed_by (changed_by),
    INDEX idx_changed_at (changed_at),
   FOREIGN KEY (changed_by) REFERENCES user_account(user_account_id)
);
