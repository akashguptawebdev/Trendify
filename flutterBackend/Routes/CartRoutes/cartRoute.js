import express from "express";
import {
  addItemToCart,
  removeItemFromCart,
  updateItemQuantity,
  getCart,
  clearCart
} from "../../Controllers/cartController.js"; // Importing the cart controller functions
import { isAuthenticated } from "../../MiddleWare/isAuthenticated.js";

const cartRoute = express.Router();

// Route to get the user's cart
cartRoute.get('/', isAuthenticated, getCart);

// Route to add an item to the cart
cartRoute.post('/add', isAuthenticated, addItemToCart);

// Route to remove an item from the cart
cartRoute.delete('/remove', isAuthenticated, removeItemFromCart);

// Route to update the quantity of an item in the cart
cartRoute.put('/update', isAuthenticated, updateItemQuantity);

// Route to clear the cart
cartRoute.delete('/clear', isAuthenticated, clearCart);

export default cartRoute;
