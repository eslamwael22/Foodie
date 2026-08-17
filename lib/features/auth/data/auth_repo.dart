import 'package:foodie/core/network/api_service.dart';
import 'package:foodie/features/auth/data/auth_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  Future<UserModel> signIn(String email, String password) async {
    try {
      final response = await apiService.post('/auth/signin', {
        'email': email,
        'password': password,
      });
      final user = UserModel.fromJson(response);
      // Validate that we received a token
      if (user.token == null || user.token!.isEmpty) {
        throw Exception('Login failed: No authentication token received');
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
