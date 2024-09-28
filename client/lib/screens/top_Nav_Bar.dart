import 'package:ecommerce_mobile_app/Provider/screen_Index.dart';
import 'package:ecommerce_mobile_app/Provider/user_provider.dart';
import 'package:ecommerce_mobile_app/constants.dart';
import 'package:ecommerce_mobile_app/screens/Cart/cart_screen.dart';
import 'package:ecommerce_mobile_app/screens/Home/home_screen.dart';
import 'package:ecommerce_mobile_app/screens/Profile/profile.dart';
import 'package:ecommerce_mobile_app/screens/auth_Screen/login_Screen.dart';
import 'package:ecommerce_mobile_app/screens/auth_Screen/signup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Favorite/favorite.dart';
import '../Provider/add_to_cart_provider.dart';

class TopNavbar extends StatelessWidget {
  const TopNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final screenIndexProvider =
        ScreenIndex.of(context); // Access the ScreenIndex provider
    final cartProvider = CartProvider.of(context); // Access CartProvider

    // Get the user data from UserProvider
    final userP = userProvider.userData;
    bool isUser = userP.isNotEmpty;

    // Define the screens to display
    List<Widget> screens = [
      const Scaffold(), // Placeholder for E-Comm button (which will navigate to Home)
      const Favorite(),
      const HomeScreen(), // Home screen at index 2
      const CartScreen(),
      isUser ? const Profile() : const LoginScreen(),
      const SignupScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60), // Adjust height as needed
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 16.0), // Set horizontal margins
            child: BottomNavigationBar(
              currentIndex: screenIndexProvider
                  .screenIndex, // Use screenIndex from provider
              onTap: (index) {
                // Update the screen index when a tab is tapped
                screenIndexProvider.setIndex(
                    index == 0 ? 2 : index); // Set index, go to home if index 0
              },
              items: [ 
                // E-Comm button which navigates to HomeScreen
                const BottomNavigationBarItem(
                  icon: Center(
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.home), // Icon for E-Comm button
                          Text(
                            "Trendify", // Label for E-Comm button
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight:
                                    FontWeight.bold), // Adjust font size
                          ),
                        ],
                      ),
                    ),
                  ),
                  label: '', // Avoid label if using custom text
                ),
                BottomNavigationBarItem(
                  icon: Center(
                    child: Icon(
                      Icons.favorite,
                      color: screenIndexProvider.screenIndex == 1
                          ? kprimaryColor
                          : Colors.grey.shade400,
                    ),
                  ),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: screenIndexProvider.screenIndex == 2
                        ? kprimaryColor
                        : Colors.grey.shade400,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: screenIndexProvider.screenIndex == 3
                            ? kprimaryColor
                            : Colors.grey.shade400,
                      ),
                      if (cartProvider.cartItemCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cartProvider.cartItemCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: screenIndexProvider.screenIndex == 4
                        ? kprimaryColor
                        : Colors.grey.shade400,
                  ),
                  label: 'Profile',
                ),

                const BottomNavigationBarItem(
                  icon: SizedBox.shrink(), // To keep the icon empty
                  label: '', // To keep the label empty
                ),
              ],
            ),
          ),
        ),
      ),
      body: screens[
          screenIndexProvider.screenIndex], // Display the selected screen
    );
  }
}
