from flask import Flask, request, jsonify
from flask_pymongo import PyMongo
from bson.objectid import ObjectId

app = Flask(__name__)

# Configure MongoDB
app.config["MONGO_URI"] = "mongodb://localhost:27017/products"
mongo = PyMongo(app)

# Reference to the MongoDB collection
product_collection = mongo.db.product

# Helper function to format MongoDB documents
def format_product(product):
    return {
        "id": str(product["_id"]),
        "product_id": str(product["product_id"]),
        "product_name": product["product_name"],
        "category": product["category"],
        "cost": product["cost"],
        "on_hand": product["on_hand"],
    }

# Create a new product
@app.route("/add-product", methods=["POST"])
def create_product():
    data = request.json
    product = {
        "product_id": data["product_id"],
        "product_name": data["product_name"],
        "category": data["category"],
        "cost": data["cost"],
        "on_hand": data["on_hand"],
    }
    result = product_collection.insert_one(product)
    return jsonify({"message": "Product created", "product_id": str(result.inserted_id)}), 201

# Read all products
@app.route("/products", methods=["GET"])
def get_products():
    products = product_collection.find()
    return jsonify([format_product(product) for product in products]), 200

# Read a single product by ID
@app.route("/products/<product_id>", methods=["GET"])
def get_product(product_id):
    product = product_collection.find_one({"product_id": int(product_id)})
    if product:
        return jsonify(format_product(product)), 200
    else:
        return jsonify({"error": "Product not found"}), 404

# Update a product by ID
@app.route("/update-product/<product_id>", methods=["PUT"])
def update_product(product_id):
    data = request.json
    update_data = {
        "product_name": data.get("product_name"),
        "category": data.get("category"),
        "cost": data.get("cost"),
        "on_hand": data.get("on_hand"),
    }
    result = product_collection.update_one(
        {"product_id": int(product_id)}, {"$set": update_data}
    )
    if result.matched_count > 0:
        return jsonify({"message": "Product updated"}), 200
    else:
        return jsonify({"error": "Product not found"}), 404

# Delete a product by ID
@app.route("/delete-product/<product_id>", methods=["DELETE"])
def delete_product(product_id):
    # First, check if the product exists
    product = product_collection.find_one({"product_id": product_id})
    if not product:
        return jsonify({"error": f"Product with ID {product_id} not found"}), 404
    
    # If the product exists, attempt to delete it
    result = product_collection.delete_one({"product_id": product_id})
    if result.deleted_count > 0:
        return jsonify({"message": f"Product with ID {product_id} deleted successfully"}), 200
    else:
        return jsonify({"error": f"Failed to delete product with ID {product_id}"}), 500

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=4000)