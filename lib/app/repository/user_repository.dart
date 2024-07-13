import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_result/simple_result.dart';
import 'package:synapse/app/data_source/user_lds/user_lds.dart';
import 'package:synapse/app/model/user_model/user_model.dart';
import 'package:uuid/uuid.dart';

part 'user_repository.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(userLDS: ref.read(userLDSProvider));
}

final class UserRepository {
  const UserRepository({required IUserLDS userLDS}) : _userLDS = userLDS;

  final IUserLDS _userLDS;

  Future<Result<UserModel, Exception>> getDefaultUser() async {
    try {
      final res = await _userLDS.getDefaultUser();

      if (res != null) return Result.success(res);

      final newUser = await _userLDS.createUser(
        data: UserModel(
          id: const Uuid().v4(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      return Result.success(newUser);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
