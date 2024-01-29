import 'package:flutter/material.dart';
import 'package:job_finder/controllers/auth_provider.dart';
import 'package:job_finder/view/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget child;

  ProtectedRoute({required this.child});

  @override
  Widget build(BuildContext context) {
    // Access the authentication status from the AuthProvider
    final authProvider = Provider.of<AuthProvider>(context);

    // Check if the user is authenticated
    if (authProvider.isAuthenticated) {
      return child; // Render the protected content
    } else {
      // Redirect to the login screen or any other authentication screen
      return LoginScreen(); // Replace LoginScreen with your actual login screen
    }
  }
}
