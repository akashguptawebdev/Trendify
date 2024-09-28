import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenIndex extends ChangeNotifier {
  int _screenIndex = 2; // Default screen index (change this as needed)

  // Define the maximum number of screens, update based on your app's navigation structure
  final int _maxIndex = 6; // Example: if you have 5 screens, set max index to 4

  // Getter for the screen index
  int get screenIndex => _screenIndex;

  // Method to set the screen index dynamically
  void setIndex(int index) {
    if (index >= 0 && index <= _maxIndex) { // Ensure the index is within valid bounds
      _screenIndex = index;
      notifyListeners();
    } else {
      print('Index $index is out of bounds. Must be between 0 and $_maxIndex.');
    }
  }

  // // Example method to check if a product is in favorites
  // bool isExist(Product product, List<Product> favorites) {
  //   return favorites.contains(product);
  // }

  // Static method to access the ScreenIndex provider
  static ScreenIndex of(BuildContext context, {bool listen = true}) {
    return Provider.of<ScreenIndex>(context, listen: listen);
  }
}
