import 'package:flutter/material.dart';
import 'package:job_finder/view/screens/home_screen.dart';

void main() {
  runApp(const AppNavigator());
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) => const HomeScreen()
      },
    );
  }
}
