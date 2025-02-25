import 'package:book_dragon/core/router/app_router_names.dart';
import 'package:book_dragon/core/router/page_not_found_screen.dart';
import 'package:book_dragon/core/router/transiton_page.dart';
import 'package:book_dragon/features/auth/presentation/views/auth_screen.dart';
import 'package:book_dragon/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter({required this.isRouteTesting});
  final bool isRouteTesting;

  GoRouter router([String? initialLocation]) => GoRouter(
        initialLocation: AppRouteNames.onBoarding,
        navigatorKey: navigatorKey,
        errorBuilder: (context, state) => PageNotFoundScreen(
          isRouteTesting: isRouteTesting,
        ),
        redirect: (context, state) {
          if ('${state.uri}'.contains('/google/link')) {
            return AppRouteNames.onBoarding;
          }
          return null;
        },
        routes: [
          ShellRoute(
            builder: (context, state, child) => Scaffold(
              body: child,
            ),
            routes: [
              GoRoute(
                path: AppRouteNames.onBoarding,
                name: AppRouteNames.onBoarding,
                builder: (context, state) =>
                    OnBoardingScreen(isRouteTesting: isRouteTesting),
                routes: [
                  GoRoute(
                    path: AppRouteNames.auth,
                    name: AppRouteNames.auth,
                    pageBuilder: (context, state) => SlideTransitionPage(
                      key: state.pageKey,
                      child: AuthScreen(
                        isRouteTesting: isRouteTesting,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}

final appRouter = AppRouter(isRouteTesting: false).router();

extension GoRouterLocation on GoRouter {
  String location({required bool isRouteTesting}) {
    final lastMatch = isRouteTesting
        ? RouteMatch(
            route: GoRoute(
              path: AppRouteNames.onBoarding,
              name: AppRouteNames.onBoarding,
              pageBuilder: (context, state) => SlideTransitionPage(
                key: state.pageKey,
                child: OnBoardingScreen(isRouteTesting: isRouteTesting),
              ),
            ),
            pageKey: const ValueKey('routeTesting'),
            matchedLocation: '',
          )
        : routerDelegate.currentConfiguration.last;
    final matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
