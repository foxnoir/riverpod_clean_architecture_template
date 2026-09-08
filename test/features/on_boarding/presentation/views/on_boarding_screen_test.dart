import 'package:book_dragon/core/router/app_router.dart';
import 'package:book_dragon/features/auth/presentation/views/auth_screen.dart';
import 'package:book_dragon/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_dragon/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../test_helpers/localization_mock.dart';

void main() {
  late GoRouter router;

  setUpAll(() async {
    router = AppRouter.router;
  });

  Future<void> pumpScreen(WidgetTester tester, GoRouter router) async {
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
            locale: const Locale('en'),
          ),
        ),
      ),
    );
  }

  group('OnBoardingScreen Navigation Tests', () {
    testWidgets('navigates to [AuthScreen] when [Get Started] is pressed',
        (tester) async {
      final appLocalizations = await getLocalizations(tester);

      await pumpScreen(tester, router);
      await tester.pumpAndSettle();

      expect(find.byType(OnBoardingScreen), findsOneWidget);

      final getStartedButton = find.text(appLocalizations.getStarted);
      await tester.ensureVisible(getStartedButton);
      await tester.tap(getStartedButton);
      await tester.pumpAndSettle();

      expect(find.byType(AuthScreen), findsOneWidget);
    });
  });
}
