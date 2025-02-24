import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_app/core/errors/exception_messages.dart';
import 'package:riverpod_app/core/errors/exceptions.dart';
import 'package:riverpod_app/core/errors/failures.dart';
import 'package:riverpod_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:riverpod_app/features/auth/data/models/user_model.dart';
import 'package:riverpod_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:riverpod_app/features/auth/domain/entities/user.dart';
import 'package:riverpod_app/features/auth/domain/repositories/auth_repository.dart';

/// when returning void use Future.value() for testing

class MockAuthRemoteDataSrc extends Mock implements AuthRemoteDataSource {}

Future<void> main() async {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepository repoImpl;

  setUp(() {
    /// Initialize dependencies
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthRepoImpl(remoteDataSource);
  });

  final tException = ApiException(
    message: ExceptionMessage.getMessage(ExceptionType.unknownError),
    statusCode: 500,
  );

  group('AUTH_REPO_IMPL createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    test(
      'should call [AuthRemoteDataSource.createUser] and '
      'return [void] when remote source call is successful',
      () async {
        ///  Arrange
        when(
          () => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          ),
        ).thenAnswer((_) async => Future.value());

        ///  Act
        final result = await repoImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        ///  Assert
        expect(result, equals(const Right<dynamic, void>(null)));

        /// check that remote source's createUser gets called with right data
        verify(
          () => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ApiFailure] when remote source call is unsuccessful',
      () async {
        //  arrange
        when(
          () => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          ),
        ).thenThrow(tException);

        ///  Act
        final result = await repoImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        ///  Assert
        expect(
          result,
          equals(
            Left<ApiFailure, void>(
              ApiFailure.fromException(tException),
            ),
          ),
        );

        /// check that remote source's createUser gets called with right data
        verify(
          () => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('AUTH_REPO_IMPL getUsers', () {
    final tListUsers = [UserModel.empty()];

    test(
      'should call [AuthRemoteDataSource.getUsers] and '
      'return a [List<User>] when remote source call is successful',
      () async {
        ///  Arrange
        when(
          () => remoteDataSource.getUsers(),
        ).thenAnswer((_) async => tListUsers);

        ///  Act
        final result = await repoImpl.getUsers();

        ///  Assert
        expect(result, equals(Right<dynamic, List<User>>(tListUsers)));

        /// check that remote source's getUsers gets called with right data
        verify(
          () => remoteDataSource.getUsers(),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ApiFailure] when remote source call is unsuccessful',
      () async {
        ///  Arrange
        when(
          () => remoteDataSource.getUsers(),
        ).thenThrow(tException);

        ///  Act
        final result = await repoImpl.getUsers();

        ///  Assert
        expect(
          result,
          equals(
            Left<ApiFailure, List<User>>(
              ApiFailure.fromException(tException),
            ),
          ),
        );

        /// check that remote source's getUsers gets called with right data
        verify(
          () => remoteDataSource.getUsers(),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
