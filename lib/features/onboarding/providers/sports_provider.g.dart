// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sportsViewModelHash() => r'f4461d02a25ea549fba45ef5b5768d4e5ddf4417';

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
