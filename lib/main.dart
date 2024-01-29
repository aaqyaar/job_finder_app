import 'package:flutter/material.dart';
import 'package:job_finder/controllers/auth_provider.dart';
import 'package:job_finder/utils/colors.dart';
import 'package:job_finder/view/protected_route.dart';
import 'package:job_finder/view/screens/auth/forgot_screen.dart';
import 'package:job_finder/view/screens/auth/login_screen.dart';
import 'package:job_finder/view/screens/auth/register_screen.dart';
import 'package:job_finder/view/screens/auth/reset_screen.dart';
import 'package:job_finder/view/screens/dashboard/dashboard_screen.dart';
import 'package:job_finder/view/screens/home_screen.dart';
import 'package:job_finder/view/screens/dashboard/new_edit_job_screen.dart';
import 'package:job_finder/view/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(const AppNavigator());
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        theme: ThemeData(
          primaryColor: AppColor.primary,
          buttonTheme: ButtonThemeData(
            buttonColor: AppColor.primary,
            textTheme: ButtonTextTheme.primary,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: AppColor.primary,
            ),
          ),
          fontFamily: "Inter",
        ),
        routes: {
          "/auth/login": (context) => LoginScreen(),
          "/auth/register": (context) => RegisterScreen(),
          "/auth/forgot-password": (context) => ForgotPasswordScreen(),
          "/auth/reset-password": (context) => ResetPasswordScreen(),
          "/": (context) => ProtectedRoute(child: HomeScreen()),
          "/dashboard/jobs": (context) => ProtectedRoute(
                child: DashboardScreen(),
              ),
          "/dashboard/jobs/new": (context) =>
              ProtectedRoute(child: NewEditJobScreen()),
          "/settings": (context) => ProtectedRoute(child: SettingsScreen()),
        },
      ),
    );
  }
}
