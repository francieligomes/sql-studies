-- ===============================================
-- SEED DATA
-- Required system-level data
-- ===============================================

-- 1) User accounts (system and staff)
INSERT INTO user_account
(first_name, last_name, email, phone_number, password_hash, last_login_at, is_active, user_role)
VALUES
('System', 'User', 'system@bookstore.com', '+0-000-000-0000', 'SYSTEM', NULL, TRUE,'Admin'),
('Emily', 'Clark', 'emily.clark@bookstore.com', '+1-202-555-0148', '$2y$10$Abc123', '2025-11-20 09:15:22', TRUE, 'Admin'),
('Michael', 'Reeves', 'michael.reeves@bookstore.com', '+1-202-555-0199', '$2y$10$Xyz890', '2025-11-19 17:42:10', TRUE, 'Product Manager'),
('Sarah', 'Bennett', 'sarah.bennett@bookstore.com', '+1-202-555-0113', '$2y$10$Klm567', '2025-11-22 13:05:47', TRUE, 'Order Manager'),
('Jason', 'Miller', 'jason.miller@bookstore.com', '+1-202-555-0165', '$2y$10$Qwe345', '2025-11-21 08:30:59', TRUE, 'Staff');

-- 2) Authors
INSERT INTO author (author_name, biography, nationality, created_by, updated_by)
VALUES
('Akiro Haneda', 'Japanese writer known for surreal narratives.', 'Japanese', 1, 1),
('Lucía Valverde', 'Chilean novelist recognized for magical realism.', 'Chilean', 1, 1),
('Ethan Blackwell', 'British author of fantasy and graphic novels.', 'British', 1, 1),
('Nadine Okafor', 'Nigerian writer focused on feminism and identity.', 'Nigerian', 1, 1),
('Marcus H. Rowan', 'American novelist best known for epic fantasy.', 'American', 1, 1);

-- 3) Categories
INSERT INTO category (category_name, category_description, created_by, updated_by)
VALUES
('Fantasy', 'Books that explore magical worlds and supernatural elements.', 1, 1),
('Science Fiction', 'Stories involving advanced technology, space, or futuristic concepts.', 1, 1),
('Self-Help', 'Guides focused on personal growth and life improvement.', 1, 1),
('Historical Fiction', 'Narratives set in real historical periods with fictional characters.', 1, 1),
('Mystery', 'Books centered around solving crimes, puzzles, or hidden truths.', 1, 1);

-- 4) Storage locations
INSERT INTO storage_location
(storage_name, storage_address_line1, storage_address_line2, storage_district, storage_city,
 storage_state, storage_postal_code, storage_country, storage_contact_phone,
 storage_type, storage_capacity, storage_status, storage_manager, created_by, updated_by)
VALUES
('Central Distribution Hub', '203 Sunset Blvd', 'Unit 5', 'Highland', 'Los Angeles',
 'CA', '90026', 'United States', '+1-213-555-7742',
 'Main Warehouse', 50000, TRUE, 2, 1, 1);
