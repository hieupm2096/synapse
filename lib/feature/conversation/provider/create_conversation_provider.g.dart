// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createConversationHash() =>
    r'bc61cfa01ac3b399d85afc9f43f6d94dedc275a0';

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

abstract class _$CreateConversation
    extends BuildlessAutoDisposeAsyncNotifier<ConversationModel?> {
  late final String? llmId;

  FutureOr<ConversationModel?> build({
    String? llmId,
  });
}

/// See also [CreateConversation].
@ProviderFor(CreateConversation)
const createConversationProvider = CreateConversationFamily();

/// See also [CreateConversation].
class CreateConversationFamily extends Family<AsyncValue<ConversationModel?>> {
  /// See also [CreateConversation].
  const CreateConversationFamily();

  /// See also [CreateConversation].
  CreateConversationProvider call({
    String? llmId,
  }) {
    return CreateConversationProvider(
      llmId: llmId,
    );
  }

  @override
  CreateConversationProvider getProviderOverride(
    covariant CreateConversationProvider provider,
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
  String? get name => r'createConversationProvider';
}

/// See also [CreateConversation].
class CreateConversationProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CreateConversation, ConversationModel?> {
  /// See also [CreateConversation].
  CreateConversationProvider({
    String? llmId,
  }) : this._internal(
          () => CreateConversation()..llmId = llmId,
          from: createConversationProvider,
          name: r'createConversationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createConversationHash,
          dependencies: CreateConversationFamily._dependencies,
          allTransitiveDependencies:
              CreateConversationFamily._allTransitiveDependencies,
          llmId: llmId,
        );

  CreateConversationProvider._internal(
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
    covariant CreateConversation notifier,
  ) {
    return notifier.build(
      llmId: llmId,
    );
  }

  @override
  Override overrideWith(CreateConversation Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreateConversationProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CreateConversation,
      ConversationModel?> createElement() {
    return _CreateConversationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateConversationProvider && other.llmId == llmId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, llmId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateConversationRef
    on AutoDisposeAsyncNotifierProviderRef<ConversationModel?> {
  /// The parameter `llmId` of this provider.
  String? get llmId;
}

class _CreateConversationProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CreateConversation,
        ConversationModel?> with CreateConversationRef {
  _CreateConversationProviderElement(super.provider);

  @override
  String? get llmId => (origin as CreateConversationProvider).llmId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
