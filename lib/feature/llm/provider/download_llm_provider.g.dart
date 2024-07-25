// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_llm_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$downloadLlmHash() => r'42b1d2258ae1e570e2d6ea57db011fba7dbe9b8d';

/// See also [DownloadLlm].
@ProviderFor(DownloadLlm)
final downloadLlmProvider =
    AsyncNotifierProvider<DownloadLlm, DownloadLlmState>.internal(
  DownloadLlm.new,
  name: r'downloadLlmProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$downloadLlmHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DownloadLlm = AsyncNotifier<DownloadLlmState>;
String _$overallProgressHash() => r'a2f3ec2e7dc36f520091f154d34b6c2e832f0c59';

/// See also [OverallProgress].
@ProviderFor(OverallProgress)
final overallProgressProvider =
    NotifierProvider<OverallProgress, double>.internal(
  OverallProgress.new,
  name: r'overallProgressProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$overallProgressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OverallProgress = Notifier<double>;
String _$downloadProgressHash() => r'f3e0d783a8ec4c125fd7d4072fad5dfc9005ea9b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DownloadProgress extends BuildlessNotifier<double> {
  late final String taskId;

  double build(
    String taskId,
  );
}

/// See also [DownloadProgress].
@ProviderFor(DownloadProgress)
const downloadProgressProvider = DownloadProgressFamily();

/// See also [DownloadProgress].
class DownloadProgressFamily extends Family<double> {
  /// See also [DownloadProgress].
  const DownloadProgressFamily();

  /// See also [DownloadProgress].
  DownloadProgressProvider call(
    String taskId,
  ) {
    return DownloadProgressProvider(
      taskId,
    );
  }

  @override
  DownloadProgressProvider getProviderOverride(
    covariant DownloadProgressProvider provider,
  ) {
    return call(
      provider.taskId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'downloadProgressProvider';
}

/// See also [DownloadProgress].
class DownloadProgressProvider
    extends NotifierProviderImpl<DownloadProgress, double> {
  /// See also [DownloadProgress].
  DownloadProgressProvider(
    String taskId,
  ) : this._internal(
          () => DownloadProgress()..taskId = taskId,
          from: downloadProgressProvider,
          name: r'downloadProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$downloadProgressHash,
          dependencies: DownloadProgressFamily._dependencies,
          allTransitiveDependencies:
              DownloadProgressFamily._allTransitiveDependencies,
          taskId: taskId,
        );

  DownloadProgressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskId,
  }) : super.internal();

  final String taskId;

  @override
  double runNotifierBuild(
    covariant DownloadProgress notifier,
  ) {
    return notifier.build(
      taskId,
    );
  }

  @override
  Override overrideWith(DownloadProgress Function() create) {
    return ProviderOverride(
      origin: this,
      override: DownloadProgressProvider._internal(
        () => create()..taskId = taskId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskId: taskId,
      ),
    );
  }

  @override
  NotifierProviderElement<DownloadProgress, double> createElement() {
    return _DownloadProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DownloadProgressProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DownloadProgressRef on NotifierProviderRef<double> {
  /// The parameter `taskId` of this provider.
  String get taskId;
}

class _DownloadProgressProviderElement
    extends NotifierProviderElement<DownloadProgress, double>
    with DownloadProgressRef {
  _DownloadProgressProviderElement(super.provider);

  @override
  String get taskId => (origin as DownloadProgressProvider).taskId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
