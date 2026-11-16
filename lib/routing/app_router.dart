import 'package:go_router/go_router.dart';

import '../features/home/presentation/home_screen.dart';

abstract final class AppRoutePaths {
  static const String home = '/';
}

abstract final class AppRouteNames {
  static const String home = 'home';
}

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutePaths.home,
      name: AppRouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
