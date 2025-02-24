import 'package:todo_manager/core/utils/type_defs.dart';
import 'package:todo_manager/features/auth/domain/entities/user.dart';

/// Interface / contract what functions the feature has (not implementing
/// Domain layer is not directly dealing with Exceptions (clean architecture)
/// => uses dartz for seperating interfaces
///
/// defines methods

abstract class AuthRepository {
  const AuthRepository();

  ResultFutureVoid createUser({
    required String avatar,
    required String createdAt,
    required String name,
  });

  ResultFuture<List<User>> getUsers();
}
