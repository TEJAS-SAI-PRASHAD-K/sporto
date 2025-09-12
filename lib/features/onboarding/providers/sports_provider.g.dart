// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sportsViewModelHash() => r'd72654bd7aab27beb663f2c0f98cc8c20c814908';

/// See also [SportsViewModel].
@ProviderFor(SportsViewModel)
final sportsViewModelProvider =
    AutoDisposeNotifierProvider<
      SportsViewModel,
      AsyncValue<List<Sport>>
    >.internal(
      SportsViewModel.new,
      name: r'sportsViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sportsViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SportsViewModel = AutoDisposeNotifier<AsyncValue<List<Sport>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
