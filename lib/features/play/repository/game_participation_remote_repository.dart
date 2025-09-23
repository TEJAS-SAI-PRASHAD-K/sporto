import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:playo/core/error/failure.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/init_dependecies.dart';

part 'game_participation_remote_repository.g.dart';

@riverpod
GameParticipationRemoteRepository gameParticipationRemoteRepository(Ref ref) {
  final supabase = serviceLocator<SupabaseClient>();
  return GameParticipationRemoteRepository(supabase);
}

class GameParticipationRemoteRepository {
  final SupabaseClient supabase;
  static const _uuid = Uuid();

  GameParticipationRemoteRepository(this.supabase);

  Future<Either<Failure, GameParticipation>> joinGame({
    required String gameId,
    required String userId,
    bool isOrganiser = false,
  }) async {
    try {
      final payload = GameParticipation(
        participationId: _uuid.v4(),
        gameId: gameId,
        userId: userId,
        participationStatus: 'Joined',
        joinedAt: DateTime.now(),
        isOrganiser: isOrganiser,
        hasPaid: false,
      ).toJson();

      final response = await supabase
          .from('games_participants')
          .insert(payload)
          .select()
          .single();

      return Right(GameParticipation.fromJson(response));
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

  Future<Either<Failure, void>> leaveGame({
    required String participationId,
  }) async {
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

  Future<Either<Failure, List<GameParticipation>>> listParticipants(
    String gameId,
  ) async {
    try {
      final result = await supabase
          .from('games_participants')
          .select()
          .eq('game_id', gameId)
          .neq('participation_status', 'Cancelled')
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
}
