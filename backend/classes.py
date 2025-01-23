import uuid
from data import items

#classes.py

# List of valid categories

categories = ["Academic Supplies","Appliances", "Clothing", "Electronics", "Furniture", "Dorm Essentials", "Tickets","Other"]

# The user class keeps track of each individual user: Name, Rating, Number of Ratings, Items Listed, Wishlist
class User:
    def __init__(self, name, username, password, rating =0.0):
        self.name = name
        self.username = username
        self.password = password
        self.items_listed = []
        self.wishlist = []
        self.rating = rating 
        self.ratingcount = 0

    # List an Item
    def list_item(self, item):
        self.items_listed.append(item)
    
    # Add to Wishlist
    def add_to_wishlist(self, item):
        self.wishlist.append(item)

    # Rate another user
    def rate_another_user(self, other_user, rating):

        if not (1.0 <= rating <= 5.0):
            raise ValueError("Rating must be between 1.0 and 5.0")
           
        # Change the other user's rating
        new_rating_total = (other_user.rating * other_user.ratingcount + rating )
        other_user.ratingcount+=1 
        other_user.rating = new_rating_total/other_user.ratingcount
    

    def __str__(self):
        return f"User: {self.name}, Rating: {self.rating}, Listed Items: {len(self.items_listed)}"
    
# The item class keeps track of each individual item: Name, Description, Price, Category, Seller, Sold Status
class Item:

     # Class-level set to track unique IDs
    used_ids = set()

    def __init__(self, name, price, category, imageurl = "https:/url" , sold = False, seller = None):
        if category not in categories:
            raise ValueError(f"Invalid category: '{category}'. Valid categories are: {', '.join(categories)}")
        self.name = name  
        #self.description = description
        self.id = self.generate_unique_id()
        self.sold = False
        self.imageurl = imageurl
        self.price = price  
        self.category = category 
        self.seller = seller
        
    def generate_unique_id(self):
        new_id = str(uuid.uuid4())
        while new_id in Item.used_ids:
            new_id = str(uuid.uuid4())  # Regenerate until unique
        Item.used_ids.add(new_id)
        return new_id
    
    def mark_as_sold(self):
        self.sold = True

    def __str__(self):
        status = "Sold" if self.sold else "Available"
        return f"Item: {self.name}, Price: ${self.price}, Category: {self.category}, Status: {status}, Seller: {self.seller}"
