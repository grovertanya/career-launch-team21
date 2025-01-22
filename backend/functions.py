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


