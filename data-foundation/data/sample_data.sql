-- ===============================================
-- SAMPLE DATA
-- Demonstration and testing data
-- ===============================================

-- 1) Customers
INSERT INTO customer
(first_name, last_name, email, phone, password_hash,
 registration_date, last_login, is_active, created_by, updated_by)
VALUES
('Rose', 'Smith', 'rose.smith@example.com', '+1-555-888-2222',
 '$2y$10$hash1', '2025-01-12 09:21:00', '2025-02-01 16:45:00', TRUE, 1, 1),
('Tulip', 'Miller', 'tulip.miller@example.com', '+1-555-999-3333',
 '$2y$10$hash2', '2025-02-03 14:30:00', NULL, TRUE, 1, 1),
('Daisy', 'Smith', 'daisy.smith@example.com', '+1-555-444-5555',
 '$2y$10$hash3', '2025-03-08 11:10:00', '2025-04-10 19:55:00', TRUE, 1, 1);

-- 2) Books
INSERT INTO book
(title, number_of_pages, synopsis, publication_year, isbn, price, author_id_fk, created_by, updated_by)
VALUES
('The Silent Shore', 312, 'A journalist uncovers a hidden truth in a quiet coastal town.', 2021, '9780316423909', 19.90, 1, 1, 1),
('Echoes of Tomorrow', 428, 'A scientist faces the consequences of a dangerous discovery.', 2023, '9780593186589', 24.50, 2, 1, 1),
('The Last Ember', 289, 'A young warrior must protect her homeland from an ancient threat.', 2019, '9781250301696', 17.75, 3, 1, 1);

-- 3) Book categories (M:N)
INSERT INTO category_book (book_id, category_id, created_by, updated_by)
VALUES
(1, 5, 1, 1),
(1, 4, 1, 1),
(2, 2, 1, 1),
(3, 1, 1, 1);

-- 4) Addresses
INSERT INTO customer_address
(address_line1, address_line2, district, city, state_code,
 postal_code, country, contact_phone,
 is_billing, is_shipping, customer_id_fk, created_by, updated_by)
VALUES
('742 sunflower Street', 'Apt 12B', 'Greenwood', 'Seattle', 'WA',
 '98101', 'United States', '+1-206-555-7777',
 TRUE, TRUE, 1, 1, 1);

-- 5) Orders
INSERT INTO orders
(order_date, order_status, customer_id_fk, created_by, updated_by)
VALUES
('2025-02-15 14:32:00', 'Delivered', 1, 1, 1);

-- 6) Order items
INSERT INTO order_item
(quantity, unit_price, order_id_fk, book_id_fk, created_by, updated_by)
VALUES
(1, 19.90, 1, 1, 1, 1),
(2, 24.50, 1, 2, 1, 1);

-- 7) Order address (delivery)
INSERT INTO order_address
(order_id, address_id, address_type, created_by, updated_by)
VALUES
(1, 1, 'Delivery', 1, 1);

-- 8) Inventory
INSERT INTO book_inventory
(quantity, book_id_fk, storage_location_id_fk, created_by, updated_by)
VALUES
(120, 1, 1, 1, 1),
(85,  2, 1, 1, 1),
(200, 3, 1, 1, 1);

-- 9) Inventory transactions
INSERT INTO inventory_transactions
(transaction_quantity, transaction_type, transaction_date,
 from_storage_location_id, to_storage_location_id,
 book_id_fk, created_by, updated_by)
VALUES
(50, 'purchase', '2025-01-10 09:00:00', NULL, 1, 1, 1, 1),
(3, 'sale', '2025-02-05 11:45:00', 1, NULL, 3, 1, 1);
