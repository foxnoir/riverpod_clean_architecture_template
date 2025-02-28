import 'package:book_dragon/core/router/app_router_names.dart';
import 'package:book_dragon/core/router/page_not_found_screen.dart';
import 'package:book_dragon/core/router/transiton_page.dart';
import 'package:book_dragon/features/auth/presentation/views/auth_screen.dart';
import 'package:book_dragon/features/auth/presentation/views/otp_verification_screen.dart';
import 'package:book_dragon/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// GoRouter als Provider registrieren
final goRouterProvider = Provider<GoRouter>((ref) {
  return AppRouter.router;
});

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRouteNames.onBoarding,
    errorBuilder: (context, state) => const PageNotFoundScreen(),
    routes: [
      GoRoute(
        path: AppRouteNames.onBoarding,
        name: AppRouteNames.onBoarding,
        builder: (context, state) => const PageNotFoundScreen(),
        routes: [
          GoRoute(
            path: AppRouteNames.auth,
            name: AppRouteNames.auth,
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child: const AuthScreen(),
            ),
            routes: [
              GoRoute(
                path: AppRouteNames.otp,
                name: AppRouteNames.otp,
                pageBuilder: (context, state) {
                  final verificationId =
                      state.uri.queryParameters['verification_Id'];

                  return SlideTransitionPage(
                    key: state.pageKey,
                    child: OTPVerificationScreen(
                      verificationId: verificationId!,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;

  static String get currentLocation {
    final matches = _router.routerDelegate.currentConfiguration;
    return matches.isNotEmpty ? matches.last.matchedLocation : '/';
  }
}
