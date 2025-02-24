import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_manager/core/di/di.config.dart';

// Method used to initialized the dependency injection. Called in main.
@InjectableInit(ignoreUnregisteredTypes: [])
Future<void> configureInjection(String env) => DI.getIt.init();

// Class to use GetIt for dependency injection.

// Singelton => only one instance for whole app
// i.e.: Shared Preferences
// Singelton vs LazySingelton: both Singletons.
// LazySingleton refers to a class whose resource will not be initialised until
// used for  1st time.

class DI {
  // map of all registered instances
  static final GetIt getIt = GetIt.I;
}

extension GetItSafe on GetIt {
  // if a class is already registered it unregisters is and registers a new
  // object and returns the old implementation
  // <T> = Generic types
  T? safeRegisterSingleton<T extends Object>(T impl) {
    T? old;
    if (DI.getIt.isRegistered<T>()) {
      old = DI.getIt<T>();
      DI.getIt.unregister<T>();
    }
    DI.getIt.registerSingleton<T>(impl);

    return old;
  }

  void safeUnregister<T extends Object>(T impl) {
    if (DI.getIt.isRegistered<T>(instance: impl)) {
      DI.getIt.unregister<T>(instance: impl);
    }
  }
}
