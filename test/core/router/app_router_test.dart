// ignore_for_file: lines_longer_than_80_chars

import 'package:book_dragon/core/router/app_router.dart';
import 'package:book_dragon/core/router/app_router_names.dart';
import 'package:book_dragon/core/router/page_not_found_screen.dart';
import 'package:book_dragon/features/auth/presentation/views/auth_screen.dart';
import 'package:book_dragon/features/auth/presentation/views/otp_verification_screen.dart';
import 'package:book_dragon/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  late GoRouter router;

  setUp(() {
    router = AppRouter.router;
  });

  Future<void> pumpRouter(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp.router(
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    );
  }

  group('AppRouter Tests', () {
    testWidgets('Navigiert zu OnBoardingScreen für initiale Route',
        (tester) async {
      await pumpRouter(tester);
      await tester.pumpAndSettle();
      expect(find.byType(OnBoardingScreen), findsOneWidget);
    });

    testWidgets('Navigiert zu AuthScreen von OnBoardingScreen', (tester) async {
      await pumpRouter(tester);

      router.go('${AppRouteNames.onBoarding}${AppRouteNames.auth}');
      await tester.pumpAndSettle();
      expect(find.byType(AuthScreen), findsOneWidget);
    });

    testWidgets('Navigiert zu OTPScreen von AuthScreen', (tester) async {
      await pumpRouter(tester);

      router.go(
        '${AppRouteNames.onBoarding}${AppRouteNames.auth}${AppRouteNames.otp}?verification_Id=1234',
      );
      await tester.pumpAndSettle();
      expect(find.byType(OTPVerificationScreen), findsOneWidget);
    });

    testWidgets('Zeigt PageNotFoundScreen für ungültige Route', (tester) async {
      await pumpRouter(tester);
      router.go('/invalid_path');
      await tester.pumpAndSettle();
      expect(find.byType(PageNotFoundScreen), findsOneWidget);
    });
  });
}
