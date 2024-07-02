import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/chat/model/conversation_model/conversation_model.dart';

part 'isar_client.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isar(IsarRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      ConversationModelSchema,
    ],
    directory: dir.path,
  );
  return isar;
}
