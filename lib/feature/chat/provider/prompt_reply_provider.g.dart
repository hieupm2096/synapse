// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_reply_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$promptReplyHash() => r'1f847d0109430ad249c3f493501996048bb48d7d';

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

abstract class _$PromptReply extends BuildlessAutoDisposeNotifier<String> {
  late final int id;

  String build({
    required int id,
  });
}

/// See also [PromptReply].
@ProviderFor(PromptReply)
const promptReplyProvider = PromptReplyFamily();

/// See also [PromptReply].
class PromptReplyFamily extends Family<String> {
  /// See also [PromptReply].
  const PromptReplyFamily();

  /// See also [PromptReply].
  PromptReplyProvider call({
    required int id,
  }) {
    return PromptReplyProvider(
      id: id,
    );
  }

  @override
  PromptReplyProvider getProviderOverride(
    covariant PromptReplyProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'promptReplyProvider';
}

/// See also [PromptReply].
class PromptReplyProvider
    extends AutoDisposeNotifierProviderImpl<PromptReply, String> {
  /// See also [PromptReply].
  PromptReplyProvider({
    required int id,
  }) : this._internal(
          () => PromptReply()..id = id,
          from: promptReplyProvider,
          name: r'promptReplyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$promptReplyHash,
          dependencies: PromptReplyFamily._dependencies,
          allTransitiveDependencies:
              PromptReplyFamily._allTransitiveDependencies,
          id: id,
        );

  PromptReplyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  String runNotifierBuild(
    covariant PromptReply notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }

  @override
  Override overrideWith(PromptReply Function() create) {
    return ProviderOverride(
      origin: this,
      override: PromptReplyProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PromptReply, String> createElement() {
    return _PromptReplyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PromptReplyProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PromptReplyRef on AutoDisposeNotifierProviderRef<String> {
  /// The parameter `id` of this provider.
  int get id;
}

class _PromptReplyProviderElement
    extends AutoDisposeNotifierProviderElement<PromptReply, String>
    with PromptReplyRef {
  _PromptReplyProviderElement(super.provider);

  @override
  int get id => (origin as PromptReplyProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
