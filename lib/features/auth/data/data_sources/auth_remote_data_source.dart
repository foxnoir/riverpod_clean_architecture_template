import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:book_dragon/core/errors/exceptions.dart';
import 'package:book_dragon/core/network/api_config.dart';
import 'package:book_dragon/core/utils/type_defs.dart';
import 'package:book_dragon/features/auth/data/models/user_model.dart';

/// talks to server
/// catchs exception
///
/// there are differnt types of data sources
/// - remote data source (e.g. talks to local storage, local cache)
/// - data source from services (e.g. api calls)
///
/// is triggered if an unexpected error occurs (NO!!! APiExpetion, could be internal / dart / error etc),
/// this error is replaced by an ApiException
/// statusCode 505 then indicates an unexpected error
/// throw ApiException(message: e.toString(), statusCode: 505);

abstract class AuthRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);
  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final response = await _client.post(
        Uri.https(ApiConfig.kBaseUrl, ApiConfig.users),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      /// comment above
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.https(ApiConfig.kBaseUrl, ApiConfig.users),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map(UserModelMapper.fromMap)
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      /// comment above
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
