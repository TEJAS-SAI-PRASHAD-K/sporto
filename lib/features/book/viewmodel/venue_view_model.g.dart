// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VenueViewModel)
const venueViewModelProvider = VenueViewModelProvider._();

final class VenueViewModelProvider
    extends $NotifierProvider<VenueViewModel, AsyncValue<Venue>> {
  const VenueViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'venueViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$venueViewModelHash();

  @$internal
  @override
  VenueViewModel create() => VenueViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<Venue> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<Venue>>(value),
    );
  }
}

String _$venueViewModelHash() => r'004b2358d4b60a5e181cfa1c43387c6957cb9290';

abstract class _$VenueViewModel extends $Notifier<AsyncValue<Venue>> {
  AsyncValue<Venue> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Venue>, AsyncValue<Venue>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Venue>, AsyncValue<Venue>>,
              AsyncValue<Venue>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
