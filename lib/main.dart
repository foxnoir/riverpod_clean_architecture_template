import 'dart:async';

import 'package:book_lover/core/di/di.dart';
import 'package:book_lover/core/log/logger.dart';
import 'package:book_lover/core/router/app_router.dart';
import 'package:book_lover/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _loadApp();
  }, (Object error, StackTrace stack) {
    logger.info('zone error $error');
  });
}

Future<void> _loadApp() async {
  try {
    await DI.getIt.reset();
    DI.getIt.registerSingleton<bool>(false);
    await configureInjection(Environment.dev);
    runApp(BookLover());
  } catch (ex, st) {
    logger.error('startup exception', error: ex, stackTrace: st);
  }
}

class BookLover extends StatelessWidget {
  factory BookLover() => instance;
  const BookLover._internal();

  static const BookLover instance = BookLover._internal();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: appRouter.routeInformationParser,
        routeInformationProvider: appRouter.routeInformationProvider,
        routerDelegate: appRouter.routerDelegate,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          if (locale == null) {
            return const Locale('en', '');
          }
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
          return const Locale('en', '');
        },
        // TODO(locale-handling): write better clear logic
        /// locale: DI.getIt<SettingsRepository>().locale,
        theme: getLightTheme(),
      ),
    );
  }
}
