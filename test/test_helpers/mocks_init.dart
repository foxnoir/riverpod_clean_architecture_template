// ignore_for_file: depend_on_referenced_packages

import 'package:book_dragon/core/di/di.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/di/di_test.dart';

class TestSettings {
  static Future<void> init() async {
    SharedPreferences.setMockInitialValues({});
    await DI.getIt.reset();
    await TestDI.getIt.reset();
    await configureTestInjection();
  }
}
