class Trainer {
  final String id;
  final String name;
  final String title; // short headline
  final String city;
  final String location;
  final List<String> audiences; // Adults, Kids
  final double? rating; // null if no rating
  final int? ratingCount; // number of ratings
  final int interestedCount; // number of people interested
  final List<String> tags; // e.g., Trainer, Academy
  final String avatarAsset; // circle avatar (can be placeholder)
  final String bannerAsset; // main cover image
  final List<String>
  servicesIcons; // paths to small service icons shown on card
  final String about;

  const Trainer({
    required this.id,
    required this.name,
    required this.title,
    required this.city,
    required this.location,
    required this.audiences,
    required this.rating,
    required this.ratingCount,
    this.interestedCount = 0,
    required this.tags,
    required this.avatarAsset,
    required this.bannerAsset,
    required this.servicesIcons,
    required this.about,
  });
}
