// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentConversationHash() =>
    r'0bdd07991a1ae0bba853d05dc69003927efb70dc';

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

abstract class _$CurrentConversation
    extends BuildlessAsyncNotifier<ConversationModel?> {
  late final String llmId;

  FutureOr<ConversationModel?> build({
    required String llmId,
  });
}

/// See also [CurrentConversation].
@ProviderFor(CurrentConversation)
const currentConversationProvider = CurrentConversationFamily();

/// See also [CurrentConversation].
class CurrentConversationFamily extends Family<AsyncValue<ConversationModel?>> {
  /// See also [CurrentConversation].
  const CurrentConversationFamily();

  /// See also [CurrentConversation].
  CurrentConversationProvider call({
    required String llmId,
  }) {
    return CurrentConversationProvider(
      llmId: llmId,
    );
  }

  @override
  CurrentConversationProvider getProviderOverride(
    covariant CurrentConversationProvider provider,
  ) {
    return call(
      llmId: provider.llmId,
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
  String? get name => r'currentConversationProvider';
}

/// See also [CurrentConversation].
class CurrentConversationProvider
    extends AsyncNotifierProviderImpl<CurrentConversation, ConversationModel?> {
  /// See also [CurrentConversation].
  CurrentConversationProvider({
    required String llmId,
  }) : this._internal(
          () => CurrentConversation()..llmId = llmId,
          from: currentConversationProvider,
          name: r'currentConversationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentConversationHash,
          dependencies: CurrentConversationFamily._dependencies,
          allTransitiveDependencies:
              CurrentConversationFamily._allTransitiveDependencies,
          llmId: llmId,
        );

  CurrentConversationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.llmId,
  }) : super.internal();

  final String llmId;

  @override
  FutureOr<ConversationModel?> runNotifierBuild(
    covariant CurrentConversation notifier,
  ) {
    return notifier.build(
      llmId: llmId,
    );
  }

  @override
  Override overrideWith(CurrentConversation Function() create) {
    return ProviderOverride(
      origin: this,
      override: CurrentConversationProvider._internal(
        () => create()..llmId = llmId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        llmId: llmId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<CurrentConversation, ConversationModel?>
      createElement() {
    return _CurrentConversationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentConversationProvider && other.llmId == llmId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, llmId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CurrentConversationRef on AsyncNotifierProviderRef<ConversationModel?> {
  /// The parameter `llmId` of this provider.
  String get llmId;
}

class _CurrentConversationProviderElement extends AsyncNotifierProviderElement<
    CurrentConversation, ConversationModel?> with CurrentConversationRef {
  _CurrentConversationProviderElement(super.provider);

  @override
  String get llmId => (origin as CurrentConversationProvider).llmId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
