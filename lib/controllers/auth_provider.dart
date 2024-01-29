import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late bool _authenticated;

  AuthProvider() {
    // Initialize the authentication status from SharedPreferences during construction
    _initAuthenticationStatus();
  }

  // Asynchronous named constructor
  AuthProvider.async() {
    // Initialize the authentication status from SharedPreferences during construction
    _initAuthenticationStatus();
  }

  Future<void> _initAuthenticationStatus() async {
    _authenticated = await _getAuthenticationStatus();
    notifyListeners();
  }

  bool get isAuthenticated => _authenticated;

  Future<void> login() async {
    _authenticated = true;

    // Save the authentication status to SharedPreferences
    await _saveAuthenticationStatus();

    notifyListeners();
  }

  Future<void> logout() async {
    _authenticated = false;

    // Save the authentication status to SharedPreferences
    await _saveAuthenticationStatus();

    notifyListeners();
  }

  Future<void> _saveAuthenticationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', _authenticated);
  }

  Future<bool> _getAuthenticationStatus() async {
    // Retrieve the authentication status from SharedPreferences
    SharedPreferences prefs;
    bool authenticated;

    try {
      prefs = await SharedPreferences.getInstance();
      authenticated = prefs.getBool('isAuthenticated') ?? false;
    } catch (e) {
      authenticated = false;
    }

    return authenticated;
  }
}
