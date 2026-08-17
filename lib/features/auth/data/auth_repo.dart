import 'package:foodie/core/network/api_service.dart';
import 'package:foodie/features/auth/data/auth_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  // sign in method
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

  // sign up method
  Future<UserModel> signUp(
    String name,
    String email,
    String password,
    String rePassword,
    String phone,
  ) async {
    try {
      final response = await apiService.post('/auth/signup', {
        'name': name,
        'email': email,
        'password': password,
        'rePassword': rePassword,
        'phone': phone,
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
