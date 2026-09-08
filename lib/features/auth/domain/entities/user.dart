import 'package:equatable/equatable.dart';

/// Core business entity that represents a User.
///
/// The User entity is independent of external libraries or APIs and
/// is used to communicate across the domain and application layers.
/// It defines the common attributes and behaviors of a user.

mixin User on Equatable {
  String get id;
  String get name;
  String get createdAt;
  String get avatar;

  @override
  List<Object?> get props => [id, name, createdAt, avatar];
}
