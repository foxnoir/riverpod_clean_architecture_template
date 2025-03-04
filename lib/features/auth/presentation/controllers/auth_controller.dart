// ignore_for_file: use_setters_to_change_properties

import 'package:book_dragon/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:book_dragon/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:book_dragon/features/auth/domain/repositories/auth_repository.dart';
import 'package:book_dragon/features/auth/domain/usecases/send_otp.dart';
import 'package:book_dragon/features/auth/domain/usecases/verify_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:book_dragon/features/auth/presentation/states/auth_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() => const AuthState.initial();

  Future<void> sendOtp(String phoneNumber) async {
    state = const AuthState.loading();
    final sendOTP = ref.read(sendOTPProvider);
    final result =
        await sendOTP(params: SendOTPParams(phoneNumber: phoneNumber));
    state = result.fold(
      (failure) => const AuthState.error('Error sending OTP'),
      (_) => const AuthState.otpSent(),
    );
  }

  Future<void> verifyOtp(String verificationId, String otp) async {
    state = const AuthState.loading();
    final verifyOTP = ref.read(verifyOTPProvider);
    final result = await verifyOTP(
        params: VerifyOTPParams(verificationId: verificationId, otp: otp));
    state = result.fold(
      (failure) => AuthState.error(failure.message),
      (_) => const AuthState.verified(),
    );
  }
}

// AuthState Provider
final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

// Data Source Provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(authClient: FirebaseAuth.instance),
);

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
  ),
);

// Use Case Providers
final sendOTPProvider = Provider<SendOTP>(
  (ref) => SendOTP(repository: ref.read(authRepositoryProvider)),
);

final verifyOTPProvider = Provider<VerifyOTP>(
  (ref) => VerifyOTP(repository: ref.read(authRepositoryProvider)),
);
