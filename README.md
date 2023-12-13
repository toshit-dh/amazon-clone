# Amazon Clone
Welcome to the Amazon Clone project! This is a full-stack e-commerce application built using Flutter for the frontend, Node.js and Express for the backend, and MongoDB for data storage.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Admin Panel](#admin-panel)
- [Backend](#backend)
- [Contributing](#contributing)
- [License](#license)

## Features

1. **User Shopping:**
   - Browse and search for products.
   - Add products to the shopping cart.
   - View and edit the shopping cart.
   - Proceed to checkout and make a purchase.

2. **Rating Feature:**
   - Users can rate and review products.
   - Products display average ratings and reviews.

3. **Deal of the Day:**
   - Highlight a product with the highest rating as the deal of the day.
   - Special discounts on the deal of the day.

4. **Admin Panel:**
   - Manage products, categories, and deals.
   - Track and update delivery status.
   - View analytics and sales data.

## Installation

To set up the Amazon Clone project, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/amazon-clone.git
   cd amazon-clone
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Set up the Flutter app by navigating to the `flutter_app` directory and running:
   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   npm start
   ```

## Usage

1. Open the Flutter app on your device or emulator.
2. Browse products, add them to your cart, and make a purchase.
3. Rate and review products.
4. Manage orders and see analytics by changing user type to admin(make the changes in mongodb).
5. Before running the app make sure to change ip address in uri in globals.dart file in constants folder of lib folder.
6. Also change cloudinary details in admin-services.dart in sell-product functio.
7. In backend change the mongodb uri in index.js

## Admin Panel

Access the admin panel at `http://your-server/admin`:

1. **Product Management:**
   - Add, edit, or delete products.
   - Categorize products.

2. **Delivery Status:**
   - Track and update delivery status.

3. **Analytics:**
   - View sales data and analytics.

## Backend

The backend is built using Node.js and Express, with data stored in MongoDB. Modify the backend by editing files in the `backend` directory.
