import 'package:book_dragon/core/usecases/usecases.dart';
import 'package:book_dragon/core/utils/type_defs.dart';
import 'package:book_dragon/features/auth/domain/entities/user.dart';
import 'package:book_dragon/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// depends on the repo and will call the repo's getUsers method

@injectable
class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<List<User>> call() async => _repo.getUsers();
}
