import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/setting/repository/setting_repository.dart';

part 'app_setting_provider.g.dart';

@Riverpod(keepAlive: true)
class DarkMode extends _$DarkMode {
  @override
  FutureOr<bool> build() async {
    final res = await ref.read(settingRepositoryProvider).getDarkModeSetting();

    return res.when(
      success: (success) => success,
      failure: (failure) => throw failure,
    );
  }

  Future<void> saveDarkMode({required bool isDarkMode}) async {
    final res = await ref
        .read(settingRepositoryProvider)
        .storeDarkMode(isDarkMode: isDarkMode);

    state = res.when(
      success: (_) => AsyncData(isDarkMode),
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}
