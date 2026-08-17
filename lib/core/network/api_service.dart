import 'package:dio/dio.dart';
import 'package:foodie/core/network/api_errors.dart';
import 'package:foodie/core/network/api_exceptions.dart';
import 'package:foodie/core/network/dio_client.dart';

class ApiService {
  // GET request
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await DioClient().dio.get(endpoint);
      return response.data;
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await DioClient().dio.post(endpoint, data: data);

      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  // PUT request // update data
  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await DioClient().dio.put(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // DELETE request
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await DioClient().dio.delete(endpoint);
      return response.data;
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
