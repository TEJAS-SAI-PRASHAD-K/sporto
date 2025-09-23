import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:playo/core/models/game.dart' as core_game;
import 'package:playo/features/play/model/game.dart' as ui_game;
import 'package:playo/features/play/repository/games_remote_repository.dart';
import 'package:playo/init_dependecies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class CreateGameViewModel {
  final SupabaseClient _supabase = serviceLocator<SupabaseClient>();
  late final GamesRemoteRepository _repo = GamesRemoteRepository(_supabase);

  Future<ui_game.Game> createGame({
    required String sportName,
    required String sportId,
    required String? selectedArea,
    required DateTime selectedDate,
    required TimeOfDay selectedTime,
    required TimeOfDay selectedEndTime,
    required bool isPublic,
    required String gameType,
    required bool gameSkill,
    required bool payAndJoin,
    required double? costPerPlayer,
    required int? totalPlayers,
    required bool costShared,
    required bool bringYourOwnEquipment,
    required String instructions,
  }) async {
    final currentUserId = _supabase.auth.currentUser?.id;
    if (currentUserId == null) {
      throw Exception('You must be signed in to create a game');
    }

    // Build start/end times
    final DateTime start = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    final DateTime end = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedEndTime.hour,
      selectedEndTime.minute,
    );

    // Build core game entity matching DB columns
    final gameId = const Uuid().v4();

    final dbGame = core_game.Game(
      gameId: gameId,
      organiserUserId: currentUserId,
      sportId: sportId,
      areaOfGame: selectedArea,
      gameDate: DateTime(start.year, start.month, start.day),
      gameTime: _formatTimeForDb(start),
      gameAccessType: isPublic ? 'Public' : 'Invite Only',
      currentPlayersCount: 1,
      venueName: selectedArea,
      venueId: null,
      venueAddress: selectedArea,
      venueLatitude: null,
      venueLongitude: null,
      playerIds: [currentUserId],
      waitlistUserIds: const [],
      gameRules: _buildGameRulesJson(
        payAndJoin: payAndJoin,
        costPerPlayer: costPerPlayer,
        totalPlayers: totalPlayers,
        costShared: costShared,
        gameType: gameType,
        gameSkill: gameSkill,
      ),
      equipmentRequired: bringYourOwnEquipment ? 'Bring your own' : null,
      equipmentProvided: null,
      requiresApproval: !isPublic,
      contactInformation: null,
      notes: instructions.trim().isEmpty ? null : instructions.trim(),
      viewCount: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      venuePartnerId: null,
    );

    final result = await _repo.createGame(dbGame);
    return result.match(
      (f) => throw Exception('Failed to create game: ${f.message}'),
      (saved) => ui_game.Game(
        id: saved.gameId,
        sport: sportName,
        type: gameType,
        organizerName: 'You',
        startTime: start,
        endTime: end,
        venue: selectedArea?.trim() ?? '',
        distanceKm: 0.0,
        goingCount: 1,
        capacity: totalPlayers ?? 8,
        levelLabel: gameSkill ? 'Skill Required' : 'All Levels',
        mustHaveSkill: gameSkill,
        booked: false,
        isPublic: isPublic,
        payAndJoin: payAndJoin,
        costPerPlayer: costPerPlayer,
        totalPlayers: totalPlayers,
        costShared: costShared,
        bringYourOwnEquipment: bringYourOwnEquipment,
        instructionsNote: instructions.trim().isEmpty
            ? null
            : instructions.trim(),
      ),
    );
  }

  String _formatTimeForDb(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m:00';
  }

  String _buildGameRulesJson({
    required bool payAndJoin,
    required double? costPerPlayer,
    required int? totalPlayers,
    required bool costShared,
    required String gameType,
    required bool gameSkill,
  }) {
    final map = <String, dynamic>{
      'pay_and_join': payAndJoin,
      'cost_per_player': costPerPlayer,
      'total_players': totalPlayers,
      'cost_shared': costShared,
      'game_type': gameType,
      'game_skill': gameSkill,
    }..removeWhere((k, v) => v == null);
    return jsonEncode(map);
  }
}
