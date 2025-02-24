import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:todo_manager/core/errors/exceptions.dart';
import 'package:todo_manager/core/network/api_config.dart';
import 'package:todo_manager/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:todo_manager/features/auth/data/models/user_model.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../test_helpers/test_response_messages.dart';

class MockClient extends Mock implements http.Client {}

Future<void> main() async {
  late MockClient client;
  late AuthRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('AUTH_REMOTE_DATA_SOURCE_IMPL createUser', () {
    test(
      'should complete successfully when status code IS 200 or 201',
      () async {
        /// Arrange
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async =>
              http.Response(TestResponseMessages.userCreatedSuccessfully, 201),
        );

        /// Act
        final methodCall = remoteDataSource.createUser;

        /// Assert
        expect(
          methodCall(
            createdAt: 'empty.createdAt',
            name: 'empty.name',
            avatar: 'empty.avatar',
          ),
          completes,
        );

        verify(
          () => client.post(
            Uri.https(ApiConfig.kBaseUrl, ApiConfig.users),
            body: jsonEncode({
              'createdAt': 'empty.createdAt',
              'name': 'empty.name',
              'avatar': 'empty.avatar',
            }),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [ApiException] when status code is NOT 200 or 201',
      () async {
        /// Arrange
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(TestResponseMessages.invalidEmail, 400),
        );

        /// Act
        final methodCall = remoteDataSource.createUser;

        /// Assert
        /// we want the higher ordered method to call the method
        expect(
          () async => methodCall(
            createdAt: 'empty.createdAt',
            name: 'empty.name',
            avatar: 'empty.avatar',
          ),
          throwsA(
            const ApiException(
              message: TestResponseMessages.invalidEmail,
              statusCode: 400,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.https(ApiConfig.kBaseUrl, ApiConfig.users),
            body: jsonEncode({
              'createdAt': 'empty.createdAt',
              'name': 'empty.name',
              'avatar': 'empty.avatar',
            }),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [ApiException] with statusCode 505 on unexpected error',
      () async {
        /// Arrange
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenThrow(
          Exception(TestResponseMessages.unexpectedError),
        );

        /// Act
        final methodCall = remoteDataSource.createUser;

        /// Assert
        expect(
          () => methodCall(
            createdAt: 'empty.createdAt',
            name: 'empty.name',
            avatar: 'empty.avatar',
          ),
          throwsA(
            isA<ApiException>()
                .having(
                  (e) =>
                      e.message.contains(TestResponseMessages.unexpectedError),
                  'message',
                  true,
                )
                .having((e) => e.statusCode, 'statusCode', 505),
          ),
        );

        /// Verify
        verify(
          () => client.post(
            Uri.https(ApiConfig.kBaseUrl, ApiConfig.users),
            body: jsonEncode({
              'createdAt': 'empty.createdAt',
              'name': 'empty.name',
              'avatar': 'empty.avatar',
            }),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('AUTH_REMOTE_DATA_SOURCE_IMPL getUsers', () {
    final tJson = jsonDecode(fixture('users.json')) as List<dynamic>;

    test(
      'should return [List<UserModel>] when API call is successful '
      'and status code is 200',
      () async {
        /// Arrange
        when(
          () => client.get(
            any(),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer(
          (_) async => http.Response(jsonEncode(tJson), 200),
        );

        /// Act
        final result = await remoteDataSource.getUsers();
        final expectedResult = tJson
            .map(
              (user) => UserModelMapper.fromMap(user as Map<String, dynamic>),
            )
            .toList();

        /// Assert
        expect(result, equals(expectedResult));
        verify(
          () => client.get(
            Uri.https(ApiConfig.kBaseUrl, ApiConfig.users),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [ApiException] when status code is not 200',
      () async {
        /// Arrange
        when(
          () => client.get(
            any(),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer(
          (_) async =>
              http.Response(TestResponseMessages.serverUnavailable, 500),
        );

        /// Act
        final methodCall = remoteDataSource.getUsers;

        /// Assert
        /// we want the higher ordered method to call the method
        expect(
          () async => methodCall(),
          throwsA(
            const ApiException(
              message: TestResponseMessages.serverUnavailable,
              statusCode: 500,
            ),
          ),
        );
        verify(
          () => client.get(
            Uri.https(ApiConfig.kBaseUrl, ApiConfig.users),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [ApiException] with statusCode 505 on unexpected error',
      () async {
        /// Arrange
        when(
          () => client.get(
            any(),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenThrow(
          Exception(TestResponseMessages.unexpectedError),
        );

        /// Act
        final methodCall = remoteDataSource.getUsers;

        /// Assert
        expect(
          methodCall,
          throwsA(
            isA<ApiException>()
                .having(
                  (e) =>
                      e.message.contains(TestResponseMessages.unexpectedError),
                  'message',
                  true,
                )
                .having((e) => e.statusCode, 'statusCode', 505),
          ),
        );

        /// Verify
        verify(
          () => client.get(
            any(),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
