import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapse/feature/setting/model/setting_key.dart';
import 'package:synapse/feature/setting/repository/setting_repository.dart';

part 'ai_setting_provider.g.dart';

@Riverpod(keepAlive: true)
class ContextWindowNotifier extends _$ContextWindowNotifier {
  @override
  FutureOr<int> build() async {
    final res = await ref.read(settingRepositoryProvider).getAIConfig(
          SettingConstant.kContextWindow,
          SettingConstant.defaultContextWindow,
        );

    return res.when(
      success: (success) => success,
      failure: (failure) => throw failure,
    );
  }

  Future<void> saveContextWindow(int value) async {
    state = const AsyncLoading();

    final res = await ref
        .read(settingRepositoryProvider)
        .storeAIConfig(value, SettingConstant.kContextWindow);

    state = res.when(
      success: (_) => AsyncData(value),
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}

@Riverpod(keepAlive: true)
class TopPNotifier extends _$TopPNotifier {
  @override
  FutureOr<double> build() async {
    final res = await ref.read(settingRepositoryProvider).getAIConfig(
          SettingConstant.kTopP,
          SettingConstant.defaultTopP,
        );

    return res.when(
      success: (success) {
        return double.parse((success.toDouble() / 100).toStringAsFixed(1));
      },
      failure: (failure) => throw failure,
    );
  }

  Future<void> saveTopP(double value) async {
    final val = (value * 100).round();

    final res = await ref
        .read(settingRepositoryProvider)
        .storeAIConfig(val, SettingConstant.kTopP);

    state = res.when(
      success: (_) => AsyncData(value),
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}

@Riverpod(keepAlive: true)
class TemperatureNotifier extends _$TemperatureNotifier {
  @override
  FutureOr<double> build() async {
    final res = await ref.read(settingRepositoryProvider).getAIConfig(
          SettingConstant.kTemperature,
          SettingConstant.defaultTemperature,
        );

    return res.when(
      success: (success) {
        return double.parse((success.toDouble() / 100).toStringAsFixed(1));
      },
      failure: (failure) => throw failure,
    );
  }

  Future<void> saveTemperature(double value) async {
    final val = (value * 100).round();

    final res = await ref
        .read(settingRepositoryProvider)
        .storeAIConfig(val, SettingConstant.kTemperature);

    state = res.when(
      success: (_) => AsyncData(value),
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}

@Riverpod(keepAlive: true)
class FrequencyPNotifier extends _$FrequencyPNotifier {
  @override
  FutureOr<double> build() async {
    final res = await ref.read(settingRepositoryProvider).getAIConfig(
          SettingConstant.kFrequencyPenalty,
          SettingConstant.defaultFrequencyPenalty,
        );

    return res.when(
      success: (success) {
        return double.parse((success.toDouble() / 100).toStringAsFixed(1));
      },
      failure: (failure) => throw failure,
    );
  }

  Future<void> saveFrequencyPenalty(double value) async {
    final val = (value * 100).round();

    final res = await ref
        .read(settingRepositoryProvider)
        .storeAIConfig(val, SettingConstant.kFrequencyPenalty);

    state = res.when(
      success: (_) => AsyncData(value),
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}

@Riverpod(keepAlive: true)
class PresencePNotifier extends _$PresencePNotifier {
  @override
  FutureOr<double> build() async {
    final res = await ref.read(settingRepositoryProvider).getAIConfig(
          SettingConstant.kPresencePenalty,
          SettingConstant.defaultPresencePenalty,
        );

    return res.when(
      success: (success) {
        return double.parse((success.toDouble() / 100).toStringAsFixed(1));
      },
      failure: (failure) => throw failure,
    );
  }

  Future<void> savePresencePenalty(double value) async {
    final val = (value * 100).round();

    final res = await ref
        .read(settingRepositoryProvider)
        .storeAIConfig(val, SettingConstant.kPresencePenalty);

    state = res.when(
      success: (_) => AsyncData(value),
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}
