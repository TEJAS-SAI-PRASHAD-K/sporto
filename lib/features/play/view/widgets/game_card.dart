import 'package:flutter/material.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/features/play/model/game_ui_extensions.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;
  const GameCard({super.key, required this.game, required this.onTap});

  String _timeRange(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    String dayLabel;
    final now = DateTime.now();
    final startDate = DateTime(
      game.startTime.year,
      game.startTime.month,
      game.startTime.day,
    );
    final today = DateTime(now.year, now.month, now.day);
    final diffDays = startDate.difference(today).inDays;
    if (diffDays == 0) {
      dayLabel = 'Today';
    } else if (diffDays == 1) {
      dayLabel = 'Tomorrow';
    } else {
      dayLabel = 'In $diffDays days';
    }
    final start = localizations.formatTimeOfDay(
      TimeOfDay.fromDateTime(game.startTime),
      alwaysUse24HourFormat: false,
    );
    return '$dayLabel, $start';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: cs.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    game.isPublic ? Icons.public : Icons.lock_outline,
                    size: 16,
                    color: cs.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    game.isPublic ? 'Public' : 'Invite Only',
                    style: TextStyle(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(width: 8),
                  _dot(cs),
                  Text(
                    _typeLabel(game),
                    style: TextStyle(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(width: 8),
                  if (game.payAndJoin) ...[
                    _dot(cs),
                    Text(
                      'Pay & join',
                      style: TextStyle(color: cs.onSurfaceVariant),
                    ),
                  ],
                  const SizedBox(width: 8),
                  _dot(cs),
                  Text(
                    game.levelLabel,
                    style: TextStyle(color: cs.onSurfaceVariant),
                  ),
                  const Spacer(),
                  Icon(Icons.more_vert, color: cs.onSurfaceVariant),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: cs.primary,
                    child: Icon(Icons.person, size: 18, color: cs.onPrimary),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${game.goingCount}/${game.capacity} Going',
                    style: TextStyle(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                game.organizerName,
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              Text(
                _timeRange(context),
                style: TextStyle(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, size: 18, color: cs.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '${game.venue}  ~${game.distanceKm.toStringAsFixed(2)} kms',
                      style: TextStyle(color: cs.onSurfaceVariant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sports,
                          size: 16,
                          color: cs.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          game.levelLabel,
                          style: TextStyle(color: cs.onSurface),
                        ),
                        if (game.mustHaveSkill) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: cs.surface,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: cs.outlineVariant),
                            ),
                            child: Text(
                              'MH',
                              style: TextStyle(
                                fontSize: 11,
                                color: cs.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (game.booked)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: cs.tertiary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'BOOKED',
                        style: TextStyle(
                          color: cs.onTertiary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _dot(ColorScheme cs) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 4),
  child: Text('•', style: TextStyle(color: cs.onSurfaceVariant)),
);

String _typeLabel(Game game) {
  final t = (game.type).trim();
  if (t.isEmpty) return 'Regular';
  final l = t.toLowerCase();
  if (l.contains('tournament')) return 'Tournament';
  if (l.contains('coach')) return 'Coaching';
  if (l.contains('regular')) return 'Regular';
  return t[0].toUpperCase() + t.substring(1);
}
