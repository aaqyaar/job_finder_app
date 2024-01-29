import 'package:flutter/material.dart';
import 'package:job_finder/controllers/auth_provider.dart';
import 'package:job_finder/services/api.dart';
import 'package:job_finder/utils/colors.dart';
import 'package:job_finder/utils/storage.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _emailController.text = "abdizamedmo@gmail.com";
    _passwordController.text = "1234567";
  }

  Future<void> _login(
    AuthProvider authProvider,
  ) async {
    try {
      setState(() {
        _loading = true;
      });

      final response = await ApiService.postLogin(
        _emailController.text,
        _passwordController.text,
      );

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
            content: Text('Login successful'),
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
            content: Text('Login failed: $errorMessage'),
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/auth/forgot-password");
                        },
                        child: Text("Forgot Password ?"))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (!_loading) {
                      _login(
                        authProvider,
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _loading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
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
