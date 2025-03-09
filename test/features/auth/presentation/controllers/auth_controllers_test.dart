import 'package:book_dragon/features/auth/domain/usecases/send_otp.dart';
import 'package:book_dragon/core/errors/failures.dart';
import 'package:book_dragon/features/auth/domain/usecases/verify_otp.dart';
import 'package:book_dragon/features/auth/presentation/controllers/auth_controllers.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';

class MockSendOTP extends Mock implements SendOTP {}

class MockVerifyOTP extends Mock implements VerifyOTP {}

class FakeSendOTPParams extends Fake implements SendOTPParams {}

class FakeVerifyOTPParams extends Fake implements VerifyOTPParams {}

void main() {
  late ProviderContainer container;
  late MockSendOTP mockSendOTP;
  late MockVerifyOTP mockVerifyOTP;
  late AuthController authController;

  setUpAll(() {
    registerFallbackValue(FakeSendOTPParams());
    registerFallbackValue(FakeVerifyOTPParams());
  });

  setUp(() {
    mockSendOTP = MockSendOTP();
    mockVerifyOTP = MockVerifyOTP();
    container = ProviderContainer(
      overrides: [
        sendOTPProvider.overrideWithValue(mockSendOTP),
        verifyOTPProvider.overrideWithValue(mockVerifyOTP),
      ],
    );
    authController = container.read(authControllerProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthController Tests', () {
    test('sendOTP sets state to loading and then handles success', () async {
      when(() => mockSendOTP(params: any(named: 'params')))
          .thenAnswer((_) async => const Right(null));

      final future = authController.sendOTP('+49123456789');
      expect(authController.state, isA<AsyncLoading<dynamic>>());
      await future;
      expect(authController.state, isA<AsyncData<dynamic>>());
    });
  });
}
