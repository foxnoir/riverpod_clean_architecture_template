import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:riverpod_app/core/di/di.dart';
import 'package:riverpod_app/core/log/logger.dart';
import 'package:riverpod_app/core/router/app_router.dart';
import 'package:riverpod_app/core/theme/theme.dart';

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
    await configureInjection(Environment.dev);
    runApp(TemplateApp());
  } catch (ex, st) {
    logger.error('startup exception', error: ex, stackTrace: st);
  }
}

class TemplateApp extends StatelessWidget {
  factory TemplateApp() => instance;
  const TemplateApp._internal();

  static const TemplateApp instance = TemplateApp._internal();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      routerDelegate: appRouter.routerDelegate,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      theme: getLightTheme(),
    );
  }
}
