import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/app/model/kvp_model/kvp_model.dart';
import 'package:synapse/app/model/user_model/user_model.dart';
import 'package:synapse/feature/conversation/model/conversation_model/conversation_model.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';

part 'isar_client.g.dart';

@Riverpod(keepAlive: true)
Isar isar(IsarRef ref) => throw UnimplementedError();

Future<Isar> initIsarClient() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      ConversationModelSchema,
      LlmModelSchema,
      KVPModelSchema,
      UserModelSchema,
    ],
    directory: dir.path,
  );
  return isar;
}
