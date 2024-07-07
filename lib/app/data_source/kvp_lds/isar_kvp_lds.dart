import 'package:isar/isar.dart';
import 'package:synapse/app/data_source/kvp_lds/kvp_lds.dart';
import 'package:synapse/app/model/kvp_model/kvp_model.dart';
import 'package:synapse/core/core.dart';

final class IsarKvpLds implements IKVPLocalDS {
  const IsarKvpLds({
    required Isar client,
  }) : _client = client;

  final Isar _client;

  @override
  Future<KVPModel?> getKVP(String key) async {
    return _client.kVPModels.filter().keyEqualTo(key).findFirst();
  }

  @override
  Future<List<KVPModel>> getKVPList() {
    return _client.kVPModels.where().findAll();
  }

  @override
  Future<void> setKVP(String key, String value) async {
    final kvp = await getKVP(key);

    final newKvp = KVPModel(
      key: key,
      value: value,
      createdAt: kvp?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _client.writeTxn(
      () async {
        await _client.kVPModels.put(newKvp);
      },
    );
  }

  @override
  Future<bool> deleteKVP(String key) {
    return _client.kVPModels.delete(key.fastHash);
  }
}
