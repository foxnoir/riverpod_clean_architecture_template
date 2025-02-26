import 'package:book_dragon/core/errors/exceptions.dart';
import 'package:book_dragon/core/errors/firebase_exception_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  Future<void> sendOTP({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
  });

  Future<UserCredential> verifyOTP({
    required String verificationId,
    required String otp,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
  }) : _authClient = authClient;

  final FirebaseAuth _authClient;

  @override
  Future<void> sendOTP({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
  }) async {
    try {
      await _authClient.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          verificationCompleted(credential);
        },
        verificationFailed: (FirebaseAuthException exception) {
          verificationFailed(exception);
        },
        codeSent: (String verificationId, int? resendToken) {
          codeSent(verificationId, resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          codeAutoRetrievalTimeout(verificationId);
        },
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionMapper.mapFirebaseException(e);
    } catch (e, s) {
      /// print links to where the error occured
      debugPrintStack(stackTrace: s);
      throw ApiException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<UserCredential> verifyOTP({
    required String verificationId,
    required String otp,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      return _authClient.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionMapper.mapFirebaseException(e);
    } catch (e, s) {
      /// print links to where the error occured
      debugPrintStack(stackTrace: s);
      throw ApiException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
