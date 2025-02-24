import 'package:book_lover/core/errors/exceptions.dart';
import 'package:book_lover/core/errors/failures.dart';
import 'package:book_lover/core/utils/type_defs.dart';
import 'package:book_lover/features/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:book_lover/features/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Repository:
/// - Acts as an intermediary between the data source and the domain layer.
/// - Uses `ResultFuture` (a `Future` of `Either<Failure, T>`) to:
///   - Provide a unified way to handle errors across the application.
///   - Abstract low-level exceptions (e.g., `CacheException`) and map them to
///     domain-specific failures (e.g., `CacheFailure`).
/// - Responsible for combining data from multiple sources (if needed) and
///   ensuring that only clean, business-ready data is passed to
///   the domain layer.
/// - Enhances testability and modularity by decoupling the domain layer from
///   implementation details.

@LazySingleton(as: OnBoardingRepo)
class OnBoardingRepoImpl implements OnBoardingRepo {
  const OnBoardingRepoImpl(this._localDataSource);

  final OnBoardingLocalDataSource _localDataSource;

  @override
  ResultFutureVoid cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  Result<bool> checkIfUserIsFirstTimer() {
    try {
      final result = _localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}
