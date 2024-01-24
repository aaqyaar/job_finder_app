import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_finder/config/config.dev.dart';
import 'package:job_finder/models/auth.dart';
import 'package:job_finder/models/user.dart';

class ApiService {
  static Future<List<Result>> fetchUsers() async {
    final url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    final body = response.body;

    final json = jsonDecode(body);

    List<dynamic> jsonResults = json['results'];

    return jsonResults.map((jsonResult) {
      return Result.fromJson(jsonResult);
    }).toList();
  }

  static Future<LoginResponse> login(String email, String password) async {
    final uri = Uri.parse('$API_URL/auth/login');

    final response = await http.post(uri, body: {
      'username': email,
      'password': password,
    });

    final body = response.body;

    final json = jsonDecode(body);

    print(json + body);

    return LoginResponse.fromJson(json);
  }
}
