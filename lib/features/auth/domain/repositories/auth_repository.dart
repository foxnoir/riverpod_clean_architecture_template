import 'package:book_dragon/core/utils/type_defs.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Interface / contract what functions the feature has (not implementing
/// Domain layer is not directly dealing with Exceptions (clean architecture)
/// => uses dartz for seperating interfaces
///
/// defines methods

abstract class AuthRepository {
  const AuthRepository();

  ResultFutureVoid sendOTP({
    required String phoneNumber,
  });

  ResultFuture<UserCredential> verifyOTP({
    required String verificationId,
    required String otp,
  });
}
