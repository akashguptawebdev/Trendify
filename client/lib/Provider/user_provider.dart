import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  Map<String, dynamic> _userData = {};
  Map<String, dynamic> _cartData = {};

  // Getters for user and cart information
  Map<String, dynamic> get userData => _userData;
  Map<String, dynamic> get cartData => _cartData;

  // Method to set user details after login
  void setUserData(Map<String, dynamic> userData) {
    _userData = {
      '_id': userData['_id'] ?? '',
      'name': userData['name'] ?? '',
      'email': userData['email'] ?? '',
      'role': userData['role'] ?? '',
      'contact_number': userData['contact_number'] ?? '',
      'gender': userData['gender'] ?? '',
      'orders': userData['orders'] ?? [],
      'address': userData['address'] ?? [],
      'tokens': userData['tokens'] ?? [],
      'createdAt': userData['createdAt'] ?? '',
      'updatedAt': userData['updatedAt'] ?? '',
      'profileURL': userData['profilePhoto'] != null ? userData['profilePhoto']['url'] ?? '' : '',
    };

    // Storing cart data
    _cartData = {
      '_id': userData['cart']['_id'] ?? '',
      'user': userData['cart']['user'] ?? '',
      'items': userData['cart']['items'] ?? [],
      'totalItems': userData['cart']['totalItems'] ?? 0,
      'totalPrice': userData['cart']['totalPrice'] ?? 0.0,
      'isActive': userData['cart']['isActive'] ?? true,
      'createdAt': userData['cart']['createdAt'] ?? '',
      'updatedAt': userData['cart']['updatedAt'] ?? '',
    };

    notifyListeners(); // Notify UI of the changes
  }

  // Method to clear user data (e.g., after logout)
  void clearUserData() {
    _userData.clear();
    _cartData.clear();
    notifyListeners(); // Notify UI of the changes
  }

   void resetUserData() {
    _userData = {}; // Reset the user data
    notifyListeners(); // Notify listeners to update UI
  }
}
