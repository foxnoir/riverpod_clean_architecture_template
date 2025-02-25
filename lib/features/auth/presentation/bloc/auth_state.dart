part of 'auth_bloc.dart';

/// BLoC State Classes
///
/// Defines the possible states for the BLoC using a sealed class hierarchy.
/// Sealed classes ensure type safety by limiting states to predefined options.
/// Each state represents a specific application state
/// (e.g., loading, success, error).

sealed class AuthState extends Equatable {
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
  const UsersLoaded(this.users);

  final List<User> users;

  @override

  /// creates list from all users in [List<User> users]
  /// then checks against next user state id if they're equal
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
