class LoginResponse {
  final Token? data; // Make it nullable to handle errors
  final String? message; // Add a property for the error message

  LoginResponse({
    required this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: json['data'] != null ? Token.fromJson(json['data']) : null,
      message: json['message'],
    );
  }
}

class Token {
  final String accessToken;
  final String refreshToken;

  Token({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
