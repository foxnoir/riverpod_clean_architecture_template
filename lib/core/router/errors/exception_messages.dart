enum ExceptionType {
  // HTTP Errors
  noInternetConnection,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  internalServerError,
  serviceUnavailable,
  gatewayTimeout,
  tooManyRequests,

  // Application Errors
  cacheError,
  invalidInput,
  userNotFound,
  userAlreadyExists,
  invalidCredentials,
  sessionExpired,
  operationFailed,
  dataIntegrityError,
  unhandledException,
  unknownError,
}

class ExceptionMessage {
  const ExceptionMessage._();

  static String getMessage(ExceptionType type) {
    switch (type) {
      case ExceptionType.noInternetConnection:
        return 'No internet connection';
      case ExceptionType.badRequest:
        return 'Bad request';
      case ExceptionType.unauthorized:
        return 'Unauthorized';
      case ExceptionType.forbidden:
        return 'Forbidden';
      case ExceptionType.notFound:
        return 'Not found';
      case ExceptionType.conflict:
        return 'Conflict';
      case ExceptionType.internalServerError:
        return 'Internal server error';
      case ExceptionType.serviceUnavailable:
        return 'Service unavailable';
      case ExceptionType.gatewayTimeout:
        return 'Gateway timeout';
      case ExceptionType.tooManyRequests:
        return 'Too many requests';
      case ExceptionType.cacheError:
        return 'Cache error';
      case ExceptionType.invalidInput:
        return 'Invalid input';
      case ExceptionType.userNotFound:
        return 'User not found';
      case ExceptionType.userAlreadyExists:
        return 'User already exists';
      case ExceptionType.invalidCredentials:
        return 'Invalid credentials';
      case ExceptionType.sessionExpired:
        return 'Session expired';
      case ExceptionType.operationFailed:
        return 'Operation failed';
      case ExceptionType.dataIntegrityError:
        return 'Data integrity error';
      case ExceptionType.unhandledException:
        return 'Unhandled exception';
      case ExceptionType.unknownError:
        return 'Unknown error occurred';
    }
  }
}
