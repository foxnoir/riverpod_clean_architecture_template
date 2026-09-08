import 'package:book_dragon/core/router/errors/failures.dart';
import 'package:dartz/dartz.dart';

/// short generetic name for types

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultFutureVoid = ResultFuture<void>;

typedef Result<T> = Either<Failure, T>;

typedef DataMap = Map<String, dynamic>;
