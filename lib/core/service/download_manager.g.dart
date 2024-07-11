// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fileDownloaderHash() => r'4cac9e71d51d0ff4b1231c2fedf0fe688ba1fa45';

/// See also [fileDownloader].
@ProviderFor(fileDownloader)
final fileDownloaderProvider = Provider<FileDownloader>.internal(
  fileDownloader,
  name: r'fileDownloaderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fileDownloaderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FileDownloaderRef = ProviderRef<FileDownloader>;
String _$downloadManagerHash() => r'ce0956bc9c85774b19df31a32f741db8698eb274';

/// See also [downloadManager].
@ProviderFor(downloadManager)
final downloadManagerProvider = Provider<DownloadManager>.internal(
  downloadManager,
  name: r'downloadManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$downloadManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DownloadManagerRef = ProviderRef<DownloadManager>;
String _$isDownloadingHash() => r'59841924f4352d5f65f1e933491574243c7dee28';

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

/// See also [isDownloading].
@ProviderFor(isDownloading)
const isDownloadingProvider = IsDownloadingFamily();

/// See also [isDownloading].
class IsDownloadingFamily extends Family<AsyncValue<bool>> {
  /// See also [isDownloading].
  const IsDownloadingFamily();

  /// See also [isDownloading].
  IsDownloadingProvider call(
    String url,
  ) {
    return IsDownloadingProvider(
      url,
    );
  }

  @override
  IsDownloadingProvider getProviderOverride(
    covariant IsDownloadingProvider provider,
  ) {
    return call(
      provider.url,
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
  String? get name => r'isDownloadingProvider';
}

/// See also [isDownloading].
class IsDownloadingProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [isDownloading].
  IsDownloadingProvider(
    String url,
  ) : this._internal(
          (ref) => isDownloading(
            ref as IsDownloadingRef,
            url,
          ),
          from: isDownloadingProvider,
          name: r'isDownloadingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isDownloadingHash,
          dependencies: IsDownloadingFamily._dependencies,
          allTransitiveDependencies:
              IsDownloadingFamily._allTransitiveDependencies,
          url: url,
        );

  IsDownloadingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsDownloadingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsDownloadingProvider._internal(
        (ref) => create(ref as IsDownloadingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsDownloadingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsDownloadingProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsDownloadingRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `url` of this provider.
  String get url;
}

class _IsDownloadingProviderElement
    extends AutoDisposeFutureProviderElement<bool> with IsDownloadingRef {
  _IsDownloadingProviderElement(super.provider);

  @override
  String get url => (origin as IsDownloadingProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
