import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/home/presentation/home_screen.dart';
import 'route_error_screen.dart';

abstract final class AppRoutePaths {
  static const String home = '/';
}

abstract final class AppRouteNames {
  static const String home = 'home';
}

final Provider<GoRouter> appRouterProvider = Provider<GoRouter>((ref) {
  final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const RouteErrorScreen(),
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutePaths.home,
        name: AppRouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});
