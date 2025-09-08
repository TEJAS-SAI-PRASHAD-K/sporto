import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:playo/core/error/failure.dart';
import 'package:playo/core/models/sport.dart';
import 'package:playo/init_dependecies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sport_remote_repository.g.dart';

@riverpod
SportsRemoteRepository sportsRepository(Ref ref) {
  final supabase = serviceLocator<SupabaseClient>();
  return SportsRemoteRepository(supabase);
}

class SportsRemoteRepository {
  final SupabaseClient supabase;

  SportsRemoteRepository(this.supabase);

  Future<Either<Failure, List<Sport>>> fetchAllSports() async {
    try {
      final response = await supabase.from('sports').select();

      // Supabase returns a List<Map<String, dynamic>>; map each item to Sport
      final sports = (response as List)
          .map((e) => Sport.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(sports);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on PostgrestException catch (e) {
      debugPrint('Supabase error: ${e.message}');
      return Left(Failure("Database error: ${e.message}"));
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}
