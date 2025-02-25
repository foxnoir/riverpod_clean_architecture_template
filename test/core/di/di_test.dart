import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_test.config.dart';

class TestDI {
  static final GetIt getIt = GetIt.I;
}

@InjectableInit(generateForDir: ['test', 'lib'])
Future<void> configureTestInjection() async {
  TestDI.getIt.registerSingleton<bool>(true, instanceName: 'isRouteTesting');
  await TestDI.getIt.init(environment: Environment.test);
}
