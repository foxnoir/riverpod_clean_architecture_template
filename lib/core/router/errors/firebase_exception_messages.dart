import 'package:book_dragon/core/router/errors/exception_messages.dart';
import 'package:book_dragon/core/router/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthExceptionMapper {
  static ApiException mapFirebaseException(FirebaseException e) {
    return ApiException(
      message: e.message ?? FirebaseExceptionMessages.getMessage(e.code),
      statusCode: e.code,
    );
  }
}

class StatusCode {
  static const String unexpectedError = 'unexpected_error';
  static const String userNotFound = 'user_not_found';
  static const String userAlreadyExists = 'user_already_exists';
  static const String invalidCredentials = 'invalid_credentials';
  static const String operationFailed = 'operation_failed';
  static const String tooManyRequests = 'too_many_requests';
  static const String userDataInitFailed = 'user_data_initialization_failed';
  static const String insufficientPermission = 'Insufficient Permission';
}

class FirebaseAuthExceptionCodes {
  static const String userNotFound = 'user-not-found';
  static const String wrongPassword = 'wrong-password';
  static const String invalidEmail = 'invalid-email';
  static const String userDisabled = 'user-disabled';
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String tooManyRequests = 'too-many-requests';
}

class FirebaseExceptionMessages {
  static const Map<String, ExceptionType> exceptionMapping = {
    FirebaseAuthExceptionCodes.userNotFound: ExceptionType.userNotFound,
    FirebaseAuthExceptionCodes.wrongPassword: ExceptionType.invalidCredentials,
    FirebaseAuthExceptionCodes.invalidEmail: ExceptionType.invalidInput,
    FirebaseAuthExceptionCodes.userDisabled: ExceptionType.userNotFound,
    FirebaseAuthExceptionCodes.emailAlreadyInUse:
        ExceptionType.userAlreadyExists,
    FirebaseAuthExceptionCodes.operationNotAllowed:
        ExceptionType.operationFailed,
    FirebaseAuthExceptionCodes.tooManyRequests: ExceptionType.tooManyRequests,
  };

  static String getMessage(String code) {
    return ExceptionMessage.getMessage(
      exceptionMapping[code] ?? ExceptionType.unhandledException,
    );
  }
}
