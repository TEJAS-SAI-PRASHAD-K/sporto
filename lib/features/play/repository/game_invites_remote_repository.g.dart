// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_invites_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gameInvitesRemoteRepository)
const gameInvitesRemoteRepositoryProvider =
    GameInvitesRemoteRepositoryProvider._();

final class GameInvitesRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          GameInvitesRemoteRepository,
          GameInvitesRemoteRepository,
          GameInvitesRemoteRepository
        >
    with $Provider<GameInvitesRemoteRepository> {
  const GameInvitesRemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameInvitesRemoteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameInvitesRemoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<GameInvitesRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GameInvitesRemoteRepository create(Ref ref) {
    return gameInvitesRemoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameInvitesRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameInvitesRemoteRepository>(value),
    );
  }
}

String _$gameInvitesRemoteRepositoryHash() =>
    r'8d28ac1aa933e42e1466ee85ac82e588cadd1d58';
