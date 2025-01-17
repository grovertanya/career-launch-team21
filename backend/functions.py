# functions.py

# Displaying items based on category and price range
def search_items(items, category=None, min_price=None, max_price=None):
    results = items
    if category:
        results = [item for item in results if item.category.lower() == category.lower()]
    if min_price is not None:
        results = [item for item in results if item.price >= min_price]
    if max_price is not None:
        results = [item for item in results if item.price <= max_price]
    return results
