import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'venue.g.dart';

Venue venueFromJson(String str) => Venue.fromJson(json.decode(str));

String venueToJson(Venue data) => json.encode(data.toJson());

@JsonSerializable()
class Venue {
  @JsonKey(name: "data")
  final List<Datum> data;
  @JsonKey(name: "meta")
  final Meta meta;

  Venue({required this.data, required this.meta});

  Venue copyWith({List<Datum>? data, Meta? meta}) =>
      Venue(data: data ?? this.data, meta: meta ?? this.meta);

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);

  Map<String, dynamic> toJson() => _$VenueToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "documentId")
  final String documentId;
  @JsonKey(name: "venue")
  final VenueClass venue;
  @JsonKey(name: "court")
  final List<Court> court;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  @JsonKey(name: "publishedAt")
  final DateTime publishedAt;

  Datum({
    required this.id,
    required this.documentId,
    required this.venue,
    required this.court,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  Datum copyWith({
    int? id,
    String? documentId,
    VenueClass? venue,
    List<Court>? court,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
  }) => Datum(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    venue: venue ?? this.venue,
    court: court ?? this.court,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    publishedAt: publishedAt ?? this.publishedAt,
  );

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Court {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "venueId")
  final String venueId;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "sportId")
  final String sportId;
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "surface")
  final String surface;
  @JsonKey(name: "features")
  final List<String> features;
  @JsonKey(name: "equipment")
  final List<String> equipment;
  @JsonKey(name: "isBookable")
  final bool isBookable;
  @JsonKey(name: "hourlyRate")
  final int hourlyRate;
  @JsonKey(name: "currency")
  final String currency;
  @JsonKey(name: "images")
  final List<String> images;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;

  Court({
    required this.id,
    required this.venueId,
    required this.name,
    required this.description,
    required this.sportId,
    required this.type,
    required this.surface,
    required this.features,
    required this.equipment,
    required this.isBookable,
    required this.hourlyRate,
    required this.currency,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  Court copyWith({
    String? id,
    String? venueId,
    String? name,
    String? description,
    String? sportId,
    String? type,
    String? surface,
    List<String>? features,
    List<String>? equipment,
    bool? isBookable,
    int? hourlyRate,
    String? currency,
    List<String>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Court(
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    name: name ?? this.name,
    description: description ?? this.description,
    sportId: sportId ?? this.sportId,
    type: type ?? this.type,
    surface: surface ?? this.surface,
    features: features ?? this.features,
    equipment: equipment ?? this.equipment,
    isBookable: isBookable ?? this.isBookable,
    hourlyRate: hourlyRate ?? this.hourlyRate,
    currency: currency ?? this.currency,
    images: images ?? this.images,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Court.fromJson(Map<String, dynamic> json) => _$CourtFromJson(json);

  Map<String, dynamic> toJson() => _$CourtToJson(this);
}

@JsonSerializable()
class VenueClass {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "ownerId")
  final String ownerId;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "address")
  final String address;
  @JsonKey(name: "city")
  final String city;
  @JsonKey(name: "state")
  final String state;
  @JsonKey(name: "country")
  final String country;
  @JsonKey(name: "zipCode")
  final String zipCode;
  @JsonKey(name: "latitude")
  final double latitude;
  @JsonKey(name: "longitude")
  final double longitude;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "images")
  final List<String> images;
  @JsonKey(name: "primaryImage")
  final String primaryImage;
  @JsonKey(name: "sportIds")
  final List<String> sportIds;
  @JsonKey(name: "amenities")
  final List<String> amenities;
  @JsonKey(name: "rules")
  final List<String> rules;
  @JsonKey(name: "openingHours")
  final String openingHours;
  @JsonKey(name: "closingHours")
  final String closingHours;
  @JsonKey(name: "nonOperatingDays")
  final List<String> nonOperatingDays;
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "rating")
  final double rating;
  @JsonKey(name: "totalReviews")
  final int totalReviews;
  @JsonKey(name: "totalBookings")
  final int totalBookings;
  @JsonKey(name: "isActive")
  final bool isActive;
  @JsonKey(name: "cancellationHours")
  final int cancellationHours;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;

  VenueClass({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.email,
    required this.images,
    required this.primaryImage,
    required this.sportIds,
    required this.amenities,
    required this.rules,
    required this.openingHours,
    required this.closingHours,
    required this.nonOperatingDays,
    required this.type,
    required this.rating,
    required this.totalReviews,
    required this.totalBookings,
    required this.isActive,
    required this.cancellationHours,
    required this.createdAt,
    required this.updatedAt,
  });

  VenueClass copyWith({
    String? id,
    String? ownerId,
    String? name,
    String? description,
    String? address,
    String? city,
    String? state,
    String? country,
    String? zipCode,
    double? latitude,
    double? longitude,
    String? phone,
    String? email,
    List<String>? images,
    String? primaryImage,
    List<String>? sportIds,
    List<String>? amenities,
    List<String>? rules,
    String? openingHours,
    String? closingHours,
    List<String>? nonOperatingDays,
    String? type,
    double? rating,
    int? totalReviews,
    int? totalBookings,
    bool? isActive,
    int? cancellationHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => VenueClass(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    name: name ?? this.name,
    description: description ?? this.description,
    address: address ?? this.address,
    city: city ?? this.city,
    state: state ?? this.state,
    country: country ?? this.country,
    zipCode: zipCode ?? this.zipCode,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    images: images ?? this.images,
    primaryImage: primaryImage ?? this.primaryImage,
    sportIds: sportIds ?? this.sportIds,
    amenities: amenities ?? this.amenities,
    rules: rules ?? this.rules,
    openingHours: openingHours ?? this.openingHours,
    closingHours: closingHours ?? this.closingHours,
    nonOperatingDays: nonOperatingDays ?? this.nonOperatingDays,
    type: type ?? this.type,
    rating: rating ?? this.rating,
    totalReviews: totalReviews ?? this.totalReviews,
    totalBookings: totalBookings ?? this.totalBookings,
    isActive: isActive ?? this.isActive,
    cancellationHours: cancellationHours ?? this.cancellationHours,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory VenueClass.fromJson(Map<String, dynamic> json) =>
      _$VenueClassFromJson(json);

  Map<String, dynamic> toJson() => _$VenueClassToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "pagination")
  final Pagination pagination;

  Meta({required this.pagination});

  Meta copyWith({Pagination? pagination}) =>
      Meta(pagination: pagination ?? this.pagination);

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "page")
  final int page;
  @JsonKey(name: "pageSize")
  final int pageSize;
  @JsonKey(name: "pageCount")
  final int pageCount;
  @JsonKey(name: "total")
  final int total;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  Pagination copyWith({int? page, int? pageSize, int? pageCount, int? total}) =>
      Pagination(
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        pageCount: pageCount ?? this.pageCount,
        total: total ?? this.total,
      );

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
