import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';
import 'package:book_dragon/features/auth/domain/entities/user.dart';

part 'user_model.mapper.dart';

/// Data model for the entity.
///
/// This class is a data transfer object (DTO) used to fetch and
/// store user data from the remote data source. It implements the
/// User interface to ensure compatibility with the domain layer.
///
/// Responsibilities:
/// - Implements the domain's User interface.
/// - Provides serialization and deserialization logic.

@MappableClass()
class UserModel extends Equatable with User, UserModelMappable {
  const UserModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  factory UserModel.empty() => const UserModel(
        id: 'empty.id',
        name: 'empty.name',
        createdAt: 'empty.createdAt',
        avatar: 'empty.avatar',
      );

  @override
  final String id;
  @override
  final String name;
  @override
  final String createdAt;
  @override
  final String avatar;

  @override
  List<Object?> get props => [id, name, createdAt, avatar];
}
