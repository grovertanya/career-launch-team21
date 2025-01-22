#app.py 

from flask import Flask, jsonify, request
from classes import User, Item
from functions import search_items

app = Flask(__name__)

# Sample data
users = [User("Alice", 4.5), User("Bob", 4.7)]
items = [
    Item("Mini Fridge", 50.0, "Appliances", seller=users[0]),
    Item("Desk Lamp", 20.0, "Furniture", seller=users[1]),
    Item("Textbook", 30.0, "Academic Supplies", seller=users[0])
]

# GET METHODS

# get all items
@app.route('/items', methods=['GET'])
def get_items():
    items_list = [{"name": item.name, "price": item.price, "category": item.category, "seller": item.seller.name} for item in items]
    return jsonify(items_list)

# search for an item by category ( buttons )
@app.route('/items/searchCategory', methods=['GET'])
def searchCategory():
    category = request.args.get('category')
    filtered_items = search_items(items, category = category)
    
    result = [{"name": item.name, "price": item.price, "category": item.category} for item in filtered_items]
    return jsonify(result)

# search for an item by name ( search bar )
@app.route('/items/searchName', methods=['GET'])
def searchName():
    name = request.args.get('name')
    filtered_items = search_items(items, name = name)
    
    result = [{"name": item.name, "price": item.price, "category": item.category} for item in filtered_items]
    return jsonify(result)

# get all users
@app.route('/users', methods=['GET'])
def get_users():
    users_list = [{"name": user.name, "rating": user.rating} for user in users]
    return jsonify(users_list)

# POST METHODS

# add a user
@app.route('/users', methods = ['POST'])
def add_user():
    data = request.get_json()
    
    if 'name' not in data:
        return jsonify({"error": "Missing required field: 'name'"}), 400
    
    new_user = User(data['name'], rating=data.get('rating', 0.0))
    users.append(new_user)
    
    return jsonify({"message": "User added successfully", "name": new_user.name}), 201

# add an item
# recieves a JSON object with the item's name, price, category, and the seller's name
@app.route('/items', methods=['POST'])
def add_item():
    data = request.get_json()

    required_fields = ['name', 'price', 'category', 'seller_name']
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"Missing field: {field}"}), 400

    # Find the seller by name
    seller = next((user for user in users if user.name == data['seller_name']), None)
    if not seller:
        return jsonify({"error": "Seller not found"}), 404

    new_item = Item(
        name=data['name'],
        price=float(data['price']),
        category=data['category'],
        seller=seller
    )

    items.append(new_item)

    return jsonify({
        "message": "Item added successfully",
        "item": {
            "name": new_item.name,
            "price": new_item.price,
            "category": new_item.category,
            "seller": new_item.seller.name
        }
    }), 201


# rate a user
# recieves a JSON object with the seller's name and the rating
@app.route('/users/rate', methods=['POST'])
def rate_user():

    data = request.get_json()

    if 'seller_name' not in data or 'rating' not in data:
        return jsonify({"error": "Missing required fields: 'seller_name', 'rating'"}), 400

    seller = next((user for user in users if user.name == data['seller_name']), None)
    if not seller:
        return jsonify({"error": "Seller not found"}), 404

    # Update the rating (simple averaging approach)
    seller.rating = (seller.rating + float(data['rating'])) / 2

    return jsonify({
        "message": f"Rating updated successfully for {seller.name}",
        "new_rating": seller.rating
    }), 200



if __name__ == '__main__':
    app.run(host = '192.168.1.164', debug=True)

