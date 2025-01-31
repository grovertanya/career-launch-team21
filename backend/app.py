#app.py 

import os
from werkzeug.utils import secure_filename


from flask import Flask, jsonify, request
from functions import search_items
from functions import search_users
from functions import search_item_by_id
from classes import Item
from classes import User

# Sample data
users = [User("Alice","alice123","password", rating = 4.5), User("Bob","bob123","password", rating =  4.7)]
items = [
    Item("Mini Fridge", 50.0, "Appliances", seller=users[0]),
    Item("Desk Lamp", 20.0, "Furniture", seller=users[1]),
    Item("Textbook", 30.0, "Academic Supplies", seller=users[0])
]

app = Flask(__name__)

# GET METHODS

# get all items
@app.route('/items', methods=['GET'])
def get_items():
    items_list = [{"id": item.id, "name": item.name, "price": item.price, "category": item.category, "seller": item.seller.username, "description" : item.description, "imageurl": item.imageurl} for item in items]
    return jsonify(items_list)

# search for an item by category ( buttons )
@app.route('/items/searchCategory', methods=['GET'])
def searchCategory():
    category = request.args.get('category')
    filtered_items = search_items(items, category = category)
    
    result = [{"id": item.id, "name": item.name, "price": item.price, "category": item.category, "seller": item.seller.username, "description" : item.description, "imageurl": item.imageurl} for item in filtered_items]
    return jsonify(result)

# search for an item by name ( search bar )
@app.route('/items/searchName', methods=['GET'])
def searchName():
    name = request.args.get('name')
    filtered_items = search_items(items, name = name)
    
    result = [{"id": item.id, "name": item.name, "price": item.price, "category": item.category, "description" : item.description, "imageurl": item.imageurl} for item in filtered_items]
    return jsonify(result)

# get all users
@app.route('/users', methods=['GET'])
def get_users():
    users_list = [{"username": user.username, "rating": user.rating} for user in users]
    return jsonify(users_list)

# get all user by username
@app.route('/user', methods=['GET'])
def get_userUsername():
    username = request.args.get('username')
    found_user = search_users(users, username)

    if isinstance(found_user, dict):  # Check for error dictionary returned
        return jsonify(found_user), 404

    return jsonify([{"name": user.name,"username": user.username, "rating": user.rating, "rating count": user.ratingcount} for user in found_user]), 200

# POST METHODS

# add a user
@app.route('/users', methods = ['POST'])
def add_user():
    data = request.get_json()
    
    if 'name' not in data:
        return jsonify({"error": "Missing required field: 'name'"}), 400
    
    new_user = User(data['name'], data['username'], data['password'],rating=data.get('rating', 0.0))
    users.append(new_user)
    
    return jsonify({"message": "User added successfully", "name": new_user.name}), 201

# add item to wishlist
# Input: Username, Item ID / Item name
@app.route('/users/wishlist', methods=['POST'])
def add_to_wishlist():
    username = request.args.get('username')
    itemID = request.args.get('id')

     # Ensure inputs are provided
    if not itemID or not username:
        return jsonify({"error": "Missing 'itemID' or 'username'"}), 400

    item =  search_item_by_id(items, itemID)
    if not item:
         return jsonify({"error": "Item not found"}), 404
    
    user = search_users(users, username)
    if not user:
        return jsonify({"error": "User not found"}), 404
    
    user[0].add_to_wishlist(item)



# Checkout function : Mark item as sold 
# Input: Username, Item ID/ Name    
@app.route('/items/checkout', methods=['POST'])
def item_checkout():
    itemID = request.args.get('id')
    username = request.args.get('username')

    # Ensure inputs are provided
    if not itemID or not username:
        return jsonify({"error": "Missing 'itemID' or 'username'"}), 400

    item = search_item_by_id(items, itemID)
    if not item:
        return jsonify({"error": "Item not found"}), 404
    
    items.remove(item)

    return jsonify({"message": f"Item {item.name} marked as sold by {username}"}), 200


# remove from wishlist 
# Input: Item ID, username

# add an item
# recieves a JSON object with the item's name, price, category, and the seller's name
@app.route('/items', methods=['POST'])
def add_item():
    data = request.get_json()

    required_fields = ['name', 'price', 'category', 'seller_name', 'description','imageurl']
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"Missing field: {field}"}), 400

    # Find the seller by name
    seller = next((user for user in users if user.username == data['seller_name']), None)
    if not seller:
        return jsonify({"error": "Seller not found"}), 404

    new_item = Item(
        name=data['name'],
        price=float(data['price']),
        category=data['category'],
        seller=seller,
        description=data['description'],
        imageurl=data['imageurl']
    )

    items.append(new_item)

    return jsonify({
        "message": "Item added successfully",
        "item": {
            "id": new_item.id,
            "name": new_item.name,
            "price": new_item.price,
            "category": new_item.category,
            "seller": new_item.seller.username,
            "imageurl": new_item.imageurl
        }
    }), 201


# rate a user
# recieves a JSON object with the seller's name and the rating
# need : new rating , username of person rating, username of person being rated
@app.route('/users/rate', methods=['POST'])
def rate_user():
    data = request.get_json()

    if not data or 'seller_name' not in data or 'rating' not in data or 'username' not in data:
        return jsonify({"error": "Missing required fields: 'seller_name', 'rating', 'username'"}), 400

    seller_name = data.get('seller_name')
    rating = data.get('rating')
    username = data.get('username')

    try:
        rating = float(rating)
        if rating < 1 or rating > 5:
            return jsonify({"error": "Rating must be between 1 and 5"}), 400
    except ValueError:
        return jsonify({"error": "Invalid rating value"}), 400

    seller = search_users(users, seller_name)
    user = search_users(users, username)

    if not seller:
        return jsonify({"error": "Seller not found"}), 404
    if not user:
        return jsonify({"error": "User not found"}), 404

    seller = seller[0]
    user = user[0]

    # Update the seller's rating
    user.rate_another_user(seller, rating)

    return jsonify({
        "message": f"Rating updated successfully for {seller.name}",
        "new_rating": seller.rating
    }), 200

UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# sending the IMAGE URL
@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({"error": "No image file found"}), 400

    image = request.files['file']

    if image.filename == '':
        return jsonify({"error": "No selected file"}), 400

    filename = secure_filename(image.filename)
    file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    image.save(file_path)

    # Generate the URL (Modify based on your hosting setup)
    # ** change IP address
    file_url = f"http://10.174.129.101:5000/uploads/{filename}"

    return jsonify({"image_url": file_url}), 200

if __name__ == '__main__':
    app.run(host = '0.0.0.0', debug=True)
    #app.run(debug=True)


