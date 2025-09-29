// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(trainerRemoteRepository)
const trainerRemoteRepositoryProvider = TrainerRemoteRepositoryProvider._();

final class TrainerRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          TrainerRemoteRepository,
          TrainerRemoteRepository,
          TrainerRemoteRepository
        >
    with $Provider<TrainerRemoteRepository> {
  const TrainerRemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trainerRemoteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trainerRemoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<TrainerRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TrainerRemoteRepository create(Ref ref) {
    return trainerRemoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrainerRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrainerRemoteRepository>(value),
    );
  }
}

String _$trainerRemoteRepositoryHash() =>
    r'193c035e0a5193a10402433491ecf7a0dae5c84a';
