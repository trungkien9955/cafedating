// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_person_profile.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncPersonProfileHash() =>
    r'6b89de92244ace13f41b756ba166870725aa4579';

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

/// See also [asyncPersonProfile].
@ProviderFor(asyncPersonProfile)
const asyncPersonProfileProvider = AsyncPersonProfileFamily();

/// See also [asyncPersonProfile].
class AsyncPersonProfileFamily extends Family<AsyncValue<PersonProfile>> {
  /// See also [asyncPersonProfile].
  const AsyncPersonProfileFamily();

  /// See also [asyncPersonProfile].
  AsyncPersonProfileProvider call(
    String userId,
  ) {
    return AsyncPersonProfileProvider(
      userId,
    );
  }

  @override
  AsyncPersonProfileProvider getProviderOverride(
    covariant AsyncPersonProfileProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'asyncPersonProfileProvider';
}

/// See also [asyncPersonProfile].
class AsyncPersonProfileProvider
    extends AutoDisposeFutureProvider<PersonProfile> {
  /// See also [asyncPersonProfile].
  AsyncPersonProfileProvider(
    String userId,
  ) : this._internal(
          (ref) => asyncPersonProfile(
            ref as AsyncPersonProfileRef,
            userId,
          ),
          from: asyncPersonProfileProvider,
          name: r'asyncPersonProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$asyncPersonProfileHash,
          dependencies: AsyncPersonProfileFamily._dependencies,
          allTransitiveDependencies:
              AsyncPersonProfileFamily._allTransitiveDependencies,
          userId: userId,
        );

  AsyncPersonProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<PersonProfile> Function(AsyncPersonProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AsyncPersonProfileProvider._internal(
        (ref) => create(ref as AsyncPersonProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PersonProfile> createElement() {
    return _AsyncPersonProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncPersonProfileProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AsyncPersonProfileRef on AutoDisposeFutureProviderRef<PersonProfile> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _AsyncPersonProfileProviderElement
    extends AutoDisposeFutureProviderElement<PersonProfile>
    with AsyncPersonProfileRef {
  _AsyncPersonProfileProviderElement(super.provider);

  @override
  String get userId => (origin as AsyncPersonProfileProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
