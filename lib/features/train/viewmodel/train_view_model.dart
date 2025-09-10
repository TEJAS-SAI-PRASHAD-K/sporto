import 'dart:ui';

import 'package:playo/core/models/trainer.dart';
import 'package:playo/features/train/model/service_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:playo/features/train/repository/trainer_remote_repository.dart';
import 'package:playo/core/providers/current_user_provider.dart';

part 'train_view_model.g.dart';

@riverpod
class TrainViewModel extends _$TrainViewModel {
  late TrainerRemoteRepository _trainerRemoteRepository;
  late CurrentUserNotifier _currentUserNotifier;
  final List<ServiceCategory> _categories = [
    ServiceCategory(
      id: 'badminton',
      name: 'Badminton',
      imageAsset: 'assets/images/girl_9.png',
      background: const Color(0xFFEADCF8),
    ),
    ServiceCategory(
      id: 'swimming',
      name: 'Swimming',
      imageAsset: 'assets/images/boy_4.png',
      background: const Color(0xFFC9F1F0),
    ),
    ServiceCategory(
      id: 'pickleball',
      name: 'Pickleball',
      imageAsset: 'assets/images/girl_12.png',
      background: const Color(0xFFF9E9CC),
    ),
    ServiceCategory(
      id: 'football',
      name: 'Football',
      imageAsset: 'assets/images/boy_8.png',
      background: const Color(0xFFC7F1EE),
    ),
    ServiceCategory(
      id: 'cricket',
      name: 'Cricket',
      imageAsset: 'assets/images/boy_7.png',
      background: const Color(0xFFD4EBFF),
    ),
    ServiceCategory(
      id: 'tennis',
      name: 'Tennis',
      imageAsset: 'assets/images/boy_6.png',
      background: const Color(0xFFEEDCF2),
    ),
    ServiceCategory(
      id: 'physio',
      name: 'Physio',
      imageAsset: 'assets/images/girl_1.png',
      background: const Color(0xFFDDF1EC),
    ),
    ServiceCategory(
      id: 'nutrition',
      name: 'Nutrition',
      imageAsset: 'assets/images/default.png',
      background: ServiceCategory.generateColorForCategory('Nutrition'),
    ),
    ServiceCategory(
      id: 'yoga',
      name: 'Yoga',
      imageAsset: 'assets/images/boy_1.png',
      background: ServiceCategory.generateColorForCategory('Yoga'),
    ),
    ServiceCategory(
      id: 'fitness',
      name: 'Fitness Trainer',
      imageAsset: 'assets/images/boy_5.png',
      background: ServiceCategory.generateColorForCategory('Fitness Trainer'),
    ),
  ];
  // Public read-only view of the built-in service categories used by the UI
  List<ServiceCategory> get categories => List.unmodifiable(_categories);
  @override
  AsyncValue<Trainer> build() {
    _trainerRemoteRepository = ref.watch(trainerRemoteRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);

    // Automatically fetch venues when the provider is created
    fetchTrainers();

    // Return loading initially
    return const AsyncValue.loading();
  }

  Future<void> fetchTrainers() async {
    state = const AsyncValue.loading();

    final res = await _trainerRemoteRepository.fetchTrainerModels();

    state = res.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (trainers) => AsyncValue.data(trainers),
    );
  }
}
