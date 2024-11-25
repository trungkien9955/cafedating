// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nameRepoHash() => r'2a7124c0b0603cbdf18a2004e7ded9f736241f19';

/// See also [nameRepo].
@ProviderFor(nameRepo)
final nameRepoProvider = AutoDisposeProvider<NameRepo>.internal(
  nameRepo,
  name: r'nameRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$nameRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NameRepoRef = AutoDisposeProviderRef<NameRepo>;
String _$changeNameHash() => r'f4f63ec0e4f43660e54777391c27c318b91f38f6';

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

/// See also [changeName].
@ProviderFor(changeName)
const changeNameProvider = ChangeNameFamily();

/// See also [changeName].
class ChangeNameFamily extends Family<AsyncValue<String>> {
  /// See also [changeName].
  const ChangeNameFamily();

  /// See also [changeName].
  ChangeNameProvider call(
    String newName,
  ) {
    return ChangeNameProvider(
      newName,
    );
  }

  @override
  ChangeNameProvider getProviderOverride(
    covariant ChangeNameProvider provider,
  ) {
    return call(
      provider.newName,
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
  String? get name => r'changeNameProvider';
}

/// See also [changeName].
class ChangeNameProvider extends AutoDisposeFutureProvider<String> {
  /// See also [changeName].
  ChangeNameProvider(
    String newName,
  ) : this._internal(
          (ref) => changeName(
            ref as ChangeNameRef,
            newName,
          ),
          from: changeNameProvider,
          name: r'changeNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$changeNameHash,
          dependencies: ChangeNameFamily._dependencies,
          allTransitiveDependencies:
              ChangeNameFamily._allTransitiveDependencies,
          newName: newName,
        );

  ChangeNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.newName,
  }) : super.internal();

  final String newName;

  @override
  Override overrideWith(
    FutureOr<String> Function(ChangeNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChangeNameProvider._internal(
        (ref) => create(ref as ChangeNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        newName: newName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _ChangeNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChangeNameProvider && other.newName == newName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, newName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChangeNameRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `newName` of this provider.
  String get newName;
}

class _ChangeNameProviderElement
    extends AutoDisposeFutureProviderElement<String> with ChangeNameRef {
  _ChangeNameProviderElement(super.provider);

  @override
  String get newName => (origin as ChangeNameProvider).newName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
