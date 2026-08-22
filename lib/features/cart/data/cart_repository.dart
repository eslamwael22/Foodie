import 'package:foodie/core/network/api_service.dart';
import 'package:foodie/features/cart/data/cart_model.dart';

class CartRepository {
  final ApiService _apiService;

  CartRepository(this._apiService);

  Future<CartModel> getCart() async {
    final response = await _apiService.get('cart');
    return CartModel.fromJson(response);
  }

  Future<dynamic> addToCart(String productId) async {
    return await _apiService.post('cart', {'productId': productId});
  }

  Future<CartModel> updateCartItemCount(String productId, int count) async {
    final response = await _apiService.put('cart/$productId', {'count': count});
    return CartModel.fromJson(response);
  }

  Future<CartModel> removeCartItem(String productId) async {
    final response = await _apiService.delete('cart/$productId');
    return CartModel.fromJson(response);
  }
}
