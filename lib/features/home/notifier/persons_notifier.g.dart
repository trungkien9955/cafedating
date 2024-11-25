// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persons_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$personsHash() => r'c78632bbad17e71decc4d6609fe292c86bcb27cc';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
///
/// Copied from [persons].
@ProviderFor(persons)
final personsProvider = AutoDisposeFutureProvider<List<Person>>.internal(
  persons,
  name: r'personsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$personsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PersonsRef = AutoDisposeFutureProviderRef<List<Person>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
