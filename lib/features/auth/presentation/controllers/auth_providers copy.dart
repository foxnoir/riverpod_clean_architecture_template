// // ignore_for_file: use_setters_to_change_properties

// import 'package:book_dragon/features/auth/data/data_sources/auth_remote_data_source.dart';
// import 'package:book_dragon/features/auth/data/repositories/auth_repo_impl.dart';
// import 'package:book_dragon/features/auth/domain/repositories/auth_repository.dart';
// import 'package:book_dragon/features/auth/domain/usecases/send_otp.dart';
// import 'package:book_dragon/features/auth/domain/usecases/verify_otp.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'auth_providers.g.dart';

// @riverpod
// class CountryCode extends _$CountryCode {
//   @override
//   Country? build() => null;

//   void changeCountry(Country newCountry) {
//     state = newCountry;
//   }
// }

// // Data Source Provider
// final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
//   (ref) => AuthRemoteDataSourceImpl(authClient: FirebaseAuth.instance),
// );

// // Repository Provider
// final authRepositoryProvider = Provider<AuthRepository>(
//   (ref) => AuthRepositoryImpl(
//     ref.read(authRemoteDataSourceProvider),
//   ),
// );

// // Use Case Providers
// final sendOTPProvider = Provider<SendOTP>(
//   (ref) => SendOTP(repository: ref.read(authRepositoryProvider)),
// );

// final verifyOTPProvider = Provider<VerifyOTP>(
//   (ref) => VerifyOTP(repository: ref.read(authRepositoryProvider)),
// );
