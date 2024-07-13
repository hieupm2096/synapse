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
  });

  factory PromptModel.fromJson(Map<String, dynamic> json) =>
      _$PromptModelFromJson(json);

  final Id? id;
  final int? conversationId;
  final String? createdBy;
  final String? text;
  final String? repliedId;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$PromptModelToJson(this);
}
