import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:playo/core/error/failure.dart';
import 'package:playo/init_dependecies.dart';

part 'booking_courts_remote_repository.g.dart';

@riverpod
BookingCourtsRemoteRepository bookingCourtsRemoteRepository(Ref ref) {
  final supabase = serviceLocator<SupabaseClient>();
  return BookingCourtsRemoteRepository(supabase);
}

class BookingCourtsRemoteRepository {
  final SupabaseClient supabase;

  BookingCourtsRemoteRepository(this.supabase);

  // TODO: Add a BookingCourt model under core/models when schema is finalized.
  // Below methods are placeholders to be wired once model exists.

  Future<Either<Failure, List<Map<String, dynamic>>>> listBookingsForUser(
    String userId,
  ) async {
    try {
      final result = await supabase
          .from('booking_courts')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      return Right((result as List).cast<Map<String, dynamic>>());
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on PostgrestException catch (e) {
      debugPrint('Supabase error: ${e.message}');
      return Left(Failure('Database error: ${e.message}'));
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}
