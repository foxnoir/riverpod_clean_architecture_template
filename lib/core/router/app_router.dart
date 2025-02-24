import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_manager/core/router/app_router_names.dart';
import 'package:todo_manager/core/router/page_not_found.dart';
import 'package:todo_manager/core/router/transiton_page.dart';
import 'package:todo_manager/features/auth/presentation/views/auth_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter({required this.isRouteTesting});
  final bool isRouteTesting;

  GoRouter router([String? initialLocation]) => GoRouter(
        initialLocation: AppRouteNames.auth,
        navigatorKey: navigatorKey,
        errorBuilder: (context, state) => const PageNotFound(),
        routes: [
          ShellRoute(
            builder: (context, state, child) => Scaffold(
              body: child,
            ),
            routes: [
              GoRoute(
                path: AppRouteNames.auth,
                name: AppRouteNames.auth,
                builder: (context, state) =>
                    AuthScreen(isRouteTesting: isRouteTesting),
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
              path: AppRouteNames.auth,
              name: AppRouteNames.auth,
              pageBuilder: (context, state) => SlideTransitionPage(
                key: state.pageKey,
                child: AuthScreen(isRouteTesting: isRouteTesting),
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
