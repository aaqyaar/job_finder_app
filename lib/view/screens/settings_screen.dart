import 'package:flutter/material.dart';
import 'package:job_finder/utils/storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String token = "";

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  // Fetch the token from storage
  void fetchToken() async {
    String storedToken = await Storage.getValue("token").toString();
    print(storedToken);
    setState(() {
      token = storedToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(token),
    );
  }
}
