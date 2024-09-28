import 'package:trandify_app/Provider/screen_Index.dart';
import 'package:trandify_app/Provider/user_provider.dart';
import 'package:trandify_app/constants.dart';
import 'package:trandify_app/screens/Cart/cart_screen.dart';
import 'package:trandify_app/screens/Home/home_screen.dart';
import 'package:trandify_app/screens/Profile/profile.dart';
import 'package:trandify_app/screens/auth_Screen/login_Screen.dart';
import 'package:trandify_app/screens/auth_Screen/signup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/add_to_cart_provider.dart';
import 'Favorite/favorite.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Access UserProvider and ScreenIndex provider
    final userProvider = Provider.of<UserProvider>(context);
    final screenIndexProvider = ScreenIndex.of(context);
    final cartProvider = CartProvider.of(context);

    // Get user data and check if the user is logged in
    final userP = userProvider.userData;
    bool isUserLoggedIn = userP.isNotEmpty; // Check if user data exists and is not empty

    // List of screens, where profile is conditional based on login state
    List<Widget> screens = [
      const Scaffold(), // Placeholder for grid view
      const Favorite(), // Favorites screen
      const HomeScreen(), // Home screen
      const CartScreen(), // Cart screen
      isUserLoggedIn ? const Profile() : const LoginScreen(), // Show profile or login screen
       const SignupScreen(),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          screenIndexProvider.setIndex(2); // Navigate to home screen
        },
        shape: const CircleBorder(),
        backgroundColor: kprimaryColor,
        child: const Icon(
          Icons.home,
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                screenIndexProvider.setIndex(0); // Navigate to grid view
              },
              icon: Icon(
                Icons.grid_view_outlined,
                size: 30,
                color: screenIndexProvider.screenIndex == 0
                    ? kprimaryColor
                    : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                screenIndexProvider.setIndex(1); // Navigate to favorites
              },
              icon: Icon(
                Icons.favorite_border,
                size: 30,
                color: screenIndexProvider.screenIndex == 1
                    ? kprimaryColor
                    : Colors.grey.shade400,
              ),
            ),
            const SizedBox(width: 15), // Spacing for floating button
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    screenIndexProvider.setIndex(3); // Navigate to cart
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                    color: screenIndexProvider.screenIndex == 3
                        ? kprimaryColor
                        : Colors.grey.shade400,
                  ),
                ),
                // Badge for cart items count
                if (cartProvider.cartItemCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Text(
                        '${cartProvider.cartItemCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              onPressed: () {
                if (isUserLoggedIn) {
                  screenIndexProvider.setIndex(4); // Navigate to profile
                } else {
                  screenIndexProvider.setIndex(4); // Navigate to login
                }
              },
              icon: Icon(
                Icons.person,
                size: 30,
                color: screenIndexProvider.screenIndex == 4
                    ? kprimaryColor
                    : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      // Set the body to the current screen based on index
      body: screens[screenIndexProvider.screenIndex],
    );
  }
}
