import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/network/api_errors.dart';
import 'package:foodie/core/network/api_service.dart';
import 'package:foodie/core/widgets/custom_snak_bar.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/cart/data/cart_model.dart';
import 'package:foodie/features/cart/data/cart_repository.dart';
import 'package:foodie/features/cart/widgets/cart_buttom_bar.dart';
import 'package:foodie/features/cart/widgets/cart_item.dart';
import 'package:foodie/features/cart/widgets/refresh_indicator.dart';
import 'package:foodie/features/home/data/models/product_model.dart';
import 'package:foodie/features/home/data/services/product_service.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartView extends StatefulWidget {
  final Map<String, double> priceOverrides;
  const CartView({super.key, this.priceOverrides = const {}});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartRepository _cartRepository = CartRepository(ApiService());
  final ProductService _productService = ProductService();

  CartModel? _cart;
  List<ProductModel> _firebaseProducts = [];
  late final Map<String, double> _priceOverrides = {...widget.priceOverrides};
  bool _isLoading = true;
  bool _isUpdating = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final cart = await _cartRepository.getCart();
      final firebaseProducts = await _productService.getProducts();
      if (!mounted) return;

      setState(() {
        _cart = cart;
        _firebaseProducts = firebaseProducts;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e is ApiError ? e.message : e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _updateCount(CartProduct item, int count) async {
    if (_isUpdating || count < 1) return;
    final previousCart = _cart;
    if (previousCart == null) return;

    final updatedProducts = previousCart.products.map((cartProduct) {
      if (cartProduct.product.id != item.product.id) return cartProduct;

      return CartProduct(
        id: cartProduct.id,
        count: count,
        price: cartProduct.price,
        product: cartProduct.product,
      );
    }).toList();

    setState(() => _isUpdating = true);
    setState(() {
      _cart = CartModel(
        id: previousCart.id,
        products: updatedProducts,
        totalCartPrice: previousCart.totalCartPrice,
      );
    });

    try {
      final cart = await _cartRepository.updateCartItemCount(
        item.product.id,
        count,
      );
      if (!mounted) return;

      setState(() => _cart = cart);
    } catch (e) {
      if (mounted) setState(() => _cart = previousCart);
      _showError(e);
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  Future<void> _removeItem(CartProduct item) async {
    if (_isUpdating) return;

    setState(() => _isUpdating = true);

    try {
      final cart = await _cartRepository.removeCartItem(item.product.id);
      if (!mounted) return;

      setState(() => _cart = cart);
    } catch (e) {
      _showError(e);
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  void _showError(Object e) {
    if (!mounted) return;

    final message = e is ApiError ? e.message : e.toString();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(customSnackBar(message: message));
  }

  double _priceFor(CartProduct item) {
    return _priceOverrides[item.product.id]?.toDouble() ??
        (firebaseProductFor(item)?.price ?? item.price).toDouble();
  }

  ProductModel? firebaseProductFor(CartProduct item) {
    return _firebaseProducts
        .where((product) => product.apiProductId == item.product.id)
        .firstOrNull;
  }

  num _displayTotal(List<CartProduct> products) {
    return products.fold<num>(
      0,
      (total, item) => total + (_priceFor(item) * item.count),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = _cart?.products ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Cart',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),

              CustomText(
                text: 'Review your Items and Proceed to Checkout',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.textGrey,
              ),
            ],
          ),
        ),
      ),
      body: _buildBody(products),
      bottomNavigationBar: products.isEmpty
          ? null
          : CartButtomBar(
              totalPrice: _displayTotal(_cart?.products ?? []).toDouble(),
            ),
    );
  }

  Widget _buildBody(List<CartProduct> products) {
    if (_isLoading) {
      return Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: AppColors.primary,
          size: 80,
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: _errorMessage!,
                fontSize: 16,
                color: AppColors.textGrey,
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: _loadCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (products.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.remove_shopping_cart,
              size: 80,
              color: AppColors.primary,
            ),
            Gap(10),
            CustomText(
              text: 'Your cart is empty..',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ],
        ),
      );
    }

    return CartRefreshIndicator(
      onRefresh: _loadCart,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 120),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          final firebaseProduct = firebaseProductFor(item);

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CartItem(
              item: item,
              firebaseProduct: firebaseProduct,
              displayPrice: _priceFor(item),
              onIncrement: () => _updateCount(item, item.count + 1),
              onDecrement: () => _updateCount(item, item.count - 1),
              onRemove: () => _removeItem(item),
            ),
          );
        },
      ),
    );
  }
}
