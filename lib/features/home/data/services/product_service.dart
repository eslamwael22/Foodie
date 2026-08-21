import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _firestore.collection('products').get();

    final products = snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();

    for (final product in products) {
      print('Product ${product.id} image URL: ${product.imageUrl}');
    }

    return products;
  }
}
