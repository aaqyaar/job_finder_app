import 'dart:convert';
import 'package:http/http.dart' as http;
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
}
