import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/home_remote_repository.dart';
import 'package:playo/core/models/sport.dart';
import 'package:playo/core/models/venue.dart';

part 'home_view_model.g.dart';

@immutable
class HomeState {
  final List<Sport> sports;
  final List<Venue> featuredVenues;

  const HomeState({this.sports = const [], this.featuredVenues = const []});

  HomeState copyWith({List<Sport>? sports, List<Venue>? featuredVenues}) {
    return HomeState(
      sports: sports ?? this.sports,
      featuredVenues: featuredVenues ?? this.featuredVenues,
    );
  }
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  AsyncValue<HomeState> build() {
    return const AsyncValue.data(HomeState());
  }

  Future<void> loadHomeData({String? city}) async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.read(homeRemoteRepositoryProvider);

      // Load sports and featured venues in parallel
      final sportsResult = await repository.listSports();
      final venuesResult = await repository.listFeaturedVenues();

      if (sportsResult case Left(value: final failure)) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return;
      }

      if (venuesResult case Left(value: final failure)) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return;
      }

      final sports = sportsResult.fold((l) => <Sport>[], (r) => r);
      final venues = venuesResult.fold((l) => <Venue>[], (r) => r);

      final homeState = HomeState(sports: sports, featuredVenues: venues);

      state = AsyncValue.data(homeState);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> refreshData({String? city}) async {
    await loadHomeData(city: city);
  }
}
