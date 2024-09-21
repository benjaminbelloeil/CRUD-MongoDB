# CRUD MongoDB App with Flask & Swift

This project is a basic CRUD (Create, Read, Update, Delete) application that integrates a Flask backend with a SwiftUI frontend. The project demonstrates the interaction between a MongoDB database and an iOS application for managing products using Flask.

## Project Overview

The project consists of three main parts:
1. **Flask Backend**: Provides API endpoints to interact with the MongoDB database for product management.
2. **MongoDB**: The database stores product data such as product ID, name, category, cost, and stock availability.
3. **SwiftUI iOS Frontend**: A user-friendly interface to add, view, edit, and delete products.

### Technologies Used:
- **Flask**: For building the API.
- **PyMongo**: To interact with the MongoDB database in Flask.
- **MongoDB**: For storing product data.
- **SwiftUI**: For the iOS app interface.

---

## Screenshots

### Flask Backend
This shows the `app.py` file that contains the routes and logic for interacting with MongoDB.

<img width="1470" alt="Screenshot 2024-09-21 at 2 03 52 PM" src="https://github.com/user-attachments/assets/dc48560e-14aa-4f8d-9dd9-9e82cd278792">

### MongoDB Compass View
This shows the MongoDB Compass view with the product entries in the database.

<img width="1470" alt="Screenshot 2024-09-21 at 2 03 39 PM" src="https://github.com/user-attachments/assets/cc58879f-9edc-41ca-a6f9-b235d4132766">

### Add Product Screen
This is the iOS app screen where users can add new products to the MongoDB database.

<img width="497" alt="Screenshot 2024-09-21 at 2 06 48 PM" src="https://github.com/user-attachments/assets/d97a7893-4a42-4110-b0d5-c1366a02c1e7">

### Product List View (iOS App)
This screen displays a list of products stored in the database. Each product card has a delete button (red trash icon).

<img width="497" alt="Screenshot 2024-09-21 at 2 06 34 PM" src="https://github.com/user-attachments/assets/c472fc3a-f1aa-40db-88c3-2050ece0ed6a">


## Setup Instructions

### Backend (Flask + MongoDB)

1. **Clone the repository** and navigate to the backend folder.
2. Install the required Python packages:
   ```bash
   pip install Flask pymongo
   ```
3. Ensure you have MongoDB installed locally or connect to a MongoDB Atlas instance. Modify the connection string in the `app.py` file:
   ```python
   app.config["MONGO_URI"] = "mongodb://localhost:27017/products"
   ```
4. Start the Flask server:
   ```bash
   python app.py
   ```

### MongoDB

1. Ensure MongoDB is running on your local machine or cloud.
2. Use MongoDB Compass to view the product entries. If the `products` collection doesn't exist, it will be created when you add your first product.

### Frontend (iOS App)

1. Open the Xcode project (`CRUD-MongoDB.xcodeproj`).
2. Make sure your iOS simulator or device is connected.
3. Run the app from Xcode.

---

## API Endpoints

- `GET /products`: Fetch all products.
- `POST /add-product`: Add a new product.
- `DELETE /delete-product/<id>`: Delete a product by ID.
- `PUT /update-product/<id>`: Update an existing product by ID.

---

## Contributions

Feel free to fork this repository, open issues, and create pull requests for new features, bug fixes, or improvements.
