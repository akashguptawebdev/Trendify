import 'package:ecommerce_mobile_app/Provider/user_provider.dart';
import 'package:ecommerce_mobile_app/models/product_model.dart';
import 'package:ecommerce_mobile_app/screens/Home/Widget/product_cart.dart';
import 'package:ecommerce_mobile_app/screens/Home/Widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import '../../models/category.dart';
import 'Widget/image_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0;
  int selectedIndex = 0;
  bool isLoading = true; // To track loading state
  Map<String, dynamic>? userProfile; // To store user profile data

  // Define a TextEditingController for the search bar
  final TextEditingController searchController = TextEditingController();
  List<Product> filteredProducts = [];

  // Define selectCategories as a class-level variable
  late List<List<Product>> selectCategories;

  @override
  void initState() {
    super.initState();
    fetchUser();
    searchController.addListener(_onSearch); // Listen to search input changes

    // Initialize selectCategories here
    selectCategories = [
      all,
      shoes,
      beauty,
      womenFashion,
      jewelry,
      menFashion,
    ];
  }

  @override
  void dispose() {
    searchController
        .dispose(); // Dispose of the controller when the screen is removed
    super.dispose();
  }

  Future<void> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =
        prefs.getString('jWT'); // Assume the token is saved after login
    print("local $token");
    if (token == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse(
        'http://localhost:2850/api/v1/user/getUserProfile'); // Your user profile endpoint
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Send JWT in Authorization header
        },
      );

      if (response.statusCode == 200) {
        final decodedUserProfile = json.decode(response.body);

        // Fetch the existing UserProvider
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        // Send user profile data to UserProvider
        userProvider.setUserData(decodedUserProfile);

        setState(() {
          userProfile = decodedUserProfile;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to fetch user profile: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user profile: $error');
    }
  }

  // Search logic
  void _onSearch() {
    String query = searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      setState(() {
        filteredProducts = all.where((product) {
          return product.title.toLowerCase().contains(query) ||
              product.description.toLowerCase().contains(query);
        }).toList();
      });
    } else {
      setState(() {
        // If search input is empty, show products based on selected category
        filteredProducts = selectCategories[selectedIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;
    bool isMedium = screenWidth >= 600 && screenWidth < 1000;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Updated Search bar with controller and onSearch
                    MySearchBAR(
                      searchController: searchController,
                      onSearch: _onSearch,
                    ),
                    const SizedBox(height: 20),
                    ImageSlider(
                      currentSlide: currentSlider,
                      onChange: (value) {
                        setState(() {
                          currentSlider = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    categoryItems(screenWidth),
                    const SizedBox(height: 20),
                    if (selectedIndex == 0)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Products",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    // Grid of products (filtered)
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile
                            ? 2
                            : isMedium
                                ? 4
                                : 6,
                        childAspectRatio: isMobile
                            ? 0.75
                            : isMedium
                                ? 0.6
                                : 0.7,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: filteredProducts.isNotEmpty
                          ? filteredProducts.length
                          : selectCategories[selectedIndex].length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: filteredProducts.isNotEmpty
                              ? filteredProducts[index]
                              : selectCategories[selectedIndex][index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Container categoryItems(double screenWidth) {
    bool isMobile = screenWidth < 600;
    bool isMedium = screenWidth >= 600 && screenWidth < 1000;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: isMobile ? 75 : 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(categoriesList.length, (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    // Update filtered products based on selected category
                    filteredProducts = selectCategories[selectedIndex];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: selectedIndex == index
                        ? Colors.blue[200]
                        : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: isMobile ? 23 : 65,
                        width: isMobile ? 23 : 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(categoriesList[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        categoriesList[index].title,
                        style: TextStyle(
                          fontSize: isMobile ? 8 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
