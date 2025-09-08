import 'package:playo/core/models/sport.dart';
import 'package:playo/features/onboarding/repository/sport_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:playo/core/providers/current_user_provider.dart';

part 'sports_provider.g.dart';

@riverpod
class SportsViewModel extends _$SportsViewModel {
  late SportsRemoteRepository _sportsRemoteRepository;
late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<List<Sport>> build() {
    _sportsRemoteRepository = ref.watch(sportsRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);

    // Automatically fetch venues when the provider is created
    fetchVenues();

    // Return loading initially
    return const AsyncValue.loading();
  }

  Future<void> fetchVenues() async {
    state = const AsyncValue.loading();

    final res = await _sportsRemoteRepository.fetchAllSports();

    state = res.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (venues) => AsyncValue.data(venues),
    );
  }
}
