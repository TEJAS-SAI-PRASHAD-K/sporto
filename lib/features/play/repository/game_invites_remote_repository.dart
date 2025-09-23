import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:playo/core/error/failure.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/init_dependecies.dart';

part 'game_invites_remote_repository.g.dart';

@riverpod
GameInvitesRemoteRepository gameInvitesRemoteRepository(Ref ref) {
  final supabase = serviceLocator<SupabaseClient>();
  return GameInvitesRemoteRepository(supabase);
}

class GameInvitesRemoteRepository {
  final SupabaseClient supabase;

  GameInvitesRemoteRepository(this.supabase);

  Future<Either<Failure, GameInvite>> sendInvite(GameInvite invite) async {
    try {
      final response = await supabase
          .from('game_invites')
          .insert(invite.toJson())
          .select()
          .single();
      return Right(GameInvite.fromJson(response));
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

  Future<Either<Failure, List<GameInvite>>> listInvitesForUser(
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

  Future<Either<Failure, GameInvite>> updateInviteStatus({
    required String inviteId,
    required String status, // Pending, Accepted, Rejected, Expired
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
}
