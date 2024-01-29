class CommonResponse {
  final String? status;
  final String? message;

  CommonResponse({this.status, this.message});

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}

class LoginResponse {
  final Token? data; // Make it nullable to handle errors
  final String? message; // Add a property for the error message
  final String? status; // Add a property for the status

  LoginResponse({
    required this.data,
    this.message,
    required this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      data: json['data'] != null ? Token.fromJson(json['data']) : null,
      message: json['message'] ?? null,
    );
  }
}

class Token {
  final String accessToken;
  final String refreshToken;
  final String? id;
  final String? email;
  final String? phone;
  final String? name;
  final String? role;
  final String? status;

  Token({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.role,
    required this.status,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        id: json['_id'],
        email: json['email'],
        phone: json['phone'],
        role: json['role'],
        name: json['name'],
        status: json['status']);
  }
}
