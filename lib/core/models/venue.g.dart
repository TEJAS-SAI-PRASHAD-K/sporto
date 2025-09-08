// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Venue _$VenueFromJson(Map<String, dynamic> json) => Venue(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String?,
  city: json['city'] as String?,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  amenities: (json['amenities'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  rating: (json['rating'] as num?)?.toDouble(),
  startingPrice: (json['starting_price'] as num?)?.toDouble(),
  timings: json['timings'] as String?,
  isActive: json['is_active'] as bool?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'city': instance.city,
  'lat': instance.lat,
  'lng': instance.lng,
  'images': instance.images,
  'amenities': instance.amenities,
  'rating': instance.rating,
  'starting_price': instance.startingPrice,
  'timings': instance.timings,
  'is_active': instance.isActive,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
