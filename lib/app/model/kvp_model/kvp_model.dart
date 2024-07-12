import 'package:isar/isar.dart';
import 'package:synapse/core/core.dart';

part 'kvp_model.g.dart';

@collection
@Name('kvp')
class KVPModel {
  const KVPModel({
    required this.key,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  final String key;

  Id get isarId => key.fastHash;

  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;

  KVPModel copyWith({
    String? key,
    String? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      KVPModel(
        key: key ?? this.key,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
