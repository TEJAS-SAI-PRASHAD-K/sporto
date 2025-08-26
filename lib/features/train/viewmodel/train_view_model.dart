import 'package:flutter/material.dart';
import 'package:playo/features/train/model/service_category.dart';
import 'package:playo/features/train/model/trainer.dart';

/// Simple MVVM ChangeNotifier for static demo data and interactions
class TrainViewModel extends ChangeNotifier {
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
      background: const Color(0xFFE7F6D8),
    ),
    ServiceCategory(
      id: 'yoga',
      name: 'Yoga',
      imageAsset: 'assets/images/boy_1.png',
      background: const Color(0xFFE9F8D8),
    ),
    ServiceCategory(
      id: 'fitness',
      name: 'Fitness Trainer',
      imageAsset: 'assets/images/boy_5.png',
      background: const Color(0xFFE4F5D8),
    ),
  ];

  final List<Trainer> _trainers = [
    Trainer(
      id: 't1',
      name: 'Nithin K',
      title: 'Swimming Coach',
      city: 'Bengaluru',
      location: 'Basavanagudi',
      audiences: const ['Adults', 'Kids'],
      rating: null,
      ratingCount: null,
      interestedCount: 15,
      tags: const ['TRAINER'],
      avatarAsset: 'assets/images/boy_7.png',
      bannerAsset: 'assets/images/swimming_pool.jpg',
      servicesIcons: const ['assets/images/tennis_court.png'],
      about:
          'Certified coach with 8+ years. Strength, endurance and fear-of-water programs.',
    ),
    Trainer(
      id: 't2',
      name: 'Mukesh Mahto',
      title: 'Fitness Coach',
      city: 'Bengaluru',
      location: 'Kanakapura Road',
      audiences: const ['Adults'],
      rating: null,
      ratingCount: null,
      interestedCount: 9,
      tags: const ['TRAINER'],
      avatarAsset: 'assets/images/boy_3.png',
      bannerAsset: 'assets/images/golf-club.jpg',
      servicesIcons: const ['assets/images/tennis_court.png'],
      about: 'Strength training, weight loss and functional fitness coaching.',
    ),
    Trainer(
      id: 't3',
      name: 'Richa Rawal',
      title: 'Fitness & Mobility',
      city: 'Bengaluru',
      location: 'Bengaluru',
      audiences: const ['Adults'],
      rating: null,
      ratingCount: null,
      interestedCount: 21,
      tags: const ['TRAINER'],
      avatarAsset: 'assets/images/girl_7.png',
      bannerAsset: 'assets/images/abstract_map.jpg',
      servicesIcons: const ['assets/images/tennis_court.png'],
      about: 'Mobility, injury prevention and personal training plans.',
    ),
    Trainer(
      id: 't4',
      name: 'Fix Health',
      title: 'Physiotherapy Academy',
      city: 'Bengaluru',
      location: 'Bengaluru',
      audiences: const ['Adults', 'Kids'],
      rating: 5.0,
      ratingCount: 1,
      interestedCount: 6,
      tags: const ['ACADEMY'],
      avatarAsset: 'assets/images/default.png',
      bannerAsset: 'assets/images/tennis_court.png',
      servicesIcons: const ['assets/images/tennis_court.png'],
      about: 'Online physiotherapy with personalized plans and rehab.',
    ),
  ];

  String? _selectedFilter;

  List<ServiceCategory> get categories => List.unmodifiable(_categories);
  List<Trainer> get trainers => List.unmodifiable(_trainers);
  String get selectedFilter => _selectedFilter ?? '';

  void selectFilter(String filter) {
    if (_selectedFilter == filter) {
      _selectedFilter = null;
    } else {
      _selectedFilter = filter;
    }
    notifyListeners();
  }

  List<Trainer> filteredByCategory(String? categoryId) {
    // Static demo: return all. In a real app, filter by category.
    return trainers;
  }
}
