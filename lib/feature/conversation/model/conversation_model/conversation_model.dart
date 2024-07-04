import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation_model.g.dart';

@JsonSerializable()
@collection
@Name('conversation')
class ConversationModel {
  const ConversationModel({
    this.id,
    this.title,
    this.createdBy,
    this.llmId,
    this.createdAt,
    this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  final Id? id;
  final String? title;
  final String? createdBy;
  final String? llmId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);

  ConversationModel copyWith({
    Id? id,
    String? title,
    String? createdBy,
    String? llmId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdBy: createdBy ?? this.createdBy,
      llmId: llmId ?? this.llmId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
