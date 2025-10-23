
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
