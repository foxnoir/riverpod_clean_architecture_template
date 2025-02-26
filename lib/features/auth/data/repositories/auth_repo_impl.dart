import 'package:book_dragon/core/errors/exceptions.dart';
import 'package:book_dragon/core/errors/failures.dart';
import 'package:book_dragon/core/utils/type_defs.dart';
import 'package:book_dragon/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:book_dragon/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

/// talks to datasource
/// gets result/exception returns result/failure
/// implements methods
///
/// Repository handles the communication between the domain and
/// data layers. It retrieves data from the remote data source, handles
/// exceptions, and returns clean domain entities (User).

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFutureVoid sendOTP({required String phoneNumber}) async {
    try {
      await _remoteDataSource.sendOTP(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          await _remoteDataSource.verifyOTP(
            verificationId: credential.verificationId ?? '',
            otp: '',
          );
        },
        verificationFailed: (exception) {
          throw FirebaseAuthException(
            code: exception.code,
            message: exception.message,
          );
        },
        codeSent: (verificationId, _) {
          // Optional: Speichern der verificationId für die spätere Eingabe
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserCredential> verifyOTP({
    required String verificationId,
    required String otp,
  }) async {
    try {
      return Right(
        await _remoteDataSource.verifyOTP(
          verificationId: verificationId,
          otp: otp,
        ),
      );
    } on ApiException catch (e) {
      return Left<ApiFailure, UserCredential>(ApiFailure.fromException(e));
    }
  }
}
