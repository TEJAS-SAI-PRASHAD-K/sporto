import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:playo/core/error/failure.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/init_dependecies.dart';

part 'games_remote_repository.g.dart';

@riverpod
GamesRemoteRepository gamesRemoteRepository(Ref ref) {
  final supabase = serviceLocator<SupabaseClient>();
  return GamesRemoteRepository(supabase);
}

class GamesRemoteRepository {
  final SupabaseClient supabase;

  GamesRemoteRepository(this.supabase);

  // Create
  Future<Either<Failure, Game>> createGame(Game game) async {
    try {
      final response = await supabase
          .from('games')
          .insert(game.toJson())
          .select()
          .single();
      final created = Game.fromJson(response);
      return Right(created);
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

  // Read
  Future<Either<Failure, Game>> getGameById(String gameId) async {
    try {
      final response = await supabase
          .from('games')
          .select()
          .eq('game_id', gameId)
          .single();
      return Right(Game.fromJson(response));
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

  Future<Either<Failure, List<Game>>> listGames({
    String? sportId,
    String? organiserUserId,
    DateTime? fromDate,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      var query = supabase.from('games').select();

      if (sportId != null && sportId.isNotEmpty) {
        query = query.eq('sport_id', sportId);
      }
      if (organiserUserId != null && organiserUserId.isNotEmpty) {
        query = query.eq('organiser_user_id', organiserUserId);
      }
      if (fromDate != null) {
        // game_date is a DATE in DB; filter using YYYY-MM-DD to avoid timezone issues
        final dateOnly = fromDate.toIso8601String().split('T').first;
        query = query.gte('game_date', dateOnly);
      }
      // Order by date/time so upcoming appear first
      final ordered = query
          .order('game_date', ascending: true)
          .order('game_time', ascending: true);

      final result = await (offset > 0
          ? ordered.limit(limit).range(offset, offset + limit - 1)
          : ordered.limit(limit));

      final items = (result as List)
          .map((e) => Game.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(items);
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

  // Update
  Future<Either<Failure, Game>> updateGame(Game game) async {
    try {
      final response = await supabase
          .from('games')
          .update(game.toJson())
          .eq('game_id', game.gameId)
          .select()
          .single();
      return Right(Game.fromJson(response));
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

  // Partial Update (patch specific fields)
  Future<Either<Failure, Game>> patchGame(
    String gameId,
    Map<String, dynamic> updates,
  ) async {
    try {
      final payload = {
        ...updates,
        'updated_at': DateTime.now().toIso8601String(),
      };
      final response = await supabase
          .from('games')
          .update(payload)
          .eq('game_id', gameId)
          .select()
          .single();
      return Right(Game.fromJson(response));
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

  // Delete
  Future<Either<Failure, void>> deleteGame(String gameId) async {
    try {
      await supabase.from('games').delete().eq('game_id', gameId);
      return Right(null);
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

  // ---------------------------------------------------------------------------
  // Game Invites (migrated & simplified from GameInvitesRemoteRepository)
  // ---------------------------------------------------------------------------

  Future<Either<Failure, GameInvite>> insertGameInvite(
    Map<String, dynamic> inviteJson,
  ) async {
    try {
      final response = await supabase
          .from('game_invites')
          .insert(inviteJson)
          .select()
          .single();
      return Right(GameInvite.fromJson(response));
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on PostgrestException catch (e) {
      return Left(Failure('Database error: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  Future<Either<Failure, List<GameInvite>>> fetchInvitesForUser(
    String userId,
  ) async {
    try {
      final result = await supabase
          .from('game_invites')
          .select()
          .eq('invitee_user_id', userId)
          .order('sent_at', ascending: false);
      final items = (result as List)
          .map((e) => GameInvite.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(items);
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on PostgrestException catch (e) {
      return Left(Failure('Database error: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  Future<Either<Failure, GameInvite>> updateGameInviteStatus({
    required String inviteId,
    required String status,
  }) async {
    try {
      final response = await supabase
          .from('game_invites')
          .update({
            'invite_status': status,
            'responded_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('invite_id', inviteId)
          .select()
          .single();
      return Right(GameInvite.fromJson(response));
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on PostgrestException catch (e) {
      return Left(Failure('Database error: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  // ---------------------------------------------------------------------------
  // Game Participation (migrated & simplified from GameParticipationRemoteRepository)
  // ---------------------------------------------------------------------------

  Future<Either<Failure, GameParticipation>> insertGameParticipation(
    Map<String, dynamic> participationJson,
  ) async {
    try {
      final response = await supabase
          .from('games_participants')
          .insert(participationJson)
          .select()
          .single();
      return Right(GameParticipation.fromJson(response));
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on PostgrestException catch (e) {
      return Left(Failure('Database error: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  Future<Either<Failure, GameParticipation>> updateGameParticipation(
    String participationId,
    Map<String, dynamic> updates,
  ) async {
    try {
      final payload = {
        ...updates,
        'updated_at': DateTime.now().toIso8601String(),
      };
      final response = await supabase
          .from('games_participants')
          .update(payload)
          .eq('participation_id', participationId)
          .select()
          .single();
      return Right(GameParticipation.fromJson(response));
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on PostgrestException catch (e) {
      return Left(Failure('Database error: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  Future<Either<Failure, List<GameParticipation>>> listParticipationsForGame(
    String gameId,
  ) async {
    try {
      final result = await supabase
          .from('games_participants')
          .select()
          .eq('game_id', gameId)
          .order('joined_at', ascending: true);
      final items = (result as List)
          .map((e) => GameParticipation.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(items);
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on PostgrestException catch (e) {
      return Left(Failure('Database error: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  Future<Either<Failure, void>> cancelParticipation(
    String participationId,
  ) async {
    try {
      await supabase
          .from('games_participants')
          .update({
            'participation_status': 'Cancelled',
            'left_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('participation_id', participationId);
      return Right(null);
    } on SocketException {
      return Left(Failure('No internet connection'));
    } on PostgrestException catch (e) {
      return Left(Failure('Database error: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}
