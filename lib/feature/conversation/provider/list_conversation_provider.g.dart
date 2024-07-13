// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listConversationHash() => r'5865725f9a29a49e1a1984633639ccb23b1b14cd';

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

abstract class _$ListConversation
    extends BuildlessAutoDisposeAsyncNotifier<List<ConversationModel>> {
  late final String? llmId;

  FutureOr<List<ConversationModel>> build({
    String? llmId,
  });
}

/// See also [ListConversation].
@ProviderFor(ListConversation)
const listConversationProvider = ListConversationFamily();

/// See also [ListConversation].
class ListConversationFamily
    extends Family<AsyncValue<List<ConversationModel>>> {
  /// See also [ListConversation].
  const ListConversationFamily();

  /// See also [ListConversation].
  ListConversationProvider call({
    String? llmId,
  }) {
    return ListConversationProvider(
      llmId: llmId,
    );
  }

  @override
  ListConversationProvider getProviderOverride(
    covariant ListConversationProvider provider,
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
  String? get name => r'listConversationProvider';
}

/// See also [ListConversation].
class ListConversationProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ListConversation, List<ConversationModel>> {
  /// See also [ListConversation].
  ListConversationProvider({
    String? llmId,
  }) : this._internal(
          () => ListConversation()..llmId = llmId,
          from: listConversationProvider,
          name: r'listConversationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listConversationHash,
          dependencies: ListConversationFamily._dependencies,
          allTransitiveDependencies:
              ListConversationFamily._allTransitiveDependencies,
          llmId: llmId,
        );

  ListConversationProvider._internal(
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
  FutureOr<List<ConversationModel>> runNotifierBuild(
    covariant ListConversation notifier,
  ) {
    return notifier.build(
      llmId: llmId,
    );
  }

  @override
  Override overrideWith(ListConversation Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListConversationProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ListConversation,
      List<ConversationModel>> createElement() {
    return _ListConversationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListConversationProvider && other.llmId == llmId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, llmId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListConversationRef
    on AutoDisposeAsyncNotifierProviderRef<List<ConversationModel>> {
  /// The parameter `llmId` of this provider.
  String? get llmId;
}

class _ListConversationProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ListConversation,
        List<ConversationModel>> with ListConversationRef {
  _ListConversationProviderElement(super.provider);

  @override
  String? get llmId => (origin as ListConversationProvider).llmId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
