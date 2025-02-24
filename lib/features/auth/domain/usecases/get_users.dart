import 'package:injectable/injectable.dart';
import 'package:riverpod_app/core/usecases/usecases.dart';
import 'package:riverpod_app/core/utils/type_defs.dart';
import 'package:riverpod_app/features/auth/domain/entities/user.dart';
import 'package:riverpod_app/features/auth/domain/repositories/auth_repository.dart';

/// depends on the repo and will call the repo's getUsers method

@injectable
class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<List<User>> call() async => _repo.getUsers();
}
