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
