import 'package:book_dragon/core/router/app_router_names.dart';
import 'package:book_dragon/core/router/page_not_found_screen.dart';
import 'package:book_dragon/core/router/transiton_page.dart';
import 'package:book_dragon/features/auth/presentation/views/auth_screen.dart';
import 'package:book_dragon/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppRouter {
  late final GoRouter _router = GoRouter(
    initialLocation: AppRouteNames.onBoarding,
    errorBuilder: (context, state) => const PageNotFoundScreen(),
    routes: [
      GoRoute(
        path: AppRouteNames.onBoarding,
        name: AppRouteNames.onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
        routes: [
          GoRoute(
            path: AppRouteNames.auth,
            name: AppRouteNames.auth,
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child: const AuthScreen(),
            ),
          ),
        ],
      ),
    ],
  );

  GoRouter get router => _router;

  String get currentLocation {
    final matches = _router.routerDelegate.currentConfiguration;
    return matches.isNotEmpty ? matches.last.matchedLocation : '/';
  }
}
