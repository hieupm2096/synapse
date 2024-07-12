import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/app/model/user_model/user_model.dart';
import 'package:synapse/app/repository/user_repository.dart';

part 'current_user_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  FutureOr<UserModel> build() async {
    final res = await ref.read(userRepositoryProvider).getDefaultUser();
    return res.when(
      success: (success) => success,
      failure: (failure) => throw failure,
    );
  }
}
