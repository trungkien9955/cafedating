// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_place_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncPlaceDetailsNotifierHash() =>
    r'9e2a397dd323c0ab9e71eb17eaf953c61ce2328f';

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

abstract class _$AsyncPlaceDetailsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<PlaceDetails> {
  late final String placeId;

  FutureOr<PlaceDetails> build(
    String placeId,
  );
}

/// See also [AsyncPlaceDetailsNotifier].
@ProviderFor(AsyncPlaceDetailsNotifier)
const asyncPlaceDetailsNotifierProvider = AsyncPlaceDetailsNotifierFamily();

/// See also [AsyncPlaceDetailsNotifier].
class AsyncPlaceDetailsNotifierFamily extends Family<AsyncValue<PlaceDetails>> {
  /// See also [AsyncPlaceDetailsNotifier].
  const AsyncPlaceDetailsNotifierFamily();

  /// See also [AsyncPlaceDetailsNotifier].
  AsyncPlaceDetailsNotifierProvider call(
    String placeId,
  ) {
    return AsyncPlaceDetailsNotifierProvider(
      placeId,
    );
  }

  @override
  AsyncPlaceDetailsNotifierProvider getProviderOverride(
    covariant AsyncPlaceDetailsNotifierProvider provider,
  ) {
    return call(
      provider.placeId,
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
  String? get name => r'asyncPlaceDetailsNotifierProvider';
}

/// See also [AsyncPlaceDetailsNotifier].
class AsyncPlaceDetailsNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AsyncPlaceDetailsNotifier,
        PlaceDetails> {
  /// See also [AsyncPlaceDetailsNotifier].
  AsyncPlaceDetailsNotifierProvider(
    String placeId,
  ) : this._internal(
          () => AsyncPlaceDetailsNotifier()..placeId = placeId,
          from: asyncPlaceDetailsNotifierProvider,
          name: r'asyncPlaceDetailsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$asyncPlaceDetailsNotifierHash,
          dependencies: AsyncPlaceDetailsNotifierFamily._dependencies,
          allTransitiveDependencies:
              AsyncPlaceDetailsNotifierFamily._allTransitiveDependencies,
          placeId: placeId,
        );

  AsyncPlaceDetailsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.placeId,
  }) : super.internal();

  final String placeId;

  @override
  FutureOr<PlaceDetails> runNotifierBuild(
    covariant AsyncPlaceDetailsNotifier notifier,
  ) {
    return notifier.build(
      placeId,
    );
  }

  @override
  Override overrideWith(AsyncPlaceDetailsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: AsyncPlaceDetailsNotifierProvider._internal(
        () => create()..placeId = placeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        placeId: placeId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AsyncPlaceDetailsNotifier,
      PlaceDetails> createElement() {
    return _AsyncPlaceDetailsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncPlaceDetailsNotifierProvider &&
        other.placeId == placeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, placeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AsyncPlaceDetailsNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<PlaceDetails> {
  /// The parameter `placeId` of this provider.
  String get placeId;
}

class _AsyncPlaceDetailsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AsyncPlaceDetailsNotifier,
        PlaceDetails> with AsyncPlaceDetailsNotifierRef {
  _AsyncPlaceDetailsNotifierProviderElement(super.provider);

  @override
  String get placeId => (origin as AsyncPlaceDetailsNotifierProvider).placeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
