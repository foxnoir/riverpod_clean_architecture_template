import 'package:book_lover/core/utils/type_defs.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();

  ResultFutureVoid cacheFirstTimer();

  Result<bool> checkIfUserIsFirstTimer();
}
