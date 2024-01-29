import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_finder/controllers/auth_provider.dart';
import 'package:job_finder/services/api.dart';
import 'package:job_finder/utils/colors.dart';
import 'package:job_finder/utils/storage.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _loading = false;

  // Register method
  void register(
    AuthProvider authProvider,
  ) async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String phone = _phoneController.text;

    // Check if email and password are not empty
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        name.isNotEmpty &&
        phone.isNotEmpty) {
      try {
        // Call the register API
        final response =
            await ApiService.register(name, phone, email, password);

        if (response.data != null) {
          // Login successful
          String accessToken = response.data!.accessToken;

          await Storage.setValue("token", accessToken);

          await Storage.setValue("isAuthenticated", true);

          Map<String, dynamic> user = {
            'email': response.data!.email,
            'name': response.data!.name,
            'phone': response.data!.phone,
            'role': response.data!.role,
            'id': response.data!.id,
            'status': response.data!.status
          };

          await Storage.setValue('user', user);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Register successful'),
              duration: Duration(seconds: 2),
            ),
          );

          authProvider.login();

          Navigator.pushNamed(context, "/");
        } else {
          // Handle API response with status 'error'
          String errorMessage = response.message.toString();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Register failed: $errorMessage'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
      } catch (e) {
        // Handle other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            duration: Duration(seconds: 12),
          ),
        );

        return;
      } finally {
        setState(() {
          _loading = false; // Set loading to false after the API call completes
        });
      }
    } else {
      // Show error message for empty email or password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Name, Phone, Email and password cannot be empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
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
                  "Create Account",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Please fill the form below to create an account",
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Full Name",
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
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email Address",
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
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
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
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
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

                // register button with just Container and GestureDetector
                Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      register(authProvider);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/auth/login");
                        },
                        child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
