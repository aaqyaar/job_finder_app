import 'package:flutter/material.dart';
import 'package:job_finder/services/api.dart';
import 'package:job_finder/utils/storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Login method
  void login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Check if email and password are not empty
    if (email.isNotEmpty && password.isNotEmpty) {
      // Call the login API
      final response = await ApiService.login(email, password);

      if (response != null) {
        if (response.data != null) {
          // Store the token in storage
          await Storage.setValue("token", response.data!.accessToken);
          // Navigate to home screen
          Navigator.pushNamed(context, "/");
        }
        if (response.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message!.toString())),
          );
        } else {
          // Show a generic error message if response.data and message are both null
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An error occurred during login")),
          );
        }
      } else {
        // Show a generic error message if response is null
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred during login")),
        );
      }
    } else {
      // Show error message for empty email or password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email and password cannot be empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome back, please login to your account",
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text("Login"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/auth/register");
                    },
                    child: Text("Register"))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
