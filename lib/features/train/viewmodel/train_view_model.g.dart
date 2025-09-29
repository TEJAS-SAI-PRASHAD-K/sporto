// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'train_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrainViewModel)
const trainViewModelProvider = TrainViewModelProvider._();

final class TrainViewModelProvider
    extends $NotifierProvider<TrainViewModel, AsyncValue<Trainer>?> {
  const TrainViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trainViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trainViewModelHash();

  @$internal
  @override
  TrainViewModel create() => TrainViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<Trainer>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<Trainer>?>(value),
    );
  }
}

String _$trainViewModelHash() => r'3ff4d99e4545f891867b56392c8d1a9740655b63';

abstract class _$TrainViewModel extends $Notifier<AsyncValue<Trainer>?> {
  AsyncValue<Trainer>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Trainer>?, AsyncValue<Trainer>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Trainer>?, AsyncValue<Trainer>?>,
              AsyncValue<Trainer>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
