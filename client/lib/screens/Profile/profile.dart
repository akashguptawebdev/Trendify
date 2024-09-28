import 'package:ecommerce_mobile_app/Provider/screen_Index.dart';
import 'package:ecommerce_mobile_app/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenIndexProvider = Provider.of<ScreenIndex>(context, listen: false); // Access ScreenIndex provider
    final userProvider = Provider.of<UserProvider>(context);
    var userP = userProvider.userData;

    Size size = MediaQuery.of(context).size;

    // Clear local storage and navigate to HomeScreen
    Future<void> clearLocalStorage() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clears all local data
      print("Local storage cleared");

      // Reset user data in UserProvider
      userProvider.resetUserData(); // Make sure to implement this method in UserProvider

      // Navigate back to login or home by updating screen index
      screenIndexProvider.setIndex(2);
    }

    // If user is not logged in, redirect to login or appropriate screen
    if (userP.isEmpty) {
      // You can redirect to the login page here if the user data is empty
      screenIndexProvider.setIndex(2);
      return Container(); // Return an empty container while navigating
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Profile Background Image
          Container(
            height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(userP['profileURL']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main Content in Scrollable View
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.25),
              child: Align(
                alignment: Alignment.topCenter,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Profile Picture
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(userP['profileURL']),
                        ),
                        const SizedBox(height: 10),
                        // User Name
                        Text(
                          userP['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // User Email
                        Text(
                          userP['email'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // User Contact Number
                        Text(
                          userP['contact_number'] ?? 'No phone number provided',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Other Details
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text('Gender: ${userP['gender']}'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.verified_user),
                          title: Text('Role: ${userP['role']}'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: Text('Joined: ${userP['createdAt']}'),
                        ),
                        ListTile(
                          onTap: clearLocalStorage, // Call clearLocalStorage on logout
                          leading: const Icon(Icons.logout),
                          title: const Text('LOG-OUT'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
