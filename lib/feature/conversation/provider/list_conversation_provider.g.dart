// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listConversationAsyncNotifierHash() =>
    r'af80189d39bcc0eb626b5fa3a9cd9604c3514fb0';

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

abstract class _$ListConversationAsyncNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<ConversationModel>> {
  late final String? llmId;

  FutureOr<List<ConversationModel>> build({
    String? llmId,
  });
}

/// See also [ListConversationAsyncNotifier].
@ProviderFor(ListConversationAsyncNotifier)
const listConversationAsyncNotifierProvider =
    ListConversationAsyncNotifierFamily();

/// See also [ListConversationAsyncNotifier].
class ListConversationAsyncNotifierFamily
    extends Family<AsyncValue<List<ConversationModel>>> {
  /// See also [ListConversationAsyncNotifier].
  const ListConversationAsyncNotifierFamily();

  /// See also [ListConversationAsyncNotifier].
  ListConversationAsyncNotifierProvider call({
    String? llmId,
  }) {
    return ListConversationAsyncNotifierProvider(
      llmId: llmId,
    );
  }

  @override
  ListConversationAsyncNotifierProvider getProviderOverride(
    covariant ListConversationAsyncNotifierProvider provider,
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
  String? get name => r'listConversationAsyncNotifierProvider';
}

/// See also [ListConversationAsyncNotifier].
class ListConversationAsyncNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ListConversationAsyncNotifier,
        List<ConversationModel>> {
  /// See also [ListConversationAsyncNotifier].
  ListConversationAsyncNotifierProvider({
    String? llmId,
  }) : this._internal(
          () => ListConversationAsyncNotifier()..llmId = llmId,
          from: listConversationAsyncNotifierProvider,
          name: r'listConversationAsyncNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listConversationAsyncNotifierHash,
          dependencies: ListConversationAsyncNotifierFamily._dependencies,
          allTransitiveDependencies:
              ListConversationAsyncNotifierFamily._allTransitiveDependencies,
          llmId: llmId,
        );

  ListConversationAsyncNotifierProvider._internal(
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
    covariant ListConversationAsyncNotifier notifier,
  ) {
    return notifier.build(
      llmId: llmId,
    );
  }

  @override
  Override overrideWith(ListConversationAsyncNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListConversationAsyncNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ListConversationAsyncNotifier,
      List<ConversationModel>> createElement() {
    return _ListConversationAsyncNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListConversationAsyncNotifierProvider &&
        other.llmId == llmId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, llmId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListConversationAsyncNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<ConversationModel>> {
  /// The parameter `llmId` of this provider.
  String? get llmId;
}

class _ListConversationAsyncNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ListConversationAsyncNotifier,
        List<ConversationModel>> with ListConversationAsyncNotifierRef {
  _ListConversationAsyncNotifierProviderElement(super.provider);

  @override
  String? get llmId => (origin as ListConversationAsyncNotifierProvider).llmId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
