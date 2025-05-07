class AuthResponse {
  final String token;
  final String message;
  final User? user;

  AuthResponse({required this.token, required this.message, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['data']?['token'] ?? '',
      message: json['message'] ?? '',
      user: json['data']?['user'] != null 
          ? User.fromJson(json['data']['user']) 
          : null,
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}