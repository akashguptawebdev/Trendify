import 'package:trandify_app/Provider/add_to_cart_provider.dart';
import 'package:trandify_app/Provider/favorite_provider.dart';
import 'package:trandify_app/Provider/screen_Index.dart';
import 'package:trandify_app/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart'; // Import Get for navigation
import 'screens/nav_bar_screen.dart'; // Bottom navigation bar screen
import 'screens/top_Nav_Bar.dart'; // Top navigation bar screen
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider for adding to cart
        ChangeNotifierProvider(create: (_) => CartProvider()),

        // Provider for favorite items
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),

        // Provider for User Details items
        ChangeNotifierProvider(create: (_) => UserProvider()), // Register UserProvider
        // Screen Index Provider
        ChangeNotifierProvider(create: (_) => ScreenIndex()), 

      ],
      child: GetMaterialApp( // Use GetMaterialApp for navigation
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Using Google Fonts for consistent typography
          textTheme: GoogleFonts.mulishTextTheme(),
        ),
        // Responsive Layout as the home widget
        home: const ResponsiveLayout(),
      ),
    );
  }
}

// Responsive Layout Widget to handle layout for different screen sizes
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If screen width is greater than or equal to 600, use top navigation bar (for larger screens)
        if (constraints.maxWidth >= 600) {
          return const TopNavbar();
        } 
        // Otherwise, use bottom navigation bar (for mobile)
        else {
          return const BottomNavBar();
        }
      },
    );
  }
}
