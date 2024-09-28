import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data'; // For handling byte data
import 'dart:convert'; // For better error handling
import "package:ecommerce_mobile_app/Constant/BaseURL.dart";
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;

  // Controllers to capture input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reTypePasswordController = TextEditingController();
  final TextEditingController contact_numberController = TextEditingController();

  XFile? _imageFile; // Updated to XFile for web compatibility
  final picker = ImagePicker();
  
  // Selected gender value
  String selectedGender = 'male';

  // Function to pick image from gallery
  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
          print("file $_imageFile");
        });
      } else {
        Get.snackbar('Error', 'No image selected.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  // Function to send data to the backend
  Future<void> signUpUser() async {
    if (isCheck == false) {
      Get.snackbar('Error', 'Please accept the terms and conditions.');
      return;
    }

    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String reTypePass = reTypePasswordController.text;
    final String contactNumber = contact_numberController.text;
    final String gender = selectedGender; // Gender selected from radio buttons

    if (password != reTypePass) {
      Get.snackbar('Error', 'Passwords do not match.');
      return;
    }

    // Backend API URL
    final url = Uri.parse('$baseUrl/api/v1/user/register'); // Update with actual backend URL

    // Create multipart request
    var request = http.MultipartRequest('POST', url);

    // Add fields to the request
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['contact_number'] = contactNumber;
    request.fields['password'] = password;
    request.fields['gender'] = gender;

    // If file is selected, add the file to the request
    if (_imageFile != null) {
      Uint8List fileBytes = await _imageFile!.readAsBytes(); // For web compatibility

      var multipartFile = http.MultipartFile.fromBytes(
        'avatar', // Key in the backend
        fileBytes,
        filename: _imageFile!.name,
      );
      request.files.add(multipartFile);
    }

    try {
      // Send the request to the backend
      var response = await request.send();

      // Read the response
      var responseString = await response.stream.bytesToString();
      print('Response: $responseString');

      // Check the response status
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'User signed up successfully');
      } else {
        Get.snackbar('Error', 'Sign up failed. Please try again.');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to send request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
                            "Sign Up In To Trendify", // Label for E-Comm button
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight:
                                    FontWeight.bold), // Adjust font size
                          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Name field
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            // Email field
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            // Contact field
            TextField(
              controller: contact_numberController,
              decoration: const InputDecoration(labelText: 'Contact'),
            ),
            // Password field
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            // Retype Password field
            TextField(
              controller: reTypePasswordController,
              decoration: const InputDecoration(labelText: 'Retype Password'),
              obscureText: true,
            ),
            
            const SizedBox(height: 16),
            // Gender selection radio buttons
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Male'),
                  value: 'male',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Female'),
                  value: 'female',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            // Image picker button
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Pick Profile Image'),
            ),
            if (_imageFile != null) ...[
              const SizedBox(height: 10),
              // You can add an image preview if needed
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isCheck,
                  onChanged: (newValue) {
                    setState(() {
                      isCheck = newValue;
                    });
                  },
                ),
                const Text('I agree to the Terms and Conditions'),
              ],
            ),
            ElevatedButton(
              onPressed: signUpUser,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
