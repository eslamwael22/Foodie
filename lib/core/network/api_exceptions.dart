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
