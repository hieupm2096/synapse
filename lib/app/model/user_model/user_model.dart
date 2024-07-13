import 'package:isar/isar.dart';
import 'package:synapse/core/extension/isar_ext.dart';

part 'user_model.g.dart';

@collection
@Name('user')
final class UserModel {
  const UserModel({
    required this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;

  Id? get isarId => id?.fastHash;

  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
