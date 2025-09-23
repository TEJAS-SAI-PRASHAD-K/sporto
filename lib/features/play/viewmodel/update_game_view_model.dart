import 'dart:convert';
import 'package:playo/features/play/repository/games_remote_repository.dart';
import 'package:playo/init_dependecies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateGameViewModel {
  final SupabaseClient _supabase = serviceLocator<SupabaseClient>();
  late final GamesRemoteRepository _repo = GamesRemoteRepository(_supabase);

  Future<void> deleteGame(String gameId) async {
    final res = await _repo.deleteGame(gameId);
    res.match((_) => throw Exception('Failed to delete game'), (_) => null);
  }

  Future<void> updateGame({
    required String gameId,
    required bool isPublic,
    String? selectedArea,
    String? instructions,
    required bool gameSkill,
    DateTime? selectedDate,
    int? startHour,
    int? startMinute,
    // Advanced settings bundled into game_rules
    required bool payAndJoin,
    double? costPerPlayer,
    int? totalPlayers,
    required bool costShared,
    required String gameType,
    required bool bringOwnEquipment,
  }) async {
    final updates = <String, dynamic>{
      'game_access_type': isPublic ? 'Public' : 'Invite Only',
      'venue_name': selectedArea,
      'venue_address': selectedArea,
      'notes': (instructions ?? '').trim().isEmpty
          ? null
          : instructions!.trim(),
      'requires_approval': gameSkill,
    };

    if (selectedDate != null) {
      updates['game_date'] = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      ).toIso8601String();
    }
    if (startHour != null && startMinute != null) {
      final h = startHour.toString().padLeft(2, '0');
      final m = startMinute.toString().padLeft(2, '0');
      updates['game_time'] = '$h:$m:00';
    }

    final rules = <String, dynamic>{
      'pay_and_join': payAndJoin,
      'cost_per_player': costPerPlayer,
      'total_players': totalPlayers,
      'cost_shared': costShared,
      'game_type': gameType,
      'game_skill': gameSkill,
      'bring_your_own_equipment': bringOwnEquipment,
    }..removeWhere((k, v) => v == null);
    updates['game_rules'] = jsonEncode(rules);

    final either = await _repo.patchGame(gameId, updates);
    either.match((_) => throw Exception('Failed to update game'), (_) => null);
  }
}
