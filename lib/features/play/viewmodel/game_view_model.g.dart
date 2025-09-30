// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GameViewModel)
const gameViewModelProvider = GameViewModelProvider._();

final class GameViewModelProvider
    extends $NotifierProvider<GameViewModel, AsyncValue<void>> {
  const GameViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameViewModelHash();

  @$internal
  @override
  GameViewModel create() => GameViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$gameViewModelHash() => r'70d3d2e70bb30da7bb2683e430981a3c101f2bdf';

abstract class _$GameViewModel extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
