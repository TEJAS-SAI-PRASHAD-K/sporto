import 'dart:convert';
import 'package:playo/core/models/game.dart' as core_game;
import 'package:playo/features/play/model/game.dart' as ui_game;

class GameMappers {
  static ui_game.Game toUi(
    core_game.Game g, {
    String Function(String sportId)? sportNameResolver,
    String Function(String sportId)? sportImageResolver,
  }) {
    // Convert DB model to UI. Some fields like capacity/organizer name are mocked until schema includes them.
    final start = _combineDateAndTime(g.gameDate, g.gameTime) ?? DateTime.now();
    final sportName = sportNameResolver?.call(g.sportId) ?? g.sportId;
    final imageUrl = sportImageResolver?.call(g.sportId);
    // Parse optional rules JSON for pay & join metadata
    bool payAndJoin = false;
    double? costPerPlayer;
    int? totalPlayers;
    bool costShared = false;
    String? mappedType;
    bool gameSkill = false;
    final rules = g.gameRules;
    if (rules != null && rules.trim().isNotEmpty) {
      try {
        final Map<String, dynamic> data = json.decode(rules);
        payAndJoin = (data['pay_and_join'] as bool?) ?? false;
        final cpp = data['cost_per_player'];
        if (cpp is num) costPerPlayer = cpp.toDouble();
        final tp = data['total_players'];
        if (tp is num) totalPlayers = tp.toInt();
        costShared = (data['cost_shared'] as bool?) ?? false;
        mappedType = (data['game_type'] as String?)?.trim();
        gameSkill = (data['game_skill'] as bool?) ?? false;
      } catch (_) {
        // ignore parse errors
      }
    }

    return ui_game.Game(
      id: g.gameId,
      sportId: g.sportId,
      sport: sportName,
      type: mappedType ?? 'Regular',
      organizerName: 'You',
      startTime: start,
      endTime: start.add(const Duration(hours: 1)),
      venue: g.venueName ?? g.areaOfGame ?? '',
      distanceKm: 0,
      goingCount: g.currentPlayersCount ?? (g.playerIds?.length ?? 0),
      capacity: totalPlayers ?? g.playerIds?.length ?? 8,
      levelLabel: gameSkill ? 'Skill Required' : 'All Levels',
      mustHaveSkill: gameSkill,
      booked: false,
      sportImageUrl: imageUrl,
      isPublic: (g.gameAccessType ?? 'Public') == 'Public',
      payAndJoin: payAndJoin,
      costPerPlayer: costPerPlayer,
      totalPlayers: totalPlayers ?? g.playerIds?.length,
      costShared:
          costShared ||
          (g.equipmentRequired ?? '').toLowerCase().contains('cost shared'),
      bringYourOwnEquipment: (g.equipmentRequired ?? '').toLowerCase().contains(
        'bring',
      ),
      instructionsNote: g.notes,
    );
  }

  static DateTime? _combineDateAndTime(DateTime? date, String? time) {
    if (date == null) return null;
    if (time == null) return date;
    final parts = time.split(':');
    int h = int.tryParse(parts.elementAt(0)) ?? 0;
    int m = int.tryParse(parts.elementAt(1)) ?? 0;
    return DateTime(date.year, date.month, date.day, h, m);
  }
}
