import 'package:foodie/features/auth/views/log_in_view.dart';
import 'package:foodie/features/auth/views/sign_up_view.dart';
import 'package:foodie/features/cart/views/cart_view.dart';
import 'package:foodie/features/checkout/views/checkout_view.dart';
import 'package:foodie/features/orderHistory/views/orderHistory.dart';
import 'package:foodie/features/product_details/views/product_details.dart';
import 'package:foodie/roots.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => Roots()),
    GoRoute(path: '/signup', builder: (context, state) => SignUpView()),
    GoRoute(path: '/Login', builder: (context, state) => LogInView()),
    GoRoute(
      path: '/Proudcts',
      builder: (context, state) => ProductDetailsview(),
    ),
    GoRoute(path: '/Cart', builder: (context, state) => CartView()),
    GoRoute(path: '/Checkout', builder: (context, state) => CheckoutView()),
    GoRoute(path: '/OrderHistory', builder: (context, state) => Orderhistory()),
  ],
);
