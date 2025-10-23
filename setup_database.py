#!/usr/bin/env python3
"""
Petnic Studio Database Setup Script
This script creates and initializes the SQLite database for Petnic Studio
"""

import sqlite3
import os
import sys
from datetime import datetime

def create_database(db_path='petnic_studio.db'):
    """
    Create the Petnic Studio database with schema and sample data
    """
    try:
        # Remove existing database if it exists
        if os.path.exists(db_path):
            print(f"Removing existing database: {db_path}")
            os.remove(db_path)
        
        # Create new database connection
        print(f"Creating new database: {db_path}")
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        
        # Enable foreign key constraints
        cursor.execute("PRAGMA foreign_keys = ON")
        
        # Read and execute schema
        print("Creating database schema...")
        with open('petnic_database_schema.sql', 'r') as schema_file:
            schema_sql = schema_file.read()
            cursor.executescript(schema_sql)
        
        # Read and execute sample data
        print("Inserting sample data...")
        with open('petnic_sample_data.sql', 'r') as data_file:
            data_sql = data_file.read()
            cursor.executescript(data_sql)
        
        # Commit changes
        conn.commit()
        
        # Verify database creation
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
        tables = cursor.fetchall()
        print(f"Database created successfully with {len(tables)} tables:")
        for table in tables:
            print(f"  - {table[0]}")
        
        # Display some sample data
        print("\nSample data verification:")
        
        # Count users
        cursor.execute("SELECT COUNT(*) FROM users")
        user_count = cursor.fetchone()[0]
        print(f"  - Users: {user_count}")
        
        # Count products
        cursor.execute("SELECT COUNT(*) FROM products")
        product_count = cursor.fetchone()[0]
        print(f"  - Products: {product_count}")
        
        # Count orders
        cursor.execute("SELECT COUNT(*) FROM orders")
        order_count = cursor.fetchone()[0]
        print(f"  - Orders: {order_count}")
        
        # Count categories
        cursor.execute("SELECT COUNT(*) FROM categories")
        category_count = cursor.fetchone()[0]
        print(f"  - Categories: {category_count}")
        
        conn.close()
        print(f"\nDatabase setup completed successfully!")
        print(f"Database file: {os.path.abspath(db_path)}")
        
        return True
        
    except Exception as e:
        print(f"Error creating database: {str(e)}")
        return False

def test_database_queries(db_path='petnic_studio.db'):
    """
    Test some common database queries
    """
    try:
        print("\nTesting database queries...")
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        
        # Test 1: Get all categories
        print("\n1. Categories:")
        cursor.execute("SELECT name, slug FROM categories ORDER BY sort_order")
        categories = cursor.fetchall()
        for cat in categories[:5]:  # Show first 5
            print(f"   - {cat[0]} ({cat[1]})")
        if len(categories) > 5:
            print(f"   ... and {len(categories) - 5} more")
        
        # Test 2: Get featured products
        print("\n2. Featured Products:")
        cursor.execute("""
            SELECT p.name, p.price, c.name as category 
            FROM products p 
            LEFT JOIN categories c ON p.category_id = c.id 
            WHERE p.featured = 1
        """)
        featured = cursor.fetchall()
        for product in featured:
            print(f"   - {product[0]} (${product[1]}) - {product[2]}")
        
        # Test 3: Get recent orders
        print("\n3. Recent Orders:")
        cursor.execute("""
            SELECT o.order_number, u.first_name, u.last_name, o.total_amount, o.status
            FROM orders o
            LEFT JOIN users u ON o.user_id = u.id
            ORDER BY o.created_at DESC
            LIMIT 3
        """)
        orders = cursor.fetchall()
        for order in orders:
            customer = f"{order[1]} {order[2]}" if order[1] else "Guest"
            print(f"   - {order[0]}: {customer} - ${order[3]} ({order[4]})")
        
        # Test 4: Get design styles
        print("\n4. Design Styles:")
        cursor.execute("SELECT name, price_modifier FROM design_styles ORDER BY sort_order")
        styles = cursor.fetchall()
        for style in styles:
            modifier = f"+${style[1]}" if style[1] > 0 else "Free"
            print(f"   - {style[0]} ({modifier})")
        
        conn.close()
        print("\nDatabase queries completed successfully!")
        
    except Exception as e:
        print(f"Error testing database: {str(e)}")

def create_api_examples():
    """
    Create example API endpoints documentation
    """
    api_examples = """
# Petnic Studio API Examples

## Database Connection (Python/Flask)
```python
import sqlite3
from flask import Flask, jsonify, request

app = Flask(__name__)
DATABASE = 'petnic_studio.db'

def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

# Get all products
@app.route('/api/products')
def get_products():
    conn = get_db_connection()
    products = conn.execute('''
        SELECT p.*, c.name as category_name 
        FROM products p 
        LEFT JOIN categories c ON p.category_id = c.id 
        WHERE p.status = 'active'
        ORDER BY p.created_at DESC
    ''').fetchall()
    conn.close()
    return jsonify([dict(product) for product in products])

# Get product by ID
@app.route('/api/products/<int:product_id>')
def get_product(product_id):
    conn = get_db_connection()
    product = conn.execute('''
        SELECT p.*, c.name as category_name 
        FROM products p 
        LEFT JOIN categories c ON p.category_id = c.id 
        WHERE p.id = ?
    ''', (product_id,)).fetchone()
    conn.close()
    if product:
        return jsonify(dict(product))
    return jsonify({'error': 'Product not found'}), 404

# Add to cart
@app.route('/api/cart', methods=['POST'])
def add_to_cart():
    data = request.json
    conn = get_db_connection()
    conn.execute('''
        INSERT INTO cart_items (user_id, product_id, quantity, custom_text, design_style_id)
        VALUES (?, ?, ?, ?, ?)
    ''', (data['user_id'], data['product_id'], data['quantity'], 
          data.get('custom_text'), data.get('design_style_id')))
    conn.commit()
    conn.close()
    return jsonify({'success': True})

# Create order
@app.route('/api/orders', methods=['POST'])
def create_order():
    data = request.json
    conn = get_db_connection()
    
    # Generate order number
    import uuid
    order_number = f"ORD-{datetime.now().strftime('%Y%m%d')}-{str(uuid.uuid4())[:8].upper()}"
    
    # Insert order
    cursor = conn.execute('''
        INSERT INTO orders (order_number, user_id, total_amount, subtotal, status)
        VALUES (?, ?, ?, ?, 'pending')
    ''', (order_number, data['user_id'], data['total'], data['subtotal']))
    
    order_id = cursor.lastrowid
    
    # Insert order items
    for item in data['items']:
        conn.execute('''
            INSERT INTO order_items (order_id, product_id, product_name, quantity, unit_price, total_price)
            VALUES (?, ?, ?, ?, ?, ?)
        ''', (order_id, item['product_id'], item['name'], item['quantity'], 
              item['price'], item['total']))
    
    conn.commit()
    conn.close()
    return jsonify({'order_number': order_number, 'order_id': order_id})
```

## Common SQL Queries

### Get products by category
```sql
SELECT p.*, c.name as category_name 
FROM products p 
JOIN categories c ON p.category_id = c.id 
WHERE c.slug = 't-shirts' AND p.status = 'active';
```

### Get user's order history
```sql
SELECT o.order_number, o.total_amount, o.status, o.created_at,
       COUNT(oi.id) as item_count
FROM orders o
LEFT JOIN order_items oi ON o.id = oi.order_id
WHERE o.user_id = 1
GROUP BY o.id
ORDER BY o.created_at DESC;
```

### Get product reviews with user info
```sql
SELECT pr.rating, pr.title, pr.review_text, pr.created_at,
       u.first_name, u.last_name
FROM product_reviews pr
JOIN users u ON pr.user_id = u.id
WHERE pr.product_id = 1 AND pr.is_approved = 1
ORDER BY pr.created_at DESC;
```

### Get cart items for user
```sql
SELECT ci.*, p.name, p.price, ds.name as design_style
FROM cart_items ci
JOIN products p ON ci.product_id = p.id
LEFT JOIN design_styles ds ON ci.design_style_id = ds.id
WHERE ci.user_id = 1;
```

### Get affiliate earnings
```sql
SELECT a.affiliate_code, a.total_earnings, a.total_referrals,
       SUM(ar.commission_amount) as pending_commission
FROM affiliates a
LEFT JOIN affiliate_referrals ar ON a.id = ar.affiliate_id AND ar.status = 'pending'
WHERE a.user_id = 3
GROUP BY a.id;
```
"""
    
    with open('api_examples.md', 'w') as f:
        f.write(api_examples)
    print("API examples created: api_examples.md")

if __name__ == "__main__":
    print("Petnic Studio Database Setup")
    print("=" * 40)
    
    # Check if schema files exist
    if not os.path.exists('petnic_database_schema.sql'):
        print("Error: petnic_database_schema.sql not found!")
        sys.exit(1)
    
    if not os.path.exists('petnic_sample_data.sql'):
        print("Error: petnic_sample_data.sql not found!")
        sys.exit(1)
    
    # Create database
    success = create_database()
    
    if success:
        # Test database
        test_database_queries()
        
        # Create API examples
        create_api_examples()
        
        print("\n" + "=" * 40)
        print("Setup completed successfully!")
        print("\nNext steps:")
        print("1. Use 'petnic_studio.db' as your database file")
        print("2. Check 'api_examples.md' for integration examples")
        print("3. Customize the schema as needed for your application")
    else:
        print("Setup failed!")
        sys.exit(1)
