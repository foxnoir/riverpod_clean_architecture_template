import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_manager/core/errors/failures.dart';
import 'package:todo_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:todo_manager/features/auth/domain/usecases/create_user.dart';

import '../../../../test_helpers/mocks.mock.dart';

/// setUp runs before each test
///
/// thenThrow: Error Testing
/// thenReturn: when function is not async (we don't need to wait)
/// thenAnswer: when function is async
///
/// dartz: Right() => Success, Left() => Failure
/// right(null)) == void
///
/// equals is not always necessary, but often safer

Future<void> main() async {
  late AuthRepository repo;
  late CreateUser usecase;

  const params = CreateUserParams.empty();

  setUp(() {
    /// Initialize dependencies
    repo = MockAuthRepository();
    usecase = CreateUser(repo);
  });

  test(
    'Usecase CREATE_USER should call the [AuthRepo.createUser]',
    () async {
      /// Arrange
      when(
        () => repo.createUser(
          avatar: any(named: 'avatar'),
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      /// Act
      final result = await usecase(params: params);

      /// Assert
      expect(result, equals(const Right<Failure, void>(null)));

      /// Verify the method was called with expected arguments
      verify(
        () => repo.createUser(
          avatar: params.avatar,
          createdAt: params.createdAt,
          name: params.name,
        ),
      ).called(1);

      /// Verify there were no other interactions
      verifyNoMoreInteractions(repo);
    },
  );
}
