import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// Location model for geographical data

@JsonSerializable()
class Location {
  
  int localId;

  
  String id;
  String name;
  String? displayName;
  String? description;
  double latitude;
  double longitude;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;

  // Store enum as int for ObjectBox compatibility
  int? _type;

  // Getter and setter for enum property
  LocationType? get type => _type != null ? LocationType.values[_type!] : null;
  set type(LocationType? value) => _type = value?.index;

  String? parentLocationId;
  List<String> childLocationIds;
  bool isActive;
  int popularityScore;
  
  DateTime? createdAt;
  
  DateTime? updatedAt;

  Location({
    this.localId = 0,
    required this.id,
    required this.name,
    this.displayName,
    this.description,
    required this.latitude,
    required this.longitude,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    LocationType? type,
    this.parentLocationId,
    this.childLocationIds = const [],
    this.isActive = true,
    this.popularityScore = 0,
    this.createdAt,
    this.updatedAt,
  }) : _type = type?.index;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

enum LocationType {
  @JsonValue('country')
  country,
  @JsonValue('state')
  state,
  @JsonValue('city')
  city,
  @JsonValue('area')
  area,
  @JsonValue('landmark')
  landmark,
  @JsonValue('venue')
  venue,
  @JsonValue('custom')
  custom,
}

/// Saved locations for users

@JsonSerializable()
class SavedLocation {
  
  int localId;

  
  String id;
  String userId;
  String name;
  String? description;
  double latitude;
  double longitude;
  String? address;

  // Store enum as int for ObjectBox compatibility
  int? _type;

  // Getter and setter for enum property
  SavedLocationType? get type =>
      _type != null ? SavedLocationType.values[_type!] : null;
  set type(SavedLocationType? value) => _type = value?.index;

  bool isActive;
  
  DateTime? createdAt;
  
  DateTime? updatedAt;

  SavedLocation({
    this.localId = 0,
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.latitude,
    required this.longitude,
    this.address,
    SavedLocationType? type,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  }) : _type = type?.index;

  factory SavedLocation.fromJson(Map<String, dynamic> json) =>
      _$SavedLocationFromJson(json);
  Map<String, dynamic> toJson() => _$SavedLocationToJson(this);
}

enum SavedLocationType {
  @JsonValue('home')
  home,
  @JsonValue('work')
  work,
  @JsonValue('gym')
  gym,
  @JsonValue('club')
  club,
  @JsonValue('favorite')
  favorite,
  @JsonValue('custom')
  custom,
}
