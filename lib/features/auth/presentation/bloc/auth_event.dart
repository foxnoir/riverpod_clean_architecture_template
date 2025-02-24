part of 'auth_bloc.dart';

/// BLoC Event Classes
///
/// Uses `sealed` to ensure all event subclasses are within the same file,
/// enhancing clarity and ensuring no external extension of events.

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  /// if an other event doesn't have any props, it will be like this:
  /// => we don't need to override the props again
  @override
  List<Object> get props => [];
}

final class CreateUserEvent extends AuthEvent {
  const CreateUserEvent({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object> get props => [createdAt, name, avatar];
}

final class GetUsersEvent extends AuthEvent {
  const GetUsersEvent();
}
