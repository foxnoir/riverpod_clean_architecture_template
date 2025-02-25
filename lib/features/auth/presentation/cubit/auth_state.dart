part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class CreatingUser extends AuthState {
  const CreatingUser();
}

final class GettingUsers extends AuthState {
  const GettingUsers();
}

final class UserCreated extends AuthState {
  const UserCreated();
}

class UsersLoaded extends AuthState {
  const UsersLoaded({required this.users});

  final List<User> users;

  @override

  /// creates list from all users in [List<User> users]
  /// then checks against next user state id if they're equal
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthError extends AuthState {
  const AuthError({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}
