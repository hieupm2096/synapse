import 'package:isar/isar.dart';
import 'package:synapse/app/data_source/user_lds/user_lds.dart';
import 'package:synapse/app/model/user_model/user_model.dart';

final class IsarUserLds implements IUserLDS {
  const IsarUserLds({required Isar client}) : _client = client;

  final Isar _client;

  @override
  Future<UserModel> createUser({required UserModel data}) async {
    await _client.writeTxn(() => _client.userModels.put(data));

    return data;
  }

  @override
  Future<UserModel?> getDefaultUser() {
    return _client.userModels.where().findFirst();
  }

  @override
  Future<UserModel> updateUser({required UserModel data}) async {
    await _client.writeTxn(() => _client.userModels.put(data));

    return data;
  }
}
