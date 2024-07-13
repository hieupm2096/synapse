import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/app/data_source/user_lds/isar_user_lds.dart';
import 'package:synapse/app/model/user_model/user_model.dart';
import 'package:synapse/core/core.dart';

part 'user_lds.g.dart';

@Riverpod(keepAlive: true)
IUserLDS userLDS(UserLDSRef ref) => IsarUserLds(client: ref.read(isarProvider));

abstract interface class IUserLDS {
  Future<UserModel> createUser({required UserModel data});
  Future<UserModel?> getDefaultUser();
  Future<UserModel> updateUser({required UserModel data});
}
