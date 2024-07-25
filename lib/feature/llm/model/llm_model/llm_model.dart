import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:synapse/core/core.dart';

part 'llm_model.g.dart';

@JsonSerializable()
@Collection(ignore: {'props', 'isAvailable', 'isExternal'})
@Name('llm_model')
class LlmModel extends Equatable {
  const LlmModel({
    this.id,
    this.author,
    this.lastModified,
    this.sha,
    this.createdAt,
    this.modelId,
    this.parameters,
    this.size,
    this.architecture,
    this.url,
    this.downloadUrl,
    this.path,
  });

  factory LlmModel.fromJson(Map<String, dynamic> json) {
    return _$LlmModelFromJson(json);
  }

  final String? id;

  Id? get isarId => id?.fastHash;
  final String? author;
  final DateTime? lastModified;
  final String? sha;
  final DateTime? createdAt;
  final String? modelId;
  final String? parameters;
  final String? size;
  final String? architecture;
  final String? url;
  final String? downloadUrl;
  final String? path;

  bool get isAvailable => path != null && path!.isNotEmpty;

  bool get isExternal => url != null && url!.isNotEmpty;

  Map<String, dynamic> toJson() => _$LlmModelToJson(this);

  @override
  List<Object?> get props => [id];

  LlmModel copyWith({
    String? id,
    String? author,
    DateTime? lastModified,
    String? sha,
    DateTime? createdAt,
    String? modelId,
    String? parameters,
    String? size,
    String? architecture,
    String? url,
    String? downloadUrl,
    String? path,
  }) {
    return LlmModel(
      id: id ?? this.id,
      author: author ?? this.author,
      lastModified: lastModified ?? this.lastModified,
      sha: sha ?? this.sha,
      createdAt: createdAt ?? this.createdAt,
      modelId: modelId ?? this.modelId,
      parameters: parameters ?? this.parameters,
      size: size ?? this.size,
      architecture: architecture ?? this.architecture,
      url: url ?? this.url,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      path: path ?? this.path,
    );
  }
}
