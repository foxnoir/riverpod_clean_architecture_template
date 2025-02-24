// Unit Test file for app_router.dartimport 'package:flutter/material.dart';
import 'package:book_lover/core/router/app_router.dart';
import 'package:book_lover/core/router/app_router_names.dart';
import 'package:book_lover/core/router/page_not_found_screen.dart';
import 'package:book_lover/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

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
    testWidgets('navigates to [OnBoardingScreen] for initial route',
        (tester) async {
      // Arrange
      final router = appRouter.router();

      // Act
      await pumpRouter(tester, router);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(OnBoardingScreen), findsOneWidget);
    });

    testWidgets('Should show [OnBoardingScreen] when route is [/onBoarding]',
        (tester) async {
      // Arrange
      final router = appRouter.router('/onBoarding');

      // Act
      await pumpRouter(tester, router);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(OnBoardingScreen), findsOneWidget);
    });

    testWidgets(
        'Should show [OnBoardingScreen] '
        'when navigating to [AppRouteNames.onBoarding]', (tester) async {
      // Arrange
      final router = appRouter.router();

      // Act
      await pumpRouter(tester, router);
      router.go(AppRouteNames.onBoarding);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(OnBoardingScreen), findsOneWidget);
    });

    testWidgets(
        'Should show [PageNotFoundScreen] when navigating to an invalid path',
        (tester) async {
      // Arrange
      final router = appRouter.router();

      // Act
      await pumpRouter(tester, router);
      router.go('/invalid_path');
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(PageNotFoundScreen), findsOneWidget);
    });
  });
}
