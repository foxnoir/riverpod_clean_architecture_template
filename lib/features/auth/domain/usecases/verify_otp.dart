import 'package:book_dragon/core/utils/type_defs.dart';
import 'package:book_dragon/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

/// depends on the repo and will call the repo's getUsers method

@injectable
class VerifyOTP {
  VerifyOTP({required this.repository});
  final AuthRepository repository;

  ResultFutureVoid call({required VerifyOTPParams params}) async {
    return repository.verifyOTP(
      verificationId: params.verificationId,
      otp: params.otp,
    );
  }
}

class VerifyOTPParams extends Equatable {
  const VerifyOTPParams({
    required this.verificationId,
    required this.otp,
  });

  /// for testing
  const VerifyOTPParams.empty()
      : this(
          verificationId: 'empty.verificationId',
          otp: 'empty.otp',
        );

  final String verificationId;
  final String otp;

  @override
  List<Object?> get props => [verificationId, otp];
}
