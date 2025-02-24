import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:riverpod_app/core/errors/exceptions.dart';
import 'package:riverpod_app/core/errors/failures.dart';
import 'package:riverpod_app/core/utils/type_defs.dart';
import 'package:riverpod_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:riverpod_app/features/auth/domain/entities/user.dart';
import 'package:riverpod_app/features/auth/domain/repositories/auth_repository.dart';

/// talks to datasource
/// gets result/exception returns result/failure
/// implements methods
///
/// Repository handles the communication between the domain and
/// data layers. It retrieves data from the remote data source, handles
/// exceptions, and returns clean domain entities (User).

@LazySingleton(as: AuthRepository)
class AuthRepoImpl implements AuthRepository {
  const AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFutureVoid createUser({
    required String avatar,
    required String createdAt,
    required String name,
  }) async {
    try {
      await _remoteDataSource.createUser(
        avatar: avatar,
        createdAt: createdAt,
        name: name,
      );
      return const Right(null);
    } on ApiException catch (e) {
      return Left<ApiFailure, List<User>>(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      return Right(await _remoteDataSource.getUsers());
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
