import 'package:dio/dio.dart';

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
        onRequest: (options, handler) {
          // بتتنفذ قبل ما يبعت الريكوست
          final token = 'your_token_here';
          if (token != null && token.isNotEmpty)
            options.headers['Authorization'] = 'Bearer $token'; // Replace
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
