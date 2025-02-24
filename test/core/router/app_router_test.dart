import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/core/router/app_router.dart';
import 'package:riverpod_app/core/router/app_router_names.dart';
import 'package:riverpod_app/core/router/page_not_found.dart';
import 'package:riverpod_app/features/auth/presentation/views/auth_screen.dart';

void main() {
  late AppRouter appRouter;

  setUp(() {
    appRouter = AppRouter(isRouteTesting: true);
  });

  Future<void> pumpRouter(WidgetTester tester, GoRouter router) async {
    await tester.pumpWidget(
      MaterialApp.router(
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }

  group('AppRouter Tests', () {
    testWidgets('navigates to [AuthScreen] for initial route', (tester) async {
      // Arrange
      final router = appRouter.router();

      // Act
      await pumpRouter(tester, router);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AuthScreen), findsOneWidget);
    });

    testWidgets('Should show [AuthScreen] when route is [/auth]',
        (tester) async {
      // Arrange
      final router = appRouter.router('/auth');

      // Act
      await pumpRouter(tester, router);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AuthScreen), findsOneWidget);
    });

    testWidgets(
        'Should show [AuthScreen] when navigating to [AppRouteNames.auth]',
        (tester) async {
      // Arrange
      final router = appRouter.router();

      // Act
      await pumpRouter(tester, router);
      router.go(AppRouteNames.auth);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AuthScreen), findsOneWidget);
    });

    testWidgets('Should show [PageNotFound] when navigating to an invalid path',
        (tester) async {
      // Arrange
      final router = appRouter.router();

      // Act
      await pumpRouter(tester, router);
      router.go('/invalid_path');
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(PageNotFound), findsOneWidget);
    });
  });
}
