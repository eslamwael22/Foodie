import 'package:dio/dio.dart';
import 'package:foodie/core/network/api_errors.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'Connection Timeout', statuscode: 408);
      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Send Timeout', statuscode: 408);
      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'Receive Timeout', statuscode: 408);
      case DioExceptionType.badResponse:
        final data = error.response?.data;
        String errorMessage = 'Bad Response';

        if (data is Map<String, dynamic>) {
          // الحالة الأولى: فيه array اسمه errors (validation errors)
          if (data['errors'] != null &&
              data['errors'] is List &&
              (data['errors'] as List).isNotEmpty) {
            final firstError = data['errors'][0];
            if (firstError is Map<String, dynamic> &&
                firstError['msg'] != null) {
              errorMessage = firstError['msg'];
            }
          }
          // الحالة التانية: الـ message نفسها فيها الرسالة الحقيقية (409 مثلاً)
          else if (data['message'] != null && data['message'] != 'fail') {
            errorMessage = data['message'];
          }
        }
        return ApiError(
          message: error.response?.data['message'] ?? 'Bad Response',
          statuscode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ApiError(message: 'Request Cancelled', statuscode: 499);
      case DioExceptionType.unknown:
        return ApiError(message: 'Unknown Error', statuscode: 520);
      default:
        return ApiError(message: 'Something went wrong', statuscode: 520);
    }
  }
}
