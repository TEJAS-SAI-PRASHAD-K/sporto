// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_participation_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gameParticipationRemoteRepository)
const gameParticipationRemoteRepositoryProvider =
    GameParticipationRemoteRepositoryProvider._();

final class GameParticipationRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          GameParticipationRemoteRepository,
          GameParticipationRemoteRepository,
          GameParticipationRemoteRepository
        >
    with $Provider<GameParticipationRemoteRepository> {
  const GameParticipationRemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameParticipationRemoteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$gameParticipationRemoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<GameParticipationRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GameParticipationRemoteRepository create(Ref ref) {
    return gameParticipationRemoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameParticipationRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameParticipationRemoteRepository>(
        value,
      ),
    );
  }
}

String _$gameParticipationRemoteRepositoryHash() =>
    r'37283b74b6e71ae0d3ed1e590a8f6807be0f2625';
