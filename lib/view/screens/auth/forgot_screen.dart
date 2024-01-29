import 'package:flutter/material.dart';
import 'package:job_finder/services/api.dart';
import 'package:job_finder/utils/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  // ForgotPassword method
  void forgotPassword() async {
    String email = _emailController.text;

    // Check if email is not empty
    if (email.isNotEmpty) {
      // Call the login API
      final response = await ApiService.forgotPassword(email);
      if (response != null) {
        if (response.status == "success") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email has been sent out $email successfully'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pushNamed(context, "/auth/reset-password");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message.toString())),
          );
        }
      } else {
        // Show a generic error message if response is null
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred during sending email")),
        );
      }
    } else {
      // Show error message for empty email or password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email cannot be empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Job Finder"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  width: 4,
                ),
                Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter your email address or phone number to reset your password.",
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email Address / Phone Number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color:
                            AppColor.secondary, // Border color when not focused
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: AppColor.secondary,
                          width: 1 // Border color when focused
                          ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                // Login button with just Container and GestureDetector
                Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      forgotPassword();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Forgot Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
