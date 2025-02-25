import 'package:book_dragon/core/router/app_router.dart';
import 'package:book_dragon/core/router/app_router_names.dart';
import 'package:book_dragon/core/router/page_not_found_screen.dart';
import 'package:book_dragon/features/auth/presentation/views/sign_up_screen.dart';
import 'package:book_dragon/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../test_helpers/mocks_init.dart';
import '../di/di_test.dart';

void main() {
  late AppRouter appRouter;

  setUp(() async {
    await TestSettings.init();
    appRouter = TestDI.getIt<AppRouter>();
  });

  Future<void> pumpRouter(WidgetTester tester, GoRouter router) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }

  group('AppRouter Tests', () {
    testWidgets('Navigiert zu [OnBoardingScreen] für initiale Route',
        (tester) async {
      final router = appRouter.router;
      await pumpRouter(tester, router);
      await tester.pumpAndSettle();
      expect(find.byType(OnBoardingScreen), findsOneWidget);
    });

    testWidgets('Zeigt [OnBoardingScreen] wenn Route [/onBoarding] ist',
        (tester) async {
      final router = appRouter.router;
      await pumpRouter(tester, router);
      router.go(AppRouteNames.onBoarding);
      await tester.pumpAndSettle();
      expect(find.byType(OnBoardingScreen), findsOneWidget);
    });

    testWidgets('Zeigt [PageNotFoundScreen] für ungültige Route',
        (tester) async {
      final router = appRouter.router;
      await pumpRouter(tester, router);
      router.go('/invalid_path');
      await tester.pumpAndSettle();
      expect(find.byType(PageNotFoundScreen), findsOneWidget);
    });

    testWidgets('Navigiert zu [SignUpScreen] von [OnBoardingScreen]',
        (tester) async {
      final router = appRouter.router;
      await pumpRouter(tester, router);
      router.go('${AppRouteNames.onBoarding}${AppRouteNames.signUp}');
      await tester.pumpAndSettle();
      expect(find.byType(SignUpScreen), findsOneWidget);
    });
  });
}
