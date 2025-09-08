// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Venue _$VenueFromJson(Map<String, dynamic> json) => Venue(
  data: (json['data'] as List<dynamic>)
      .map((e) => Datum.fromJson(e as Map<String, dynamic>))
      .toList(),
  meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
  'data': instance.data,
  'meta': instance.meta,
};

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
  id: (json['id'] as num).toInt(),
  documentId: json['documentId'] as String,
  venue: VenueClass.fromJson(json['venue'] as Map<String, dynamic>),
  court: (json['court'] as List<dynamic>)
      .map((e) => Court.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  publishedAt: DateTime.parse(json['publishedAt'] as String),
);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
  'id': instance.id,
  'documentId': instance.documentId,
  'venue': instance.venue,
  'court': instance.court,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'publishedAt': instance.publishedAt.toIso8601String(),
};

Court _$CourtFromJson(Map<String, dynamic> json) => Court(
  id: json['id'] as String,
  venueId: json['venueId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  sportId: json['sportId'] as String,
  type: json['type'] as String,
  surface: json['surface'] as String,
  features: (json['features'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  equipment: (json['equipment'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  isBookable: json['isBookable'] as bool,
  hourlyRate: (json['hourlyRate'] as num).toInt(),
  currency: json['currency'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CourtToJson(Court instance) => <String, dynamic>{
  'id': instance.id,
  'venueId': instance.venueId,
  'name': instance.name,
  'description': instance.description,
  'sportId': instance.sportId,
  'type': instance.type,
  'surface': instance.surface,
  'features': instance.features,
  'equipment': instance.equipment,
  'isBookable': instance.isBookable,
  'hourlyRate': instance.hourlyRate,
  'currency': instance.currency,
  'images': instance.images,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

VenueClass _$VenueClassFromJson(Map<String, dynamic> json) => VenueClass(
  id: json['id'] as String,
  ownerId: json['ownerId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  address: json['address'] as String,
  city: json['city'] as String,
  state: json['state'] as String,
  country: json['country'] as String,
  zipCode: json['zipCode'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  phone: json['phone'] as String,
  email: json['email'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  primaryImage: json['primaryImage'] as String,
  sportIds: (json['sportIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  amenities: (json['amenities'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  rules: (json['rules'] as List<dynamic>).map((e) => e as String).toList(),
  openingHours: json['openingHours'] as String,
  closingHours: json['closingHours'] as String,
  nonOperatingDays: (json['nonOperatingDays'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  type: json['type'] as String,
  rating: (json['rating'] as num).toDouble(),
  totalReviews: (json['totalReviews'] as num).toInt(),
  totalBookings: (json['totalBookings'] as num).toInt(),
  isActive: json['isActive'] as bool,
  cancellationHours: (json['cancellationHours'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$VenueClassToJson(VenueClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'zipCode': instance.zipCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'phone': instance.phone,
      'email': instance.email,
      'images': instance.images,
      'primaryImage': instance.primaryImage,
      'sportIds': instance.sportIds,
      'amenities': instance.amenities,
      'rules': instance.rules,
      'openingHours': instance.openingHours,
      'closingHours': instance.closingHours,
      'nonOperatingDays': instance.nonOperatingDays,
      'type': instance.type,
      'rating': instance.rating,
      'totalReviews': instance.totalReviews,
      'totalBookings': instance.totalBookings,
      'isActive': instance.isActive,
      'cancellationHours': instance.cancellationHours,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  'pagination': instance.pagination,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  pageCount: (json['pageCount'] as num).toInt(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'pageCount': instance.pageCount,
      'total': instance.total,
    };
