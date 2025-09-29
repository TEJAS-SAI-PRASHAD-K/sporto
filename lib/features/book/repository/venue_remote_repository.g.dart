// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(venueRemoteRepository)
const venueRemoteRepositoryProvider = VenueRemoteRepositoryProvider._();

final class VenueRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          VenueRemoteRepository,
          VenueRemoteRepository,
          VenueRemoteRepository
        >
    with $Provider<VenueRemoteRepository> {
  const VenueRemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'venueRemoteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$venueRemoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<VenueRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VenueRemoteRepository create(Ref ref) {
    return venueRemoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VenueRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VenueRemoteRepository>(value),
    );
  }
}

String _$venueRemoteRepositoryHash() =>
    r'6dca06f689a920a165b187c2ca1eb77cb1a5a8e8';
