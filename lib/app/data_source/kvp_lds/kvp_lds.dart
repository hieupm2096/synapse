import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/app/data_source/kvp_lds/isar_kvp_lds.dart';
import 'package:synapse/app/model/kvp_model/kvp_model.dart';
import 'package:synapse/core/core.dart';

part 'kvp_lds.g.dart';

@Riverpod(keepAlive: true)
IKVPLocalDS kvpLDS(KvpLDSRef ref) => IsarKvpLds(client: ref.read(isarProvider));

abstract interface class IKVPLocalDS {
  Future<List<KVPModel>> getKVPList();
  Future<KVPModel?> getKVP(String key);
  Future<void> setKVP(String key, String value);
  Future<bool> deleteKVP(String key);
}
