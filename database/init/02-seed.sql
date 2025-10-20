-- NearBuy Test Data
-- This file populates the database with test data for development

-- Insert test categories
INSERT INTO categories (id, name, description, icon) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Electronics', 'Electronic devices and accessories', 'laptop'),
    ('22222222-2222-2222-2222-222222222222', 'Furniture', 'Home and office furniture', 'couch'),
    ('33333333-3333-3333-3333-333333333333', 'Clothing', 'Apparel and accessories', 'shirt'),
    ('44444444-4444-4444-4444-444444444444', 'Books', 'Books and magazines', 'book'),
    ('55555555-5555-5555-5555-555555555555', 'Sports', 'Sports equipment and gear', 'basketball'),
    ('66666666-6666-6666-6666-666666666666', 'Home & Garden', 'Home decor and gardening supplies', 'home')
ON CONFLICT (id) DO NOTHING;

-- Insert test users (password: 'password123' - hashed with bcrypt)
INSERT INTO users (id, email, username, password_hash, full_name, phone) VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'john.doe@example.com', 'johndoe', '$2b$10$rT9Y7mLWnH5E3W9mD5fZ6.K6vZ9mD5fZ6K6vZ9mD5fZ6K6vZ9mD5f', 'John Doe', '+1234567890'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'jane.smith@example.com', 'janesmith', '$2b$10$rT9Y7mLWnH5E3W9mD5fZ6.K6vZ9mD5fZ6K6vZ9mD5fZ6K6vZ9mD5f', 'Jane Smith', '+1234567891'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'bob.johnson@example.com', 'bobjohnson', '$2b$10$rT9Y7mLWnH5E3W9mD5fZ6.K6vZ9mD5fZ6K6vZ9mD5fZ6K6vZ9mD5f', 'Bob Johnson', '+1234567892'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'alice.williams@example.com', 'alicew', '$2b$10$rT9Y7mLWnH5E3W9mD5fZ6.K6vZ9mD5fZ6K6vZ9mD5fZ6K6vZ9mD5f', 'Alice Williams', '+1234567893')
ON CONFLICT (id) DO NOTHING;

-- Insert test locations
INSERT INTO locations (id, name, address, city, state, country, postal_code, latitude, longitude) VALUES
    ('99999999-9999-9999-9999-999999999991', 'Downtown Coffee Shop', '123 Main St', 'San Francisco', 'CA', 'USA', '94102', 37.7749, -122.4194),
    ('99999999-9999-9999-9999-999999999992', 'Park View Apartments', '456 Oak Ave', 'San Francisco', 'CA', 'USA', '94110', 37.7599, -122.4148),
    ('99999999-9999-9999-9999-999999999993', 'Tech Hub Coworking', '789 Mission St', 'San Francisco', 'CA', 'USA', '94103', 37.7849, -122.3994),
    ('99999999-9999-9999-9999-999999999994', 'Sunset District Home', '321 Sunset Blvd', 'San Francisco', 'CA', 'USA', '94122', 37.7599, -122.4989)
ON CONFLICT (id) DO NOTHING;

-- Insert test products
INSERT INTO products (id, seller_id, category_id, location_id, title, description, price, condition, is_available, image_urls) VALUES
    ('00000001-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', '99999999-9999-9999-9999-999999999991',
     'MacBook Pro 2020', 'Gently used MacBook Pro 13-inch, 8GB RAM, 256GB SSD. Excellent condition, minimal scratches.', 899.99, 'Like New', TRUE,
     ARRAY['https://example.com/images/macbook1.jpg', 'https://example.com/images/macbook2.jpg']),

    ('00000001-0000-0000-0000-000000000002', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', '99999999-9999-9999-9999-999999999991',
     'Wireless Headphones', 'Sony WH-1000XM4 noise-cancelling headphones. Used for 6 months, works perfectly.', 249.99, 'Good', TRUE,
     ARRAY['https://example.com/images/headphones1.jpg']),

    ('00000001-0000-0000-0000-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', '99999999-9999-9999-9999-999999999992',
     'Modern Desk Chair', 'Ergonomic office chair with lumbar support. Black mesh, adjustable height. Moving sale!', 150.00, 'Good', TRUE,
     ARRAY['https://example.com/images/chair1.jpg', 'https://example.com/images/chair2.jpg']),

    ('00000001-0000-0000-0000-000000000004', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', '99999999-9999-9999-9999-999999999992',
     'Wooden Bookshelf', '5-tier bookshelf, solid wood construction. 6 feet tall. Some minor wear.', 75.00, 'Fair', TRUE,
     ARRAY['https://example.com/images/bookshelf1.jpg']),

    ('00000001-0000-0000-0000-000000000005', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '33333333-3333-3333-3333-333333333333', '99999999-9999-9999-9999-999999999993',
     'Winter Jacket - Size L', 'North Face winter jacket, size Large. Warm and waterproof. Barely worn.', 120.00, 'Like New', TRUE,
     ARRAY['https://example.com/images/jacket1.jpg']),

    ('00000001-0000-0000-0000-000000000006', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '44444444-4444-4444-4444-444444444444', '99999999-9999-9999-9999-999999999993',
     'Programming Books Collection', 'Set of 5 programming books: Clean Code, Design Patterns, Refactoring, and more.', 60.00, 'Good', TRUE,
     ARRAY['https://example.com/images/books1.jpg']),

    ('00000001-0000-0000-0000-000000000007', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '55555555-5555-5555-5555-555555555555', '99999999-9999-9999-9999-999999999994',
     'Mountain Bike', '21-speed mountain bike, 26-inch wheels. Great for trails. Regular maintenance done.', 280.00, 'Good', TRUE,
     ARRAY['https://example.com/images/bike1.jpg', 'https://example.com/images/bike2.jpg']),

    ('00000001-0000-0000-0000-000000000008', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '55555555-5555-5555-5555-555555555555', '99999999-9999-9999-9999-999999999994',
     'Yoga Mat & Blocks Set', 'Premium yoga mat with carrying strap plus 2 foam blocks. Lightly used.', 35.00, 'Like New', TRUE,
     ARRAY['https://example.com/images/yoga1.jpg']),

    ('00000001-0000-0000-0000-000000000009', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '66666666-6666-6666-6666-666666666666', '99999999-9999-9999-9999-999999999991',
     'Indoor Plant Collection', 'Set of 3 potted plants: succulent, snake plant, and pothos. Easy to care for.', 45.00, 'Excellent', TRUE,
     ARRAY['https://example.com/images/plants1.jpg']),

    ('00000001-0000-0000-0000-000000000010', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111', '99999999-9999-9999-9999-999999999992',
     'Gaming Mouse & Keyboard', 'RGB gaming peripherals combo. Mouse has programmable buttons. Both wired.', 85.00, 'Good', FALSE,
     ARRAY['https://example.com/images/gaming1.jpg'])
ON CONFLICT (id) DO NOTHING;

-- Insert test favorites
INSERT INTO favorites (user_id, product_id) VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000001-0000-0000-0000-000000000003'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000001-0000-0000-0000-000000000007'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '00000001-0000-0000-0000-000000000001'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '00000001-0000-0000-0000-000000000002'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', '00000001-0000-0000-0000-000000000004'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', '00000001-0000-0000-0000-000000000001')
ON CONFLICT (user_id, product_id) DO NOTHING;

-- Insert test messages
INSERT INTO messages (sender_id, receiver_id, product_id, content, is_read) VALUES
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000001-0000-0000-0000-000000000001',
     'Hi! Is the MacBook still available?', FALSE),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '00000001-0000-0000-0000-000000000001',
     'Yes, it is! Would you like to meet up to see it?', TRUE),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '00000001-0000-0000-0000-000000000003',
     'Would you take $130 for the desk chair?', FALSE),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000001-0000-0000-0000-000000000002',
     'Are the headphones still under warranty?', FALSE)
ON CONFLICT DO NOTHING;
