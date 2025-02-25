import 'package:book_dragon/core/router/app_router.dart';
import 'package:book_dragon/features/auth/presentation/views/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/test_di.dart';
import '../../../../test_helpers/localization_mock.dart';
import '../../../../test_helpers/mocks_init.dart';

void main() {
  late AppRouter appRouter;

  setUp(() async {
    await TestSettings.init();
    appRouter = TestDI.getIt<AppRouter>();
  });

  Future<void> pumpScreen(WidgetTester tester, GoRouter router) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
        ),
      ),
    );
  }

  group('OnBoardingScreen Navigation Tests', () {
    testWidgets('navigates to [SignUpScreen] when [Get Started] is pressed',
        (tester) async {
      // Arrange
      final appLocalizations = await getLocalizations(tester);
      final router = appRouter.router;
      await pumpScreen(tester, router);

      // Act
      final getStartedButton = find.text(appLocalizations.getStarted);
      await tester.ensureVisible(getStartedButton);
      await tester.pumpAndSettle();

      await tester.tap(getStartedButton);
      await tester.pump();
      await tester.pumpAndSettle();

      /// Assert
      expect(find.byType(SignUpScreen), findsOneWidget);
    });
  });
}
