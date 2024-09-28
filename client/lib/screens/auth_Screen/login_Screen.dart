import 'package:ecommerce_mobile_app/Constant/colors.dart';
import 'package:ecommerce_mobile_app/Provider/screen_Index.dart';
import 'package:ecommerce_mobile_app/screens/Home/Widget/custom_textfield.dart';
import 'package:ecommerce_mobile_app/screens/Home/Widget/my_Button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  void _login(BuildContext context) async {
    final screenIndexProvider = Provider.of<ScreenIndex>(context, listen: false); // Access ScreenIndex provider
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    String email = _emailController.text ?? "";
    String password = _passwordController.text ?? "";

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Email and password cannot be empty";
        isLoading = false;
      });
      return;
    }

    final authService = AuthService();
    final response = await authService.login(email, password);
    print("responsedata $response");
    setState(() {
      isLoading = false;
    });

    if (response['success']) {
      screenIndexProvider.setIndex(2); // Navigate to home after successful login using ScreenIndex provider
    } else {
      setState(() {
        errorMessage = response['message'] ?? 'Login failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                10.heightBox,
                const Text(
                            "Log In To Trendify", // Label for E-Comm button
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight:
                                    FontWeight.bold), // Adjust font size
                          ),
                Column(
                  children: [
                    // Email input field
                    custom_taxtField(
                      hint: "Enter Your Email",
                      title: "Email",
                      controller: _emailController,
                    ),

                    // Password input field
                    custom_taxtField(
                      hint: "Enter Your Password",
                      title: "Password",
                      controller: _passwordController,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Forget Password"),
                      ),
                    ),

                    if (errorMessage != null)
                      Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),

                    5.heightBox,

                    // Login button
                    isLoading
                        ? const CircularProgressIndicator()
                        : myButton(
                            onPress: () {
                              _login(context); // Call the login function on press
                            },
                            color: blueColor,
                            textColor: whiteColor,
                            title: "Log in",
                          )
                            .box
                            .width(_getResponsiveWidth(constraints, context))
                            .make(),

                    5.heightBox,

                    const Text("Create New Account"),

                    5.heightBox,

                    // Signup button
                    myButton(
                      onPress: () {
                        final screenIndexProvider = Provider.of<ScreenIndex>(context, listen: false); // Access ScreenIndex provider
                        screenIndexProvider.setIndex(5); // Navigate to the signup screen using ScreenIndex provider
                      },
                      color: lightgolden,
                      textColor: blueColor,
                      title: "Sign Up",
                    )
                        .box
                        .width(_getResponsiveWidth(constraints, context))
                        .make(),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(_getResponsiveWidth(constraints, context))
                    .shadowSm
                    .make(),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method to calculate responsive width
  double _getResponsiveWidth(BoxConstraints constraints, BuildContext context) {
    if (constraints.maxWidth > 1200) {
      return 600;
    } else if (constraints.maxWidth > 800) {
      return context.screenWidth * 0.7;
    } else {
      return context.screenWidth - 50;
    }
  }
}
