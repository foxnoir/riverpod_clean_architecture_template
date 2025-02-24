import 'package:book_lover/core/errors/exceptions.dart';
import 'package:book_lover/features/storage/prefs.dart';
import 'package:injectable/injectable.dart';

/// Data Source:
/// - Responsible for low-level data operations, such as interacting with APIs,
///   databases, or local storage (e.g., SharedPreferences).
/// - Uses `Future` to return raw data or throw exceptions.
/// - Keeps the implementation simple and focused only on data access,
///   without handling errors or business logic.
/// - Error handling is deferred to higher layers (e.g., the repository).

abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();

  Future<void> cacheFirstTimer();

  bool checkIfUserIsFirstTimer();
}

@LazySingleton(as: OnBoardingLocalDataSource)
class OnBoardingLocalDataSrcImpl extends OnBoardingLocalDataSource {
  const OnBoardingLocalDataSrcImpl(this._prefs);

  final Prefs _prefs;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _prefs.setBool(key: PrefsKey.isFirstTimer, value: false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool checkIfUserIsFirstTimer() {
    try {
      return _prefs.getBool(key: PrefsKey.isFirstTimer, defaultValue: true);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
