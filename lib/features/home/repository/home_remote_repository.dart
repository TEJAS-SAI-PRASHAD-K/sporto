import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:playo/core/error/failure.dart';
import 'package:playo/init_dependecies.dart';
import 'package:playo/core/models/sport.dart';
import 'package:playo/core/models/venue.dart';

part 'home_remote_repository.g.dart';

@riverpod
HomeRemoteRepository homeRemoteRepository(Ref ref) {
  final supabase = serviceLocator<SupabaseClient>();
  return HomeRemoteRepository(supabase: supabase);
}

class HomeRemoteRepository {
  final SupabaseClient supabase;

  HomeRemoteRepository({required this.supabase});

  Future<Either<Failure, List<Sport>>> listSports({int limit = 10}) async {
    try {
      final response = await supabase
          .from('sports')
          .select('sport_id, sport_name, icon_url, created_at')
          .order('sport_name')
          .limit(limit);

      final sports = (response as List).map((json) {
        // The Sport model expects these exact field names from JSON
        return Sport.fromJson(json);
      }).toList();

      return Right(sports);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint('Error fetching sports from database: ${e.toString()}');
      return Left(Failure("Failed to fetch sports"));
    }
  }

  Future<Either<Failure, List<Venue>>> listFeaturedVenues({
    int limit = 10,
  }) async {
    try {
      // Query games table to get venue information
      final response = await supabase
          .from('games')
          .select(
            'venue_id, venue_name, venue_address, venue_latitude, venue_longitude, created_at',
          )
          .not('venue_id', 'is', null)
          .not('venue_name', 'is', null)
          .order('created_at', ascending: false)
          .limit(limit * 3); // Get more to filter for unique venues

      // Extract unique venues from games
      final Map<String, Map<String, dynamic>> uniqueVenues = {};

      for (final json in (response as List)) {
        final venueId = json['venue_id'];
        if (venueId != null && !uniqueVenues.containsKey(venueId)) {
          uniqueVenues[venueId] = {
            'id': json['venue_id'],
            'name': json['venue_name'],
            'address': json['venue_address'],
            'city': null, // Not available from games table
            'lat': json['venue_latitude'],
            'lng': json['venue_longitude'],
            'images': <String>[], // Not available from games table
            'amenities': <String>[], // Not available from games table
            'rating': null, // Not available from games table
            'starting_price': null, // Not available from games table
            'timings': null, // Not available from games table
            'is_active': true, // Assume active if used in games
            'created_at': json['created_at'],
            'updated_at': json['created_at'],
          };
        }
      }

      final venues = uniqueVenues.values
          .take(limit)
          .map((venueData) => Venue.fromJson(venueData))
          .toList();

      return Right(venues);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint(
        'Error fetching featured venues from database: ${e.toString()}',
      );
      return Left(Failure("Failed to fetch featured venues"));
    }
  }

  Future<Either<Failure, List<Venue>>> searchVenues({
    required String searchQuery,
    String? sportId,
    int limit = 20,
  }) async {
    try {
      var query = supabase
          .from('games')
          .select(
            'venue_id, venue_name, venue_address, venue_latitude, venue_longitude, sport_id, created_at',
          )
          .not('venue_id', 'is', null)
          .not('venue_name', 'is', null);

      if (searchQuery.isNotEmpty) {
        query = query.ilike('venue_name', '%$searchQuery%');
      }

      if (sportId != null) {
        query = query.eq('sport_id', sportId);
      }

      final response = await query
          .order('venue_name')
          .limit(limit * 2); // Get more to filter for unique venues

      // Extract unique venues from games
      final Map<String, Map<String, dynamic>> uniqueVenues = {};

      for (final json in (response as List)) {
        final venueId = json['venue_id'];
        if (venueId != null && !uniqueVenues.containsKey(venueId)) {
          uniqueVenues[venueId] = {
            'id': json['venue_id'],
            'name': json['venue_name'],
            'address': json['venue_address'],
            'city': null, // Not available from games table
            'lat': json['venue_latitude'],
            'lng': json['venue_longitude'],
            'images': <String>[], // Not available from games table
            'amenities': <String>[], // Not available from games table
            'rating': null, // Not available from games table
            'starting_price': null, // Not available from games table
            'timings': null, // Not available from games table
            'is_active': true, // Assume active if used in games
            'created_at': json['created_at'],
            'updated_at': json['created_at'],
          };
        }
      }

      final venues = uniqueVenues.values
          .take(limit)
          .map((venueData) => Venue.fromJson(venueData))
          .toList();

      return Right(venues);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint('Error searching venues from database: ${e.toString()}');
      return Left(Failure("Failed to search venues"));
    }
  }
}
