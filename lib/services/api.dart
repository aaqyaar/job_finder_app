import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_finder/config/config.dev.dart';
import 'package:job_finder/models/auth.dart';
import 'package:job_finder/models/jobs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future<LoginResponse> login(String email, String password) async {
    final uri = Uri.parse('$API_URL/auth/login');

    final response = await http.post(uri, body: {
      'username': email,
      'password': password,
    });

    final body = response.body;

    final json = jsonDecode(body);

    return LoginResponse.fromJson(json);
  }

  static Future<LoginResponse> register(
      String name, String phone, String email, String password) async {
    final uri = Uri.parse('$API_URL/auth/register');

    final response = await http.post(uri,
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    final Map<String, dynamic> responseData = json.decode(response.body);
    return LoginResponse.fromJson(responseData);
  }

  static Future<LoginResponse> postLogin(String email, String password) async {
    final String apiUrl = '$API_URL/auth/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': email,
          'password': password,
        }),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      return LoginResponse.fromJson(responseData);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<CommonResponse> resetPassword(
      String code, String password) async {
    final String apiUrl = '$API_URL/auth/reset-password';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'resetCode': code,
          'password': password,
        }),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      return CommonResponse.fromJson(responseData);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<CommonResponse> forgotPassword(String email) async {
    final String apiUrl = '$API_URL/auth/forgot-password';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': email,
        }),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      return CommonResponse.fromJson(responseData);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<JobModel>> getJobs() async {
    final String url = '$API_URL/jobs';
    final String token = await _getAuthenticationStatus();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final BaseResponse<dynamic> baseResponse =
            BaseResponse<dynamic>.fromJson(responseData);

        if (baseResponse.data != null) {
          final List<dynamic> jobsData = baseResponse.data!;

          return jobsData.map((job) => JobModel.fromJson(job)).toList();
        } else {
          throw Exception('Data not available in the response.');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<JobModel> createJob(
    String title,
    String description,
    String salary,
    String tags,
    String company,
    String address,
    String city,
    String state,
    String phone,
    String email,
    String requirements,
    String benefits,
  ) async {
    final String url = '$API_URL/jobs';

    final String token = await _getAuthenticationStatus();
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'title': title,
            'description': description,
            'salary': salary,
            'tags': tags,
            'company': company,
            'address': address,
            'city': city,
            'state': state,
            'phone': phone,
            'email': email,
            'requirements': requirements,
            'benefits': benefits,
          }));

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        return JobModel.fromJson(responseData);
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<String> _getAuthenticationStatus() async {
    // Retrieve the authentication status from SharedPreferences
    SharedPreferences prefs;
    String token;
    try {
      prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token') ?? '';
    } catch (e) {
      token = '';
    }
    return token;
  }

  static Future<JobModel> updateJob(
    String id,
    String title,
    String description,
    String salary,
    String tags,
    String company,
    String address,
    String city,
    String state,
    String phone,
    String email,
    String requirements,
    String benefits,
  ) async {
    final String url = '$API_URL/jobs/$id';

    final String token = await _getAuthenticationStatus();
    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'title': title,
            'description': description,
            'salary': salary,
            'tags': tags,
            'company': company,
            'address': address,
            'city': city,
            'state': state,
            'phone': phone,
            'email': email,
            'requirements': requirements,
            'benefits': benefits,
          }));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        return JobModel.fromJson(responseData);
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<CommonResponse> deleteJob(String id) async {
    final String apiUrl = '$API_URL/jobs/$id';
    final String token = await _getAuthenticationStatus();

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      return CommonResponse.fromJson(responseData);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
