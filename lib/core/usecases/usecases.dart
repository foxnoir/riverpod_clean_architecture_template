// ignore_for_file: one_member_abstracts

import 'package:todo_manager/core/utils/type_defs.dart';

/// every usecase follows this pattern
///
/// in flutter call() exits in almost every class / function
/// With call() you can call a class instance like a function.
///
/// we don't want to write UseCase.createUser()
/// so we make it a callable object

abstract class UsecaseWithParams<T, Params> {
  const UsecaseWithParams();

  ResultFuture<T> call({required Params params});
}

abstract class UsecaseWithoutParams<T> {
  const UsecaseWithoutParams();

  ResultFuture<T> call();
}
