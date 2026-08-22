import 'package:foodie/core/network/api_service.dart';
import 'package:foodie/core/utils/pref_helpers.dart';
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

      if (user.token == null || user.token!.isEmpty) {
        throw Exception('Login failed: No authentication token received');
      }

      // Save token
      await PrefHelpers.saveToken(user.token!);

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
  ) async {
    try {
      final response = await apiService.post('/auth/signup', {
        'name': name,
        'email': email,
        'password': password,
        'rePassword': rePassword,
      });

      final user = UserModel.fromJson(response);

      if (user.token == null || user.token!.isEmpty) {
        throw Exception('Signup failed: No authentication token received');
      }

      // Save token
      await PrefHelpers.saveToken(user.token!);

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
