import 'dart:async';
import 'package:book_dragon/core/di/di.dart';
import 'package:book_dragon/core/log/logger.dart';
import 'package:book_dragon/core/router/app_router.dart';
import 'package:book_dragon/core/theme/theme.dart';
import 'package:book_dragon/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _loadApp();
  }, (Object error, StackTrace stack) {
    logger.info('zone error $error');
  });
}

Future<void> _loadApp() async {
  try {
    await DI.getIt.reset();

    await configureInjection(Environment.dev);
    runApp(ProviderScope(child: BookDragon()));
  } catch (ex, st) {
    logger.error('startup exception', error: ex, stackTrace: st);
  }
}

class BookDragon extends ConsumerWidget {
  factory BookDragon() => instance;
  const BookDragon._internal();

  static const BookDragon instance = BookDragon._internal();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          if (locale == null) return const Locale('en', '');
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
          return const Locale('en', '');
        },
        theme: getLightTheme(),
      ),
    );
  }
}
