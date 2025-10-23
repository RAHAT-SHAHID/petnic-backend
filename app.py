from flask import Flask, jsonify, request
import sqlite3
from datetime import datetime
import uuid

app = Flask(__name__)
DATABASE = 'petnic_studio.db'


# 🧠 Database connection helper
def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn


# ✅ Get all active products
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


# ✅ Get single product by ID
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


# ✅ Add item to cart
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


# ✅ Create an order
@app.route('/api/orders', methods=['POST'])
def create_order():
    data = request.json
    conn = get_db_connection()
    order_number = f"ORD-{datetime.now().strftime('%Y%m%d')}-{str(uuid.uuid4())[:8].upper()}"
    cursor = conn.execute('''
        INSERT INTO orders (order_number, user_id, total_amount, subtotal, status)
        VALUES (?, ?, ?, ?, 'pending')
    ''', (order_number, data['user_id'], data['total'], data['subtotal']))
    order_id = cursor.lastrowid
    for item in data['items']:
        conn.execute('''
            INSERT INTO order_items (order_id, product_id, product_name, quantity, unit_price, total_price)
            VALUES (?, ?, ?, ?, ?, ?)
        ''', (order_id, item['product_id'], item['name'], item['quantity'],
              item['price'], item['total']))
    conn.commit()
    conn.close()
    return jsonify({'order_number': order_number, 'order_id': order_id})


# 🟢 Run Server
if __name__ == '__main__':
    app.run(debug=True)
