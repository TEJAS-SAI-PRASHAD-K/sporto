// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gamesRemoteRepository)
const gamesRemoteRepositoryProvider = GamesRemoteRepositoryProvider._();

final class GamesRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          GamesRemoteRepository,
          GamesRemoteRepository,
          GamesRemoteRepository
        >
    with $Provider<GamesRemoteRepository> {
  const GamesRemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamesRemoteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gamesRemoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<GamesRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GamesRemoteRepository create(Ref ref) {
    return gamesRemoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GamesRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GamesRemoteRepository>(value),
    );
  }
}

String _$gamesRemoteRepositoryHash() =>
    r'5a27a1e56d99a22deaee7f23e54ca8384a1b1353';
