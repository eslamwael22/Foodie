class CartModel {
  final String id;
  final List<CartProduct> products;
  final num totalCartPrice;

  const CartModel({
    required this.id,
    required this.products,
    required this.totalCartPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final productsJson = data['products'] as List? ?? [];

    return CartModel(
      id: data['_id']?.toString() ?? '',
      products: productsJson
          .whereType<Map<String, dynamic>>()
          .map(CartProduct.fromJson)
          .toList(),
      totalCartPrice: data['totalCartPrice'] as num? ?? 0,
    );
  }
}

class CartProduct {
  final String id;
  final int count;
  final num price;
  final ProductInfo product;

  const CartProduct({
    required this.id,
    required this.count,
    required this.price,
    required this.product,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['_id']?.toString() ?? '',
      count: json['count'] as int? ?? 1,
      price: json['price'] as num? ?? 0,
      product: ProductInfo.fromJson(
        json['product'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class ProductInfo {
  final String id;
  final String title;
  final String imageCover;
  final String categoryName;

  const ProductInfo({
    required this.id,
    required this.title,
    required this.imageCover,
    required this.categoryName,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    final category = json['category'] as Map<String, dynamic>? ?? {};

    return ProductInfo(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      imageCover: json['imageCover']?.toString() ?? '',
      categoryName: category['name']?.toString() ?? '',
    );
  }
}
