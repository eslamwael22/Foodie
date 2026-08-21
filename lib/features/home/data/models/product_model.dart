import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String imageUrl;
  final String name;
  final double price;
  final double rating;
  final String subtitle;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.subtitle,
  });

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return ProductModel(
      id: doc.id,
      imageUrl: _readImageUrl(data),
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      subtitle: data['subtitle'] ?? '',
    );
  }

  static String _readImageUrl(Map<String, dynamic> data) {
    final imageValue =
        data['imageUrl'] ?? data['image'] ?? data['image_url'] ?? data['photo'];

    if (imageValue is String) return _cleanImageUrl(imageValue);

    final images = data['images'];
    if (images is List && images.isNotEmpty && images.first is String) {
      return _cleanImageUrl(images.first as String);
    }

    return '';
  }

  static String _cleanImageUrl(String value) {
    return value.trim().replaceAll('`', '');
  }
}
