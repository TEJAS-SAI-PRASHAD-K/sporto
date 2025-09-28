import 'package:flutter/material.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/features/play/model/game_ui_extensions.dart';
import 'package:playo/core/services/notification_service.dart';

class UpcomingGames extends StatefulWidget {
  final List<Game> userCreatedGames;
  // When showing Upcoming tab, we also render nearby games. For Past tab, pass empty.
  final List<Game> nearbyGames;
  final VoidCallback onCreateGame;
  final Function(Game) onGameTap;
  final void Function(Game)? onGameBoardTap;
  final void Function(Game)? onInvitePlaypalsTap;
  final void Function(Game)? onJoinTap;
  final void Function(Game)? onRehostTap;
  final bool isPastMode;

  const UpcomingGames({
    super.key,
    required this.userCreatedGames,
    required this.nearbyGames,
    required this.onCreateGame,
    required this.onGameTap,
    this.onGameBoardTap,
    this.onInvitePlaypalsTap,
    this.onJoinTap,
    this.onRehostTap,
    this.isPastMode = false,
  });

  @override
  State<UpcomingGames> createState() => _UpcomingGamesState();
}

class _UpcomingGamesState extends State<UpcomingGames> {
  @override
  void initState() {
    super.initState();
    _triggerUpcomingReminders();
  }

  void _triggerUpcomingReminders() {
    final now = DateTime.now();
    final games = widget.userCreatedGames.where((g) {
      final diff = g.startTime.difference(now).inMinutes;
      return diff > 0 && diff <= 60;
    }).toList();
    for (final game in games) {
      NotificationService().showNotification(
        4,
        'Game Reminder',
        'Your ${game.sport} game at ${game.venue} starts at ${_formatTimeRange(game.startTime, game.endTime)}.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Check if there are any games at all
    final hasAnyGames =
        widget.userCreatedGames.isNotEmpty || widget.nearbyGames.isNotEmpty;

    if (!hasAnyGames) {
      // Show empty state with create game option when no games exist
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(
                Icons.sports_football,
                size: 48,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                widget.isPastMode ? 'No past games' : 'No upcoming games',
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: widget.onCreateGame,
                child: const Text('CREATE GAME'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.userCreatedGames.isNotEmpty) ...[
          ..._buildUserCreatedGrouped(colorScheme),
          const SizedBox(height: 16),
        ],
        if (widget.nearbyGames.isNotEmpty) ...[
          ..._buildNearbyGrouped(colorScheme),
        ],
      ],
    );
  }

  List<Widget> _buildUserCreatedGrouped(ColorScheme colorScheme) {
    final groups = _groupByDate(widget.userCreatedGames);
    final entries = groups.entries.toList();
    if (widget.isPastMode) {
      entries.sort((a, b) => b.key.compareTo(a.key)); // recent past first
    }
    return entries.map((entry) {
      final date = entry.key;
      final games = entry.value;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(
                _formatDate(date),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ),
            ...games.map((g) => _buildUserGameCard(g, colorScheme)),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildUserGameCard(Game game, ColorScheme colorScheme) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => widget.onGameTap(game),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Game Header with Avatar and Host Badge
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: colorScheme.surfaceVariant,
                  backgroundImage:
                      (game.sportImageUrl != null &&
                          game.sportImageUrl!.isNotEmpty)
                      ? NetworkImage(game.sportImageUrl!)
                      : null,
                  child:
                      (game.sportImageUrl == null ||
                          game.sportImageUrl!.isEmpty)
                      ? Icon(
                          Icons.sports,
                          color: colorScheme.onSurfaceVariant,
                          size: 20,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'My ${game.sport} Game',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.secondary,
                              borderRadius: BorderRadius.circular(4),
                            ),

                            child: Text(
                              'HOST',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSecondary,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        game.venue.split(',').first, // City name
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Game Details (wrap if overflow)
            Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Privacy label as one unit
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      game.isPublic ? Icons.public : Icons.lock_outline,
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      game.isPublic ? 'Public' : 'Invite Only',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                // Type
                _segment(colorScheme, _typeLabel(game)),
                // Pay and join if any
                if (game.payAndJoin) _segment(colorScheme, 'Pay & join'),
                // Level
                _segment(colorScheme, game.levelLabel),
              ],
            ),

            const SizedBox(height: 16),

            // Time and Going Count Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Time Section
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 20,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatTimeRange(game.startTime, game.endTime),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Going Count Section
                  Row(
                    children: [
                      Text(
                        '${game.goingCount.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Going',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                // Game Board Button
                Expanded(
                  child: InkWell(
                    onTap: () => widget.onGameBoardTap?.call(game),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: colorScheme.secondary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard_outlined,
                            size: 16,
                            color: colorScheme.secondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Game Board',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Right-side Action Button: Invite (Upcoming) or Re-host (Past)
                Expanded(
                  child: InkWell(
                    onTap: () => widget.isPastMode
                        ? widget.onRehostTap?.call(game)
                        : widget.onInvitePlaypalsTap?.call(game),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: colorScheme.secondary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            widget.isPastMode
                                ? Icons.replay_outlined
                                : Icons.person_add_alt_1_outlined,
                            size: 16,
                            color: colorScheme.secondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.isPastMode ? 'Re-host' : 'Invite playpals',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Instruction badges (optional)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (game.costShared)
                  _chip(
                    colorScheme,
                    label: 'Cost Shared',
                    icon: Icons.call_split,
                  ),
                if (game.bringYourOwnEquipment)
                  _chip(
                    colorScheme,
                    label: 'Bring Your Own Equipment',
                    icon: Icons.backpack_outlined,
                  ),
                if (game.payAndJoin && game.costPerPlayer != null)
                  _chip(
                    colorScheme,
                    label:
                        'INR ${game.costPerPlayer!.toStringAsFixed(0)}/Player',
                    icon: Icons.payments_outlined,
                  ),
                if (game.type.toLowerCase().contains('tournament'))
                  _chip(
                    colorScheme,
                    label: 'Tournament',
                    icon: Icons.emoji_events_outlined,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNearbyGrouped(ColorScheme colorScheme) {
    final groups = _groupByDate(widget.nearbyGames);
    return groups.entries.map((entry) {
      final date = entry.key;
      final games = entry.value;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(
                _formatDate(date),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ),
            ...games.map((g) => _buildNearbyGameCard(g, colorScheme)),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildNearbyGameCard(Game game, ColorScheme colorScheme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => widget.onGameTap(game),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Game Type and Menu
              Row(
                children: [
                  Text(
                    game.type,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.more_vert, color: colorScheme.onSurfaceVariant),
                ],
              ),

              const SizedBox(height: 12),

              // Organizer and Going Count
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: colorScheme.surfaceVariant,
                    backgroundImage:
                        (game.sportImageUrl != null &&
                            game.sportImageUrl!.isNotEmpty)
                        ? NetworkImage(game.sportImageUrl!)
                        : null,
                    child:
                        (game.sportImageUrl == null ||
                            game.sportImageUrl!.isEmpty)
                        ? Icon(
                            Icons.sports,
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          )
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${game.goingCount}/${game.capacity} Going',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Organizer Name
              Text(
                game.organizerName,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 8),

              // Game Details (wrap if overflow)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        game.isPublic ? Icons.public : Icons.lock_outline,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        game.isPublic ? 'Public' : 'Invite Only',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  _segment(colorScheme, _typeLabel(game)),
                  if (game.payAndJoin) _segment(colorScheme, 'Pay & join'),
                  _segment(colorScheme, game.levelLabel),
                ],
              ),

              const SizedBox(height: 8),

              // Time Range
              Text(
                _formatTimeRange(game.startTime, game.endTime),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 8),

              // Location
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${game.venue} ~${game.distanceKm.toStringAsFixed(2)} kms',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Level and Booked Status
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sports,
                          size: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          game.levelLabel,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        if (game.mustHaveSkill) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: colorScheme.outline.withOpacity(0.5),
                              ),
                            ),
                            child: Text(
                              'MH',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
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
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'BOOKED',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onTertiary,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (game.costShared)
                    _chip(
                      colorScheme,
                      label: 'Cost Shared',
                      icon: Icons.call_split,
                    ),
                  if (game.bringYourOwnEquipment)
                    _chip(
                      colorScheme,
                      label: 'Bring Your Own Equipment',
                      icon: Icons.backpack_outlined,
                    ),
                  if (game.payAndJoin && game.costPerPlayer != null)
                    _chip(
                      colorScheme,
                      label:
                          'INR ${game.costPerPlayer!.toStringAsFixed(0)}/Player',
                      icon: Icons.payments_outlined,
                    ),
                  if (game.type.toLowerCase().contains('tournament'))
                    _chip(
                      colorScheme,
                      label: 'Tournament',
                      icon: Icons.emoji_events_outlined,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              // Join CTA for public nearby games
              if (game.isPublic)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => widget.onJoinTap?.call(game),
                    child: const Text('JOIN'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(ColorScheme cs, {required String label, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: cs.onSurfaceVariant),
            const SizedBox(width: 6),
          ],
          Text(label, style: TextStyle(fontSize: 12, color: cs.onSurface)),
        ],
      ),
    );
  }

  // A small segment that renders a dot separator and a label, kept as a single wrap-able unit.
  Widget _segment(ColorScheme cs, String label) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      _dot(cs),
      Text(label, style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant)),
    ],
  );

  Widget _dot(ColorScheme cs) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Text('•', style: TextStyle(color: cs.onSurfaceVariant)),
  );

  String _formatDate(DateTime date) {
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatTimeRange(DateTime start, DateTime end) {
    String fmt(DateTime dt) {
      final tod = TimeOfDay.fromDateTime(dt);
      final period = tod.period == DayPeriod.am ? 'AM' : 'PM';
      final hour = tod.hourOfPeriod == 0 ? 12 : tod.hourOfPeriod;
      final minute = tod.minute.toString().padLeft(2, '0');
      return '$hour:$minute $period';
    }

    return '${fmt(start)} - ${fmt(end)}';
  }

  String _typeLabel(Game game) {
    final t = (game.type).trim();
    if (t.isEmpty) return 'Regular';
    final l = t.toLowerCase();
    if (l.contains('tournament')) return 'Tournament';
    if (l.contains('coach')) return 'Coaching';
    if (l.contains('regular')) return 'Regular';
    // Title-case first letter as a fallback
    return t[0].toUpperCase() + t.substring(1);
  }

  Map<DateTime, List<Game>> _groupByDate(List<Game> games) {
    final map = <DateTime, List<Game>>{};
    for (final g in games) {
      final d = DateTime(g.startTime.year, g.startTime.month, g.startTime.day);
      map.putIfAbsent(d, () => []);
      map[d]!.add(g);
    }
    // Sort by date ascending
    final entries = map.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return {for (var e in entries) e.key: e.value};
  }
}
