import 'package:book_lover/core/usecases/usecases.dart';
import 'package:book_lover/core/utils/type_defs.dart';
import 'package:book_lover/features/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() async => _repo.checkIfUserIsFirstTimer();
}
