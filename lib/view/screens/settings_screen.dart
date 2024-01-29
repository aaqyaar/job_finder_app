import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_finder/controllers/auth_provider.dart';
import 'package:job_finder/models/auth.dart';
import 'package:job_finder/utils/colors.dart';
import 'package:job_finder/utils/storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: FutureBuilder(
        future: Storage.getValue('user'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var user = json.decode(snapshot.data);

          return ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              ListTile(
                title: Text(
                  user['name'] ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Name"),
                leading: Icon(Icons.person),
              ),
              ListTile(
                title: Text(
                  user['email'] ?? '',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text("Email"),
                leading: Icon(Icons.email),
              ),
              ListTile(
                title: Text(
                  user['phone'] ?? '',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text("Phone"),
                leading: Icon(Icons.phone),
              ),
              ListTile(
                title: Text(
                  user['status'] ?? '',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text("Status"),
                leading: Icon(Icons.info),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  user['role'] ?? '',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text("Role"),
                leading: Icon(Icons.shield),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Storage.clear();
                  authProvider.logout();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Logout",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
