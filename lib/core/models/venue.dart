import 'package:json_annotation/json_annotation.dart';

part 'venue.g.dart';

@JsonSerializable()
class Venue {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'lat')
  double? lat;

  @JsonKey(name: 'lng')
  double? lng;

  @JsonKey(name: 'images')
  List<String>? images;

  @JsonKey(name: 'amenities')
  List<String>? amenities;

  @JsonKey(name: 'rating')
  double? rating;

  @JsonKey(name: 'starting_price')
  double? startingPrice;

  @JsonKey(name: 'timings')
  String? timings;

  @JsonKey(name: 'is_active')
  bool? isActive;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  Venue({
    required this.id,
    required this.name,
    this.address,
    this.city,
    this.lat,
    this.lng,
    this.images,
    this.amenities,
    this.rating,
    this.startingPrice,
    this.timings,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);

  Map<String, dynamic> toJson() => _$VenueToJson(this);

  Venue copyWith({
    String? id,
    String? name,
    String? address,
    String? city,
    double? lat,
    double? lng,
    List<String>? images,
    List<String>? amenities,
    double? rating,
    double? startingPrice,
    String? timings,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    return Venue(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      images: images ?? this.images,
      amenities: amenities ?? this.amenities,
      rating: rating ?? this.rating,
      startingPrice: startingPrice ?? this.startingPrice,
      timings: timings ?? this.timings,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Venue{id: $id, name: $name, address: $address, city: $city, lat: $lat, lng: $lng, images: $images, amenities: $amenities, rating: $rating, startingPrice: $startingPrice, timings: $timings, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Venue &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          address == other.address &&
          city == other.city &&
          lat == other.lat &&
          lng == other.lng &&
          images == other.images &&
          amenities == other.amenities &&
          rating == other.rating &&
          startingPrice == other.startingPrice &&
          timings == other.timings &&
          isActive == other.isActive &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      city.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      images.hashCode ^
      amenities.hashCode ^
      rating.hashCode ^
      startingPrice.hashCode ^
      timings.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
