import 'package:foodie/features/auth/views/log_in_view.dart';
import 'package:foodie/features/auth/views/sign_up_view.dart';
import 'package:foodie/features/home/views/home_view.dart';
import 'package:foodie/roots.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => Roots()),
    GoRoute(path: '/signup', builder: (context, state) => SignUpView()),
    GoRoute(path: '/Login', builder: (context, state) => LogInView()),
  ],
);
