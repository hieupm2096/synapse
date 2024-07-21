import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prompt_model.g.dart';

@JsonSerializable()
@collection
@Name('prompt')
class PromptModel {
  const PromptModel({
    this.id,
    this.conversationId,
    this.createdBy,
    this.text,
    this.repliedId,
    this.createdAt,
    this.isHuman,
  });

  factory PromptModel.fromJson(Map<String, dynamic> json) =>
      _$PromptModelFromJson(json);

  final Id? id;
  final int? conversationId;
  final String? createdBy;
  final String? text;
  final String? repliedId;
  final DateTime? createdAt;
  final bool? isHuman;

  Map<String, dynamic> toJson() => _$PromptModelToJson(this);

  PromptModel copyWith({
    Id? id,
    int? conversationId,
    String? createdBy,
    String? text,
    String? repliedId,
    DateTime? createdAt,
    bool? isHuman,
  }) {
    return PromptModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      createdBy: createdBy ?? this.createdBy,
      text: text ?? this.text,
      repliedId: repliedId ?? this.repliedId,
      createdAt: createdAt ?? this.createdAt,
      isHuman: isHuman ?? this.isHuman,
    );
  }
}
