// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sportsRepository)
const sportsRepositoryProvider = SportsRepositoryProvider._();

final class SportsRepositoryProvider
    extends
        $FunctionalProvider<
          SportsRemoteRepository,
          SportsRemoteRepository,
          SportsRemoteRepository
        >
    with $Provider<SportsRemoteRepository> {
  const SportsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sportsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sportsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SportsRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SportsRemoteRepository create(Ref ref) {
    return sportsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SportsRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SportsRemoteRepository>(value),
    );
  }
}

String _$sportsRepositoryHash() => r'3ab0e36802bd213a3c2b64449e5f7d7cf9187cbd';
