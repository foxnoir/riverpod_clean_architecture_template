import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_manager/core/errors/failures.dart';
import 'package:todo_manager/features/auth/domain/usecases/create_user.dart';
import 'package:todo_manager/features/auth/domain/usecases/get_users.dart';
import 'package:todo_manager/features/auth/presentation/cubit/auth_cubit.dart';

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
///
/// use Right<dynamic>, if right side doesn't matter for test

Future<void> main() async {
  late CreateUser createUser;
  late GetUsers getUsers;
  late AuthCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  final tApiFailure = ApiFailure(message: 'message', statusCode: 400);

  setUp(() {
    /// Initialize dependencies
    createUser = MockCreateUser();
    getUsers = MockGetUsers();
    cubit = AuthCubit(getUsers: getUsers, createUser: createUser);
    registerFallbackValue(tCreateUserParams);
  });

  /// after each test the bloc should be "destroyed"
  tearDown(() => cubit.close());

  test('AuthCubit initial state should be [AuthInitial]', () async {
    expect(cubit.state, const AuthInitial());
  });

  group('AuthCubit createUser', () {
    /// successful test
    blocTest<AuthCubit, AuthState>(
      'should emit [CreatingUser, UserCreated] when successful',
      build: () {
        when(() => createUser(params: any(named: 'params'))).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),

      /// list of states we expecting to emit
      expect: () => const [
        CreatingUser(),
        UserCreated(),
      ],
      verify: (_) {
        verify(() => createUser(params: tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );

    /// error
    blocTest<AuthCubit, AuthState>(
      'should emit [CreatingUser, AuthError] when unsuccessful',
      build: () {
        when(() => createUser(params: any(named: 'params'))).thenAnswer(
          (_) async => Left(tApiFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),

      /// list of states we expecting to emit
      expect: () => [
        const CreatingUser(),
        AuthError(message: tApiFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => createUser(params: tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });
  group('AuthCubit getUsers', () {
    /// successful test
    blocTest<AuthCubit, AuthState>(
      'should emit [GettingUsers, UsersLoaded] when successful',
      build: () {
        when(() => getUsers()).thenAnswer(
          (_) async => const Right([]),
        );
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),

      /// list of states we expecting to emit
      expect: () => [
        const GettingUsers(),
        const UsersLoaded(users: []),
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    /// error
    blocTest<AuthCubit, AuthState>(
      'should emit [GettingUsers, AuthError] when unsuccessful',
      build: () {
        when(() => getUsers()).thenAnswer(
          (_) async => Left(tApiFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),

      /// list of states we expecting to emit
      expect: () => [
        const GettingUsers(),
        AuthError(message: tApiFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
