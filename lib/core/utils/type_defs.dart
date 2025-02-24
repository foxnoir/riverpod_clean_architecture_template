import 'package:dartz/dartz.dart';
import 'package:todo_manager/core/errors/failures.dart';

/// short generetic name for types

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultFutureVoid = ResultFuture<void>;

typedef Result<T> = Either<Failure, T>;

typedef DataMap = Map<String, dynamic>;
