# Trendify - E-commerce  App

## Overview

**Trendify** is a  e-commerce application that offers a seamless shopping experience. Built with **Flutter** for the frontend and the **MEN stack** (MongoDB, Express, Node.js) for backend services, the app provides secure user authentication and session management through **JWT** (JSON Web Token). Users can browse products, manage their cart, and make purchases, all within an intuitive and responsive interface.

### Key Features

- **User Authentication**: Secure login and signup using JWT-based authentication.
- **Product Catalog**: Browse a wide variety of products across multiple categories.
- **Cart Management**: Add items to the cart, adjust quantities, and proceed to checkout.
- **Profile Management**: Update user information and manage addresses.
- **Responsive Design**: Optimized for mobile devices, providing a native app experience.
- **Image Upload**: Upload and manage product images seamlessly using **Cloudinary**.
- **Order History**: View past orders and their details.

## Live Demo

Explore the Trendify app live on [Vercel](#) (Frontend) and

 [Render] (#https://trendify-o7au.onrender.com) (Backend).

 - **BaseURL** 
 [Render] (#https://trendify-o7au.onrender.com)
  - you can change When you need to run backend on local system 
  - It will take 50 sec on first API Call 

## Technology Stack

### Frontend
- **Framework**: Flutter
- **State Management**: Provider
- **UI Design**: Material UI with custom assets (Google Fonts, VelocityX)
- **Local Storage**: SharedPreferences
- **Image Picker**: For selecting images for product uploads

### Backend
- **Framework**: Express.js
- **Database**: MongoDB (for product, user, and order management)
- **Authentication**: JWT (JSON Web Token) for secure session handling
- **Cloudinary**: For storing product images
- **Nodemailer**: For sending email notifications to users

## Installation

Follow these steps to set up Trendify locally:

### Frontend Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/akashguptawebdev/Trendify.git
   ```

2. **Navigate to the Flutter Project**

   ```bash
   cd Trendify
   ```

3. **Install Dependencies**

   ```bash
   flutter pub get
   ```

4. **Run the Flutter Application**

   ```bash
   flutter run
   ```

### Backend Setup

1. **Navigate to the Backend Directory**

   ```bash
   cd Trendify/backend
   ```

2. **Install Backend Dependencies**

   ```bash
   npm install
   ```

3. **Set up Environment Variables**

   Create a `.env` file in the root of the backend project and add the following variables:

   ```
   MONGO_URI=your_mongodb_connection_string
   JWT_SECRET=your_jwt_secret_key
   CLOUDINARY_URL=your_cloudinary_url
   ```

4. **Start the Backend Server**

   ```bash
   npm run dev
   ```

## Deployment

### Backend on Render

1. Push your backend code to a GitHub repository.
2. Create a Render account and connect it to your GitHub repository.
3. Set up environment variables (e.g., `MONGO_URI`, `JWT_SECRET`, `CLOUDINARY_URL`).
4. Deploy your backend on Render.


## File Structure

```
/lib
  ├── /components       # Reusable UI components for Flutter
  ├── /screens          # Flutter screens for different sections of the app
  ├── /models           # Data models for user, product, and order
  ├── /services         # API services for interacting with backend
  ├── /utils            # Utility functions and helper classes
/assets
  ├── images            # Product images and other static assets
```

## Usage

### User Authentication

- Register for a new account or log in using your existing credentials.
- Your session is managed securely using JWT, ensuring a seamless experience across the app.

### Shopping Experience

- Browse through various product categories.
- Add items to your cart and proceed to checkout.
- Manage your orders and view order history.

### Profile Management

- Update your profile information and address details for a better shopping experience.

## GitHub Repository

Check out the source code for Trendify on GitHub: [Trendify](https://github.com/akashguptawebdev/Trendify)
