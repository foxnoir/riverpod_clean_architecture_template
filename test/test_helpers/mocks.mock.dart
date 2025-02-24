import 'package:bloc_test/bloc_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:riverpod_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_app/features/auth/domain/usecases/create_user.dart';
import 'package:riverpod_app/features/auth/domain/usecases/get_users.dart';
import 'package:riverpod_app/features/auth/presentation/cubit/auth_cubit.dart';

/// mock only dependencies, not classes you wanna test

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockClient extends Mock implements http.Client {}

class MockCreateUser extends Mock implements CreateUser {}

class MockGetUsers extends Mock implements GetUsers {}

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

class FakeAuthState extends Fake implements AuthState {}
