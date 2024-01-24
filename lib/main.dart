import 'package:flutter/material.dart';
import 'package:job_finder/view/screens/auth/login_screen.dart';
import 'package:job_finder/view/screens/home_screen.dart';
import 'package:job_finder/view/screens/settings_screen.dart';

void main() {
  runApp(const AppNavigator());
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/auth/login",
      routes: {
        "/auth/login": (context) => const LoginScreen(),
        "/": (context) => const HomeScreen(),
        "/settings": (context) => const SettingsScreen()
      },
    );
  }
}
