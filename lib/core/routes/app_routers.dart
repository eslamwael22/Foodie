import 'package:foodie/features/auth/views/log_in_view.dart';
import 'package:foodie/features/auth/views/sign_up_view.dart';
import 'package:foodie/features/cart/views/cart_view.dart';
import 'package:foodie/features/checkout/views/checkout_view.dart';
import 'package:foodie/features/home/views/home_view.dart';
import 'package:foodie/features/orderHistory/views/orderHistory.dart';
import 'package:foodie/features/product_details/views/product_details.dart';
import 'package:foodie/features/home/data/models/product_model.dart';
import 'package:foodie/features/profile/views/profile_view.dart';
import 'package:foodie/roots.dart';
import 'package:foodie/splash_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/profile', builder: (context, state) => ProfileView()),
    GoRoute(path: '/signup', builder: (context, state) => SignUpView()),
    GoRoute(path: '/Login', builder: (context, state) => LogInView()),
    GoRoute(path: '/', builder: (context, state) => SplashView()),
    GoRoute(
      path: '/Proudcts',
      builder: (context, state) =>
          ProductDetailsview(product: state.extra! as ProductModel),
    ),
    GoRoute(path: '/Home', builder: (context, state) => HomeView()),
    GoRoute(path: '/Roots', builder: (context, state) => Roots()),

    GoRoute(
      path: '/Cart',
      builder: (context, state) {
        final priceOverrides = state.extra is Map<String, double>
            ? state.extra as Map<String, double>
            : <String, double>{};
        return CartView(priceOverrides: priceOverrides);
      },
    ),
    GoRoute(
      path: '/Checkout',
      builder: (context, state) {
        final cartTotal = state.extra is num
            ? (state.extra as num).toDouble()
            : 0.0;
        return CheckoutView(cartTotal: cartTotal);
      },
    ),
    GoRoute(path: '/OrderHistory', builder: (context, state) => Orderhistory()),
  ],
);
