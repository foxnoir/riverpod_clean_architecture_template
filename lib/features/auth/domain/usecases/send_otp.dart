import 'package:book_dragon/core/utils/type_defs.dart';
import 'package:book_dragon/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

/// depends on the repo and will call the repo's createUser method

@injectable
class SendOTP {
  SendOTP({required this.repository});
  final AuthRepository repository;

  ResultFutureVoid call({required SendOTPParams params}) async {
    return repository.sendOTP(phoneNumber: params.phoneNumber);
  }
}

class SendOTPParams extends Equatable {
  const SendOTPParams({
    required this.phoneNumber,
  });

  /// for testing
  const SendOTPParams.empty()
      : this(
          phoneNumber: 'empty.phoneNumber',
        );

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}
