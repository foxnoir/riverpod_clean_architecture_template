import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_app/core/errors/failures.dart';
import 'package:riverpod_app/features/auth/domain/entities/user.dart';
import 'package:riverpod_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_app/features/auth/domain/usecases/get_users.dart';

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
/// equals is always not necessary, often safer

Future<void> main() async {
  late AuthRepository repo;
  late GetUsers usecase;

  final tResponse = List<User>.empty();

  setUp(() {
    /// Initialize dependencies
    repo = MockAuthRepository();
    usecase = GetUsers(repo);
  });

  test(
    'Usecase GET_USERS should call the [AuthRepo.getUsers] '
    'and return a [List<User>]',
    () async {
      // Arrange
      /// that's what it should be
      when(
        () => repo.getUsers(),
      ).thenAnswer(
        (_) async => Right(tResponse),
      );

      // Act
      final result = await usecase();

      // Assert
      /// what we EXPECTED what it should be
      expect(result, equals(Right<Failure, List<User>>(tResponse)));

      /// verify if the function was called and was called only once
      verify(
        () => repo.getUsers(),
      ).called(1);

      /// verify if there are no more interactions
      verifyNoMoreInteractions(repo);
    },
  );
}
