import 'package:book_dragon/core/utils/type_defs.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();

  ResultFutureVoid cacheFirstTimer();

  Result<bool> checkIfUserIsFirstTimer();
}
