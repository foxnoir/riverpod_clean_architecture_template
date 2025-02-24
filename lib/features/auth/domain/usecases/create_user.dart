import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_manager/core/usecases/usecases.dart';
import 'package:todo_manager/core/utils/type_defs.dart';
import 'package:todo_manager/features/auth/domain/repositories/auth_repository.dart';

/// depends on the repo and will call the repo's createUser method

@injectable
class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repo);

  final AuthRepository _repo;

  @override
  ResultFutureVoid call({required CreateUserParams params}) async =>
      _repo.createUser(
        avatar: params.avatar,
        createdAt: params.createdAt,
        name: params.name,
      );
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.avatar,
    required this.createdAt,
    required this.name,
  });

  /// for testing
  const CreateUserParams.empty()
      : this(
          avatar: 'empty.avatar',
          createdAt: 'empty.createdAt',
          name: 'empty.name',
        );

  final String avatar;
  final String createdAt;
  final String name;

  @override
  List<Object?> get props => [avatar, createdAt, name];
}
