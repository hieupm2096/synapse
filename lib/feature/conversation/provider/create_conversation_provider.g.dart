// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createConversationAsyncNotifierHash() =>
    r'81e4ac41799ad4c1164e282a1e8904f9ac9cd05f';

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

abstract class _$CreateConversationAsyncNotifier
    extends BuildlessAutoDisposeAsyncNotifier<ConversationModel?> {
  late final String? llmId;

  FutureOr<ConversationModel?> build({
    String? llmId,
  });
}

/// See also [CreateConversationAsyncNotifier].
@ProviderFor(CreateConversationAsyncNotifier)
const createConversationAsyncNotifierProvider =
    CreateConversationAsyncNotifierFamily();

/// See also [CreateConversationAsyncNotifier].
class CreateConversationAsyncNotifierFamily
    extends Family<AsyncValue<ConversationModel?>> {
  /// See also [CreateConversationAsyncNotifier].
  const CreateConversationAsyncNotifierFamily();

  /// See also [CreateConversationAsyncNotifier].
  CreateConversationAsyncNotifierProvider call({
    String? llmId,
  }) {
    return CreateConversationAsyncNotifierProvider(
      llmId: llmId,
    );
  }

  @override
  CreateConversationAsyncNotifierProvider getProviderOverride(
    covariant CreateConversationAsyncNotifierProvider provider,
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
  String? get name => r'createConversationAsyncNotifierProvider';
}

/// See also [CreateConversationAsyncNotifier].
class CreateConversationAsyncNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        CreateConversationAsyncNotifier, ConversationModel?> {
  /// See also [CreateConversationAsyncNotifier].
  CreateConversationAsyncNotifierProvider({
    String? llmId,
  }) : this._internal(
          () => CreateConversationAsyncNotifier()..llmId = llmId,
          from: createConversationAsyncNotifierProvider,
          name: r'createConversationAsyncNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createConversationAsyncNotifierHash,
          dependencies: CreateConversationAsyncNotifierFamily._dependencies,
          allTransitiveDependencies:
              CreateConversationAsyncNotifierFamily._allTransitiveDependencies,
          llmId: llmId,
        );

  CreateConversationAsyncNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.llmId,
  }) : super.internal();

  final String? llmId;

  @override
  FutureOr<ConversationModel?> runNotifierBuild(
    covariant CreateConversationAsyncNotifier notifier,
  ) {
    return notifier.build(
      llmId: llmId,
    );
  }

  @override
  Override overrideWith(CreateConversationAsyncNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreateConversationAsyncNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CreateConversationAsyncNotifier,
      ConversationModel?> createElement() {
    return _CreateConversationAsyncNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateConversationAsyncNotifierProvider &&
        other.llmId == llmId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, llmId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateConversationAsyncNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<ConversationModel?> {
  /// The parameter `llmId` of this provider.
  String? get llmId;
}

class _CreateConversationAsyncNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        CreateConversationAsyncNotifier,
        ConversationModel?> with CreateConversationAsyncNotifierRef {
  _CreateConversationAsyncNotifierProviderElement(super.provider);

  @override
  String? get llmId =>
      (origin as CreateConversationAsyncNotifierProvider).llmId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
