import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_result/simple_result.dart';
import 'package:synapse/app/data_source/kvp_lds/kvp_lds.dart';
import 'package:synapse/feature/setting/model/setting_key.dart';

part 'setting_repository.g.dart';

@Riverpod(keepAlive: true)
SettingRepository settingRepository(SettingRepositoryRef ref) {
  return SettingRepository(kvpLocalDS: ref.read(kvpLDSProvider));
}

final class SettingRepository {
  const SettingRepository({required IKVPLocalDS kvpLocalDS})
      : _kvpLocalDS = kvpLocalDS;

  final IKVPLocalDS _kvpLocalDS;

  Future<Result<bool, Exception>> getDarkModeSetting() async {
    try {
      final res = await _kvpLocalDS.getKVP(SettingConstant.kDarkMode);

      return Result.success(res?.value == '1');
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<bool, Exception>> storeDarkMode({
    required bool isDarkMode,
  }) async {
    try {
      await _kvpLocalDS.setKVP(
        SettingConstant.kDarkMode,
        isDarkMode ? '1' : '0',
      );

      return const Result.success(true);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<String, Exception>> getLanguage() async {
    throw UnimplementedError();
  }

  Future<Result<int, Exception>> getAIConfig(
    String key,
    int defaultValue,
  ) async {
    try {
      final res = await _kvpLocalDS.getKVP(key);

      if (res == null) {
        return Result.success(defaultValue);
      }

      return Result.success(int.parse(res.value));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<bool, Exception>> storeAIConfig(int value, String key) async {
    try {
      await _kvpLocalDS.setKVP(
        key,
        value.toString(),
      );

      return const Result.success(true);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
