import 'package:book_lover/core/usecases/usecases.dart';
import 'package:book_lover/core/utils/type_defs.dart';
import 'package:book_lover/features/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CacheFirstTimer extends UsecaseWithoutParams<void> {
  const CacheFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFutureVoid call() async => _repo.cacheFirstTimer();
}
