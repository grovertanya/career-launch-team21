from classes import Item

# functions.py

# Search items by category or name (optional parameters)
def search_items(items, category=None, name=None):
    results = items
    
    # Filter by category if provided
    if category:
        results = [item for item in results if item.category.strip().lower() == category.strip().lower()]
    
    # Filter by name if provided
    if name:
        results = [item for item in results if item.name.lower() == name.lower()]
    
    return results

# Search for user by username
def search_users(users, username):
    results = users
    
    # Filter by username given

    if not username:
        return []
    results = [user for user in results if user.username.strip().lower() == username.strip().lower()]

    return results

def search_item_by_id(items, item_id):
    if not item_id:
        return None  # Return None if no ID is provided
    
    # returns item object
    for item in items:
        if str(item.id) == str(item_id):  # Ensure both are compared as strings
            return item
    return None  # Return None if not found

def search_items_wishlist(items, User):
 
    # Assuming there is a User model and each user has a wishlist attribute (a list of item IDs)
    user = User # Fetch the user

    if not user or not hasattr(user, 'wishlist'):
        return None  # Return None if user doesn't exist or has no wishlist
    
    wishlist_item = user.wishlist  # Assuming wishlist is a list of item IDs
    
    # Filter items that match the wishlist item IDs
    wishlist_items = [item for item in items if item in wishlist_item]

    return wishlist_item
