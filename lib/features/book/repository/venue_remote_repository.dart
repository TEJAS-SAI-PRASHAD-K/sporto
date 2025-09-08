import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:playo/core/constants/server_constants.dart';
import 'package:playo/core/models/venue.dart';
import 'package:playo/init_dependecies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:playo/core/error/failure.dart';

part 'venue_remote_repository.g.dart';

@riverpod
VenueRemoteRepository venueRemoteRepository(Ref ref) {
  return VenueRemoteRepository(httpClient: serviceLocator<http.Client>());
}

class VenueRemoteRepository {
  final http.Client httpClient;

  VenueRemoteRepository({required this.httpClient});

  Future<Either<Failure, Venue>> fetchVenueModels() async {
    try {
      final uri = Uri.parse("${ServerConstants.strapiBaseUrl}/venue-models");
      final res = await httpClient.get(uri);

      if (res.statusCode == 200) {

        final venues = venueFromJson(res.body);

        return Right(venues);
      } else {
        return Left(Failure("Error: ${res.statusCode}"));
      }
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint("fetchVenueModels error: $e");
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}
