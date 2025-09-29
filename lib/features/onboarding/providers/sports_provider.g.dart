// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SportsViewModel)
const sportsViewModelProvider = SportsViewModelProvider._();

final class SportsViewModelProvider
    extends $NotifierProvider<SportsViewModel, AsyncValue<List<Sport>>> {
  const SportsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sportsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sportsViewModelHash();

  @$internal
  @override
  SportsViewModel create() => SportsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Sport>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Sport>>>(value),
    );
  }
}

String _$sportsViewModelHash() => r'd72654bd7aab27beb663f2c0f98cc8c20c814908';

abstract class _$SportsViewModel extends $Notifier<AsyncValue<List<Sport>>> {
  AsyncValue<List<Sport>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<Sport>>, AsyncValue<List<Sport>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Sport>>, AsyncValue<List<Sport>>>,
              AsyncValue<List<Sport>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
