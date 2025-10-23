-- Sample Data for Petnic Studio Database
-- This file contains sample data to populate the database for testing and demonstration

-- Insert sample categories
INSERT INTO categories (name, slug, description, sort_order) VALUES
('T-Shirts', 't-shirts', 'Custom pet portrait t-shirts', 1),
('Hoodies & Sweatshirts', 'hoodies', 'Cozy hoodies and sweatshirts with pet designs', 2),
('Mugs', 'mugs', 'Personalized pet mugs for coffee and tea lovers', 3),
('Canvas Prints', 'canvas', 'High-quality canvas prints of pet portraits', 4),
('Phone Cases', 'phone-cases', 'Custom phone cases featuring your pet', 5),
('Tote Bags', 'tote-bags', 'Stylish tote bags with pet designs', 6),
('Stickers', 'stickers', 'Fun pet stickers for laptops and more', 7),
('Decals', 'decals', 'Vinyl decals for cars and windows', 8),
('Calendar', 'calendar', 'Custom pet calendars', 9),
('Tags', 'tags', 'Pet ID tags and accessories', 10),
('Pet Accessories', 'pet-accessories', 'Various pet accessories and products', 11),
('Memorial Products', 'memorial', 'In loving memory products for beloved pets', 12),
('Gift Bundles', 'bundles', 'Themed gift boxes and bundles', 13),
('Seasonal Limited Editions', 'seasonal', 'Holiday and seasonal themed products', 14),
('Digital Downloads', 'digital', 'Instant digital downloads', 15);

-- Insert sample design styles
INSERT INTO design_styles (name, slug, description, price_modifier, processing_time, sort_order) VALUES
('Cartoon', 'cartoon', 'Fun cartoon-style pet portraits', 0.00, 24, 1),
('Royal Portrait', 'royal', 'Elegant royal-style pet portraits', 5.00, 48, 2),
('Pencil Sketch', 'sketch', 'Artistic pencil sketch style', 3.00, 36, 3),
('Anime Style', 'anime', 'Japanese anime-inspired pet art', 4.00, 48, 4),
('Pop Art', 'pop-art', 'Vibrant pop art style portraits', 6.00, 48, 5),
('AI Generated', 'ai-generated', 'AI-powered artistic styles', 2.00, 12, 6),
('Clip Art', 'clip-art', 'Simple clip art style designs', 0.00, 24, 7),
('Memorial', 'memorial', 'Respectful memorial style for remembrance', 3.00, 48, 8);

-- Insert sample products
INSERT INTO products (name, slug, description, short_description, sku, price, original_price, category_id, product_type, featured, stock_quantity) VALUES
('Custom Pet Portrait T-Shirt', 'custom-pet-portrait-tshirt', 'Transform your pet into a beautiful custom t-shirt design. Available in multiple styles and sizes.', 'Custom pet portrait on premium quality t-shirt', 'PET-TSHIRT-001', 24.99, 34.99, 1, 'physical', TRUE, 100),
('Personalized Pet Mug', 'personalized-pet-mug', 'Start your morning with your beloved pet! High-quality ceramic mug with custom pet design.', 'Custom pet design on ceramic mug', 'PET-MUG-001', 19.99, 24.99, 3, 'physical', TRUE, 75),
('Custom Canvas Print', 'custom-canvas-print', 'Premium canvas print featuring your pet in artistic style. Perfect for home decoration.', 'High-quality canvas print of your pet', 'PET-CANVAS-001', 39.99, 49.99, 4, 'physical', TRUE, 50),
('Pet Memorial Pillow', 'pet-memorial-pillow', 'Honor your beloved pet with a custom memorial pillow. Soft and comforting remembrance.', 'Memorial pillow with custom pet design', 'PET-PILLOW-001', 29.99, 39.99, 12, 'physical', TRUE, 30),
('Custom Pet Hoodie', 'custom-pet-hoodie', 'Stay warm with your pet close to your heart. Premium hoodie with custom pet design.', 'Custom pet design on premium hoodie', 'PET-HOODIE-001', 44.99, 54.99, 2, 'physical', FALSE, 60),
('Pet Phone Case', 'pet-phone-case', 'Protect your phone with style! Custom phone case featuring your pet.', 'Custom pet design phone case', 'PET-CASE-001', 22.99, 27.99, 5, 'physical', FALSE, 80),
('In Loving Memory Frame', 'loving-memory-frame', 'Beautiful memorial frame to honor your beloved pet. Elegant design with custom text.', 'Memorial frame for pet remembrance', 'PET-FRAME-001', 34.99, 44.99, 12, 'physical', FALSE, 25),
('Pet Birthday Bundle Box', 'pet-birthday-bundle', 'Complete birthday celebration bundle for your pet. Includes multiple custom items.', 'Birthday celebration bundle', 'PET-BUNDLE-001', 59.99, 79.99, 13, 'physical', FALSE, 15),
('Christmas Pet Mug', 'christmas-pet-mug', 'Holiday-themed mug featuring your pet in festive Christmas design.', 'Christmas themed pet mug', 'PET-XMAS-MUG', 24.99, 29.99, 14, 'physical', FALSE, 40),
('Pet Urn Memorial Tag', 'pet-urn-tag', 'Elegant memorial tag for pet urns. Personalized with pet name and dates.', 'Memorial tag for pet urns', 'PET-URN-TAG', 19.99, 24.99, 12, 'physical', FALSE, 20),
('Pet Portrait Illustration - Digital', 'pet-portrait-digital', 'Vector or cartoon-style digital download perfect for printing or sharing.', 'Digital pet portrait illustration', 'PET-DIGITAL-001', 15.99, 24.99, 15, 'digital', TRUE, 999),
('Printable Wall Art - Digital', 'printable-wall-art', 'Instant digital download with pet love quotes and beautiful designs.', 'Printable wall art with pet themes', 'PET-WALL-ART', 9.99, 14.99, 15, 'digital', TRUE, 999),
('Custom E-Greeting Cards', 'pet-greeting-cards', 'Personalized cards for pet birthdays and special occasions.', 'Custom pet greeting cards', 'PET-CARDS-001', 7.99, 12.99, 15, 'digital', FALSE, 999),
('Mobile Wallpapers - Pet Themed', 'pet-mobile-wallpapers', 'Pet-themed phone backgrounds with name and breed art.', 'Custom pet mobile wallpapers', 'PET-WALLPAPER', 5.99, 9.99, 15, 'digital', FALSE, 999),
('Digital Coloring Books', 'pet-coloring-books', 'Custom-made pet-themed pages downloadable as PDFs.', 'Pet themed digital coloring books', 'PET-COLORING', 12.99, 19.99, 15, 'digital', FALSE, 999);

-- Insert sample product attributes
INSERT INTO product_attributes (name, slug, type, sort_order, is_required) VALUES
('Size', 'size', 'select', 1, TRUE),
('Color', 'color', 'color', 2, TRUE),
('Material', 'material', 'select', 3, FALSE),
('Style', 'style', 'select', 4, FALSE);

-- Insert sample attribute values
INSERT INTO product_attribute_values (attribute_id, value, sort_order) VALUES
-- Sizes
(1, 'XS', 1), (1, 'S', 2), (1, 'M', 3), (1, 'L', 4), (1, 'XL', 5), (1, 'XXL', 6),
-- Colors
(2, 'Black', 1), (2, 'White', 2), (2, 'Navy', 3), (2, 'Gray', 4), (2, 'Red', 5),
-- Materials
(3, 'Cotton', 1), (3, 'Cotton Blend', 2), (3, 'Polyester', 3), (3, 'Canvas', 4),
-- Styles
(4, 'Classic Fit', 1), (4, 'Slim Fit', 2), (4, 'Relaxed Fit', 3);

-- Insert sample users
INSERT INTO users (email, password_hash, first_name, last_name, phone, email_verified) VALUES
('john.doe@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/RK.s5uO.G', 'John', 'Doe', '+1234567890', TRUE),
('jane.smith@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/RK.s5uO.G', 'Jane', 'Smith', '+1234567891', TRUE),
('mike.johnson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/RK.s5uO.G', 'Mike', 'Johnson', '+1234567892', TRUE),
('sarah.wilson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/RK.s5uO.G', 'Sarah', 'Wilson', '+1234567893', TRUE),
('admin@petnicstudio.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/RK.s5uO.G', 'Admin', 'User', '+1234567894', TRUE);

-- Insert sample pet profiles
INSERT INTO pet_profiles (user_id, name, species, breed, age, color, size, personality_traits) VALUES
(1, 'Buddy', 'dog', 'Golden Retriever', 3, 'Golden', 'large', 'Friendly, energetic, loves to play fetch'),
(1, 'Whiskers', 'cat', 'Persian', 2, 'White', 'medium', 'Calm, loves to nap, very affectionate'),
(2, 'Max', 'dog', 'German Shepherd', 5, 'Black and Tan', 'large', 'Loyal, protective, intelligent'),
(3, 'Luna', 'cat', 'Siamese', 1, 'Cream and Brown', 'small', 'Playful, vocal, curious about everything'),
(4, 'Charlie', 'dog', 'Labrador', 4, 'Chocolate', 'large', 'Gentle, loves swimming, great with kids');

-- Insert sample orders
INSERT INTO orders (order_number, user_id, status, payment_status, total_amount, subtotal, tax_amount, shipping_amount, currency, payment_method) VALUES
('ORD-2025-001', 1, 'delivered', 'paid', 29.98, 24.99, 2.00, 2.99, 'USD', 'credit_card'),
('ORD-2025-002', 2, 'shipped', 'paid', 44.98, 39.99, 3.20, 1.79, 'USD', 'paypal'),
('ORD-2025-003', 3, 'processing', 'paid', 64.97, 59.99, 4.80, 0.18, 'USD', 'credit_card'),
('ORD-2025-004', 4, 'pending', 'pending', 34.98, 29.99, 2.40, 2.59, 'USD', 'credit_card');

-- Insert sample order items
INSERT INTO order_items (order_id, product_id, product_name, product_sku, quantity, unit_price, total_price, design_style_id, design_style_name) VALUES
(1, 1, 'Custom Pet Portrait T-Shirt', 'PET-TSHIRT-001', 1, 24.99, 24.99, 1, 'Cartoon'),
(2, 3, 'Custom Canvas Print', 'PET-CANVAS-001', 1, 39.99, 39.99, 2, 'Royal Portrait'),
(3, 8, 'Pet Birthday Bundle Box', 'PET-BUNDLE-001', 1, 59.99, 59.99, 1, 'Cartoon'),
(4, 4, 'Pet Memorial Pillow', 'PET-PILLOW-001', 1, 29.99, 29.99, 8, 'Memorial');

-- Insert sample product reviews
INSERT INTO product_reviews (product_id, user_id, order_id, rating, title, review_text, is_verified_purchase, is_approved) VALUES
(1, 1, 1, 5, 'Amazing Quality!', 'Absolutely love my custom pet portrait! The quality is amazing and the design process was so easy. My dog looks like royalty!', TRUE, TRUE),
(3, 2, 2, 5, 'Perfect Gift', 'Perfect gift for my wife who lost her cat recently. The memorial pillow brought tears of joy. Highly recommend!', TRUE, TRUE),
(1, 3, NULL, 4, 'Great Product', 'The cartoon style t-shirt turned out exactly as I imagined. Great quality and fast shipping. Will definitely order again!', FALSE, TRUE);

-- Insert sample coupons
INSERT INTO coupons (code, description, discount_type, discount_value, minimum_amount, usage_limit, valid_from, valid_until, is_active) VALUES
('WELCOME10', 'Welcome discount for new customers', 'percentage', 10.00, 25.00, 1000, '2025-01-01 00:00:00', '2025-12-31 23:59:59', TRUE),
('FREESHIP50', 'Free shipping on orders over $50', 'fixed_amount', 5.99, 50.00, NULL, '2025-01-01 00:00:00', '2025-12-31 23:59:59', TRUE),
('PETLOVE20', '20% off all pet products', 'percentage', 20.00, 0.00, 500, '2025-01-01 00:00:00', '2025-06-30 23:59:59', TRUE);

-- Insert sample memberships
INSERT INTO memberships (user_id, membership_type, status, start_date, end_date, auto_renew) VALUES
(1, 'yearly', 'active', '2025-01-01', '2026-01-01', TRUE),
(2, 'monthly', 'active', '2025-01-15', '2025-02-15', TRUE),
(4, 'lifetime', 'active', '2025-01-10', NULL, FALSE);

-- Insert sample affiliates
INSERT INTO affiliates (user_id, affiliate_code, commission_rate, status, total_earnings, total_referrals, payment_email, joined_at, approved_at) VALUES
(3, 'MIKE2025', 20.00, 'active', 125.50, 8, 'mike.johnson@email.com', '2025-01-05 10:00:00', '2025-01-06 14:30:00'),
(4, 'SARAH2025', 25.00, 'active', 89.75, 5, 'sarah.wilson@email.com', '2025-01-10 09:15:00', '2025-01-11 11:45:00');

-- Insert sample newsletter subscriptions
INSERT INTO newsletter_subscriptions (email, first_name, last_name, source) VALUES
('john.doe@email.com', 'John', 'Doe', 'website'),
('jane.smith@email.com', 'Jane', 'Smith', 'checkout'),
('newsletter1@example.com', 'Pet', 'Lover', 'popup'),
('newsletter2@example.com', 'Dog', 'Owner', 'website');

-- Insert sample blog categories
INSERT INTO blog_categories (name, slug, description, sort_order) VALUES
('Pet Care', 'pet-care', 'Tips and advice for pet care', 1),
('Dog Training', 'dog-training', 'Dog training guides and tips', 2),
('Breed Guides', 'breed-guides', 'Information about different pet breeds', 3),
('Pet Nutrition', 'pet-nutrition', 'Nutrition advice for pets', 4),
('Product Spotlights', 'product-spotlights', 'Featured products and reviews', 5);

-- Insert sample blog posts
INSERT INTO blog_posts (title, slug, excerpt, content, author_id, status, published_at) VALUES
('10 Tips for Better Pet Photography', '10-tips-pet-photography', 'Learn how to take amazing photos of your pets for custom products.', 'Taking great photos of your pets is essential for creating beautiful custom products. Here are our top 10 tips...', 5, 'published', '2025-01-15 10:00:00'),
('Choosing the Right Design Style for Your Pet', 'choosing-design-style', 'Discover which artistic style best captures your pet''s personality.', 'Every pet has a unique personality, and the right design style can capture that perfectly...', 5, 'published', '2025-01-20 14:30:00'),
('Memorial Products: Honoring Your Beloved Pet', 'memorial-products-guide', 'A guide to creating meaningful memorial products for your beloved pets.', 'Losing a pet is never easy. Our memorial products help you honor and remember your beloved companion...', 5, 'published', '2025-01-25 09:15:00');

-- Insert sample settings
INSERT INTO settings (setting_key, setting_value, setting_type, description) VALUES
('site_name', 'Petnic Studio', 'text', 'Website name'),
('site_description', 'Custom Pet Products & Personalized Pet Gifts', 'text', 'Website description'),
('contact_email', 'support@petnicstudio.com', 'text', 'Contact email address'),
('contact_phone', '1-800-PET-NICE', 'text', 'Contact phone number'),
('shipping_rate', '5.99', 'number', 'Standard shipping rate'),
('free_shipping_threshold', '50.00', 'number', 'Free shipping minimum order amount'),
('tax_rate', '8.25', 'number', 'Tax rate percentage'),
('currency', 'USD', 'text', 'Default currency'),
('processing_time', '2-3', 'text', 'Standard processing time in business days'),
('return_policy_days', '30', 'number', 'Return policy period in days');

