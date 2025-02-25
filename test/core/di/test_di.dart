import 'package:book_dragon/core/di/di.config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

class TestDI {
  static final GetIt getIt = GetIt.I;
}

@InjectableInit(generateForDir: ['test', 'lib'])
Future<void> configureTestInjection() async {
  await TestDI.getIt.init(environment: Environment.test);
}
