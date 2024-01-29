import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_finder/services/api.dart';
import 'package:job_finder/utils/colors.dart';
import 'package:job_finder/utils/storage.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _oneTimeCodeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  // ResetPassword method
  void resetPassword() async {
    String code = _oneTimeCodeController.text;
    String newPassword = _newPasswordController.text;
    String confirmNewPassword = _confirmNewPasswordController.text;

    // Check if email is not empty
    if (code.isNotEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty) {
      if (newPassword != confirmNewPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password don't match, try again")));

        return;
      }

      // Call the login API
      final response = await ApiService.resetPassword(code, newPassword);
      if (response != null) {
        if (response.status == "success") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password has been changed successfuly'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pushNamed(context, "/auth/login");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message.toString())),
          );
        }
      } else {
        // Show a generic error message if response is null
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred during reseting password")),
        );
      }
    } else {
      // Show error message for empty email or password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All the fields are required")),
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
                  "Reset Password?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter the one time code sent to your email and your new password",
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _oneTimeCodeController,
                  decoration: InputDecoration(
                    hintText: "One Time Code",
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
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "New Password",
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
                  controller: _confirmNewPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm New Password",
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
                      resetPassword();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Reset Password",
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
