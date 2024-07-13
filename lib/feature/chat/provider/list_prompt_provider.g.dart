// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_prompt_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listPromptHash() => r'49408efb69823d7e498dc0639379f608c0b0f1d8';

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

abstract class _$ListPrompt
    extends BuildlessAutoDisposeAsyncNotifier<List<PromptModel>> {
  late final int conversationId;

  FutureOr<List<PromptModel>> build(
    int conversationId,
  );
}

/// See also [ListPrompt].
@ProviderFor(ListPrompt)
const listPromptProvider = ListPromptFamily();

/// See also [ListPrompt].
class ListPromptFamily extends Family<AsyncValue<List<PromptModel>>> {
  /// See also [ListPrompt].
  const ListPromptFamily();

  /// See also [ListPrompt].
  ListPromptProvider call(
    int conversationId,
  ) {
    return ListPromptProvider(
      conversationId,
    );
  }

  @override
  ListPromptProvider getProviderOverride(
    covariant ListPromptProvider provider,
  ) {
    return call(
      provider.conversationId,
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
  String? get name => r'listPromptProvider';
}

/// See also [ListPrompt].
class ListPromptProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ListPrompt, List<PromptModel>> {
  /// See also [ListPrompt].
  ListPromptProvider(
    int conversationId,
  ) : this._internal(
          () => ListPrompt()..conversationId = conversationId,
          from: listPromptProvider,
          name: r'listPromptProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listPromptHash,
          dependencies: ListPromptFamily._dependencies,
          allTransitiveDependencies:
              ListPromptFamily._allTransitiveDependencies,
          conversationId: conversationId,
        );

  ListPromptProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.conversationId,
  }) : super.internal();

  final int conversationId;

  @override
  FutureOr<List<PromptModel>> runNotifierBuild(
    covariant ListPrompt notifier,
  ) {
    return notifier.build(
      conversationId,
    );
  }

  @override
  Override overrideWith(ListPrompt Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListPromptProvider._internal(
        () => create()..conversationId = conversationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        conversationId: conversationId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ListPrompt, List<PromptModel>>
      createElement() {
    return _ListPromptProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListPromptProvider &&
        other.conversationId == conversationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, conversationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListPromptRef on AutoDisposeAsyncNotifierProviderRef<List<PromptModel>> {
  /// The parameter `conversationId` of this provider.
  int get conversationId;
}

class _ListPromptProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ListPrompt,
        List<PromptModel>> with ListPromptRef {
  _ListPromptProviderElement(super.provider);

  @override
  int get conversationId => (origin as ListPromptProvider).conversationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
