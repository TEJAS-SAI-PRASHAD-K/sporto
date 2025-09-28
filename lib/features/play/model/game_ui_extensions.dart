import 'dart:convert' as convert;
import 'package:playo/core/models/game.dart' as core;
import 'package:playo/features/play/model/sport_registry.dart';

// UI convenience getters for core Game
extension GameUi on core.Game {
  // Stable UI id
  String get id => gameId;

  // Sport display name should be resolved elsewhere; fallback to sportId
  String get sport => SportRegistry.nameFor(sportId);

  // Type is stored inside game_rules JSON under 'game_type'
  String get type => _rules['game_type'] as String? ?? 'Regular';

  // Organizer display name is not in core model; use placeholder
  String get organizerName => 'You';

  // Start and end time
  DateTime get startTime {
    final base = _combineDateAndTime(gameDate, gameTime);
    return base ?? DateTime.now();
  }

  DateTime get endTime => startTime.add(const Duration(hours: 1));

  // Venue label
  String get venue => (venueName ?? areaOfGame ?? venueAddress ?? '').trim();

  // Distance not available in core
  double get distanceKm => 0.0;

  // Going/capacity
  int get goingCount => currentPlayersCount ?? (playerIds?.length ?? 0);

  int get capacity =>
      (_rules['total_players'] as num?)?.toInt() ?? (playerIds?.length ?? 8);

  // Level/skill
  String get levelLabel => mustHaveSkill ? 'Skill Required' : 'All Levels';
  bool get mustHaveSkill => (_rules['game_skill'] as bool?) ?? false;

  bool get booked => false; // no booking flag in core model yet

  // Sport image not in core; allow resolver to override; fallback empty
  String? get sportImageUrl => SportRegistry.imageFor(sportId).isEmpty
      ? null
      : SportRegistry.imageFor(sportId);

  // Privacy
  bool get isPublic => (gameAccessType ?? 'Public') == 'Public';

  // Pay & Join
  bool get payAndJoin => (_rules['pay_and_join'] as bool?) ?? false;
  double? get costPerPlayer => (_rules['cost_per_player'] as num?)?.toDouble();
  int? get totalPlayers => (_rules['total_players'] as num?)?.toInt();
  bool get costShared =>
      (_rules['cost_shared'] as bool?) ??
      ((equipmentRequired ?? '').toLowerCase().contains('cost shared'));

  bool get bringYourOwnEquipment =>
      (equipmentRequired ?? '').toLowerCase().contains('bring');

  String? get instructionsNote => (notes ?? '').isEmpty ? null : notes;

  // -------- helpers --------
  Map<String, dynamic> get _rules {
    final raw = gameRules;
    if (raw == null || raw.trim().isEmpty) return const {};
    try {
      return convert.jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return const {};
    }
  }

  DateTime? _combineDateAndTime(DateTime? date, String? time) {
    if (date == null) return null;
    if (time == null || time.isEmpty) return date;
    final parts = time.split(':');
    final h = int.tryParse(parts[0]) ?? 0;
    final m = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return DateTime(date.year, date.month, date.day, h, m);
  }
}
