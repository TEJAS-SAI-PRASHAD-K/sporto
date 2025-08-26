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
          .eq('id', userId)
          .single();

      final user = app_user.User.fromDatabaseJson(response);
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
      // Check if user exists
      final existingUserResult = await getUserById(user.id);

      late Map<String, dynamic> response;

      if (existingUserResult.isRight()) {
        // User exists, update
        response = await supabase
            .from('users')
            .update(user.toJson())
            .eq('id', user.id)
            .select()
            .single();
      } else {
        // User doesn't exist, create
        response = await supabase
            .from('users')
            .insert(user.toJson())
            .select()
            .single();
      }

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
          .eq('id', user.id)
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
      await supabase.from('users').delete().eq('id', userId);

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
          .eq('role', role.name);

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
          'full_name.ilike.%$query%,first_name.ilike.%$query%,last_name.ilike.%$query%',
        );
      }

      if (city != null && city.isNotEmpty) {
        queryBuilder = queryBuilder.eq('city', city);
      }

      if (state != null && state.isNotEmpty) {
        queryBuilder = queryBuilder.eq('state', state);
      }

      if (sportIds != null && sportIds.isNotEmpty) {
        queryBuilder = queryBuilder.overlaps('preferred_sports', sportIds);
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
            'last_active_at': DateTime.now().toIso8601String(),
            'is_online': true,
          })
          .eq('id', userId);

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
      final updateData = <String, dynamic>{'is_online': isOnline};

      if (!isOnline) {
        updateData['last_active_at'] = DateTime.now().toIso8601String();
      }

      await supabase.from('users').update(updateData).eq('id', userId);

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
