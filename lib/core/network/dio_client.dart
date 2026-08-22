import 'package:dio/dio.dart';
import 'package:foodie/core/utils/pref_helpers.dart';

class DioClient {
  final Dio _dio = Dio(
    // عملت اوبجيكيت من Dio و حطيت فيه الاوبشنز بتاعتي
    BaseOptions(
      baseUrl: 'https://ecommerce.routemisr.com/api/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  DioClient() {
    // constructor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // بتتنفذ قبل ما يبعت الريكوست
          final token = await PrefHelpers.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['token'] = token;
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
