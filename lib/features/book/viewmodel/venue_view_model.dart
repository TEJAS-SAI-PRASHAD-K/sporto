import 'package:playo/core/models/venue.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:playo/features/book/repository/venue_remote_repository.dart';

part 'venue_view_model.g.dart';

@riverpod
class VenueViewModel extends _$VenueViewModel {
  late VenueRemoteRepository _venueRemoteRepository;
  // Note: _currentUserNotifier available for future user-specific features

  @override
  AsyncValue<Venue> build() {
    _venueRemoteRepository = ref.watch(venueRemoteRepositoryProvider);
    // _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);

    // Automatically fetch venues when the provider is created
    fetchVenues();

    // Return loading initially
    return const AsyncValue.loading();
  }

  Future<void> fetchVenues() async {
    state = const AsyncValue.loading();

    final res = await _venueRemoteRepository.fetchVenueModels();

    state = res.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (venues) => AsyncValue.data(venues),
    );
  }
}
