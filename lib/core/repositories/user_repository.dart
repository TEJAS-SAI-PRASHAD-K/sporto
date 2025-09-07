import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:playo/core/error/failure.dart';
import 'package:playo/core/models/user.dart' as app_user;
import 'package:playo/init_dependecies.dart';

part 'user_repository.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final supabase = serviceLocator<SupabaseClient>();
  return UserRepository(supabase);
}

class UserRepository {
  final SupabaseClient supabase;

  UserRepository(this.supabase);

  Future<Either<Failure, app_user.User>> getUserById(String userId) async {
    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('user_id', userId)
          .single();

      final user = app_user.User.fromJson(response);
      return Right(user);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } on PostgrestException catch (e) {
      debugPrint('Supabase error: ${e.message}');
      if (e.code == 'PGRST116') {
        // No rows returned - user doesn't exist
        return Left(Failure("User not found"));
      }
      return Left(Failure("Database error: ${e.message}"));
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, app_user.User>> createOrUpdateUser(
    app_user.User user,
  ) async {
    try {
      // Upsert avoids a pre-select and works with both insert/update when RLS allows both
      final response = await supabase
          .from('users')
          .upsert(user.toJson(), onConflict: 'user_id')
          .select()
          .single();

      final savedUser = app_user.User.fromJson(response);
      return Right(savedUser);
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

  Future<Either<Failure, app_user.User>> updateUser(app_user.User user) async {
    try {
      final response = await supabase
          .from('users')
          .update(user.toJson())
          .eq('user_id', user.userId)
          .select()
          .single();

      final updatedUser = app_user.User.fromJson(response);
      return Right(updatedUser);
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

  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      await supabase.from('users').delete().eq('user_id', userId);

      return Right(null);
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

  Future<Either<Failure, List<app_user.User>>> getUsersByRole(
    app_user.UserRole role,
  ) async {
    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('user_role', role.name);

      final users = (response as List)
          .map((userData) => app_user.User.fromJson(userData))
          .toList();

      return Right(users);
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

  Future<Either<Failure, List<app_user.User>>> searchUsers({
    String? query,
    String? city,
    String? state,
    List<String>? sportIds,
    int? limit = 20,
    int? offset = 0,
  }) async {
    try {
      var queryBuilder = supabase.from('users').select();

      if (query != null && query.isNotEmpty) {
        queryBuilder = queryBuilder.or(
          'first_name.ilike.%$query%,last_name.ilike.%$query%',
        );
      }

      if (city != null && city.isNotEmpty) {
        queryBuilder = queryBuilder.eq('city', city);
      }

      if (state != null && state.isNotEmpty) {
        queryBuilder = queryBuilder.eq('state', state);
      }

      if (sportIds != null && sportIds.isNotEmpty) {
        queryBuilder = queryBuilder.overlaps('favorite_sports', sportIds);
      }

      // Apply limit and range
      final finalQuery = queryBuilder.limit(limit ?? 20);

      final response = await (offset != null && offset > 0
          ? finalQuery.range(offset, offset + (limit ?? 20) - 1)
          : finalQuery);

      final users = (response as List)
          .map((userData) => app_user.User.fromJson(userData))
          .toList();

      return Right(users);
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

  Future<Either<Failure, void>> updateUserLastActive(String userId) async {
    try {
      await supabase
          .from('users')
          .update({
            // TODO: add last_active_at/is_online columns if needed in schema
            // Keeping method for compatibility; no-op update to avoid errors if columns don't exist
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('user_id', userId);

      return Right(null);
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

  Future<Either<Failure, void>> updateUserOnlineStatus({
    required String userId,
    required bool isOnline,
  }) async {
    try {
      // TODO: add is_online/last_active_at if needed; update updated_at for now
      final updateData = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };
      await supabase.from('users').update(updateData).eq('user_id', userId);

      return Right(null);
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
