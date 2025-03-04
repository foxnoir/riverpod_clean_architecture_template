// ignore_for_file: use_setters_to_change_properties

import 'package:book_dragon/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:book_dragon/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:book_dragon/features/auth/domain/repositories/auth_repository.dart';
import 'package:book_dragon/features/auth/domain/usecases/send_otp.dart';
import 'package:book_dragon/features/auth/domain/usecases/verify_otp.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controllers.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> sendOTP(String phoneNumber) async {
    state = const AsyncLoading();
    final sendOTP = ref.read(sendOTPProvider);

    state = await AsyncValue.guard(() async {
      final result =
          await sendOTP(params: SendOTPParams(phoneNumber: phoneNumber));
      return result.fold(
        (failure) => failure.message,
        (_) => null,
      );
    });
  }

  Future<void> verifyOTP({
    required String verificationId,
    required String otp,
  }) async {
    state = const AsyncLoading();
    final verifyOTP = ref.read(verifyOTPProvider);

    state = await AsyncValue.guard(() async {
      final result = await verifyOTP(
        params: VerifyOTPParams(verificationId: verificationId, otp: otp),
      );
      return result.fold(
        (failure) => failure.message,
        (_) => null,
      );
    });
  }
}

@riverpod
class CountryCodeController extends _$CountryCodeController {
  @override
  Country? build() => null;

  void changeCountry(Country newCountry) {
    state = newCountry;
  }
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(authClient: FirebaseAuth.instance);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider));
}

@riverpod
SendOTP sendOTP(Ref ref) {
  return SendOTP(repository: ref.read(authRepositoryProvider));
}

@riverpod
VerifyOTP verifyOTP(Ref ref) {
  return VerifyOTP(repository: ref.read(authRepositoryProvider));
}
