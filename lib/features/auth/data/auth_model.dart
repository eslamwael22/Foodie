class UserModel {
  final String email;
  final String name;
  final String? token;
  final String? role;

  UserModel({required this.email, required this.name, this.token, this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};
    return UserModel(
      email: user['email'] ?? '',
      name: user['name'] ?? '',
      token: json['token'] ?? '',
      role: user['role'],
    );
  }
}
