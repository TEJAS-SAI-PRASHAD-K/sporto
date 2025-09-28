import 'package:flutter/material.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/features/play/model/game_ui_extensions.dart';
import 'package:playo/init_dependecies.dart';
import 'package:playo/core/repositories/user_repository.dart';

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
                  _OrganizerAvatar(userId: game.organiserUserId, radius: 18),
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
              _OrganizerInfo(userId: game.organiserUserId),
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

class _OrganizerInfo extends StatefulWidget {
  final String userId;
  const _OrganizerInfo({required this.userId});

  @override
  State<_OrganizerInfo> createState() => _OrganizerInfoState();
}

class _OrganizerInfoState extends State<_OrganizerInfo> {
  static final Map<String, _OrgData> _cache = {};
  String _name = '';
  String _avatarUrl = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant _OrganizerInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userId != widget.userId) {
      _name = '';
      _avatarUrl = '';
      _loading = true;
      _load();
    }
  }

  Future<void> _load() async {
    final cached = _cache[widget.userId];
    if (cached != null) {
      setState(() {
        _name = cached.name;
        _avatarUrl = cached.avatarUrl;
        _loading = false;
      });
      return;
    }
    try {
      final repo = UserRepository(serviceLocator());
      final either = await repo.getUserById(widget.userId);
      either.match(
        (failure) {
          if (mounted) {
            setState(() {
              _name = '';
              _avatarUrl = '';
              _loading = false;
            });
          }
        },
        (user) {
          final first = user.firstName.trim();
          final last = (user.lastName ?? '').trim();
          final display = [first, last].where((s) => s.isNotEmpty).join(' ');
          final avatar = (user.avatarUrl ?? '').trim();
          _cache[widget.userId] = _OrgData(name: display, avatarUrl: avatar);
          if (mounted) {
            setState(() {
              _name = display;
              _avatarUrl = avatar;
              _loading = false;
            });
          }
        },
      );
    } catch (_) {
      if (mounted) {
        setState(() {
          _name = '';
          _avatarUrl = '';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (_loading) return const SizedBox(height: 24);
    if (_name.isEmpty) return const SizedBox.shrink();
    final initials = _name
        .split(' ')
        .where((p) => p.isNotEmpty)
        .take(2)
        .map((p) => p[0].toUpperCase())
        .join();
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: cs.surfaceContainerHighest,
          backgroundImage: _avatarUrl.isNotEmpty
              ? NetworkImage(_avatarUrl)
              : null,
          child: _avatarUrl.isEmpty
              ? Text(
                  initials,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            _name,
            style: TextStyle(color: cs.onSurfaceVariant),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _OrgData {
  final String name;
  final String avatarUrl;
  const _OrgData({required this.name, required this.avatarUrl});
}

class _OrganizerAvatar extends StatefulWidget {
  final String userId;
  final double radius;
  const _OrganizerAvatar({required this.userId, this.radius = 18});

  @override
  State<_OrganizerAvatar> createState() => _OrganizerAvatarState();
}

class _OrganizerAvatarState extends State<_OrganizerAvatar> {
  static final Map<String, String> _avatarCache = {};
  String _avatarUrl = '';
  String _name = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant _OrganizerAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userId != widget.userId) {
      _avatarUrl = '';
      _name = '';
      _loading = true;
      _load();
    }
  }

  Future<void> _load() async {
    final cached = _avatarCache[widget.userId];
    if (cached != null) {
      setState(() {
        _avatarUrl = cached;
        _loading = false;
      });
      return;
    }
    try {
      final repo = UserRepository(serviceLocator());
      final either = await repo.getUserById(widget.userId);
      either.match(
        (_) {
          if (mounted) setState(() => _loading = false);
        },
        (user) {
          final url = (user.avatarUrl ?? '').trim();
          _avatarCache[widget.userId] = url;
          if (mounted) {
            setState(() {
              _avatarUrl = url;
              _name = [
                user.firstName.trim(),
                (user.lastName ?? '').trim(),
              ].where((s) => s.isNotEmpty).join(' ');
              _loading = false;
            });
          }
        },
      );
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (_loading) {
      return CircleAvatar(
        radius: widget.radius,
        backgroundColor: cs.primary,
        child: Icon(Icons.person, size: widget.radius, color: cs.onPrimary),
      );
    }
    final initials = _name
        .split(' ')
        .where((p) => p.isNotEmpty)
        .take(2)
        .map((p) => p[0].toUpperCase())
        .join();
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: cs.primary,
      backgroundImage: _avatarUrl.isNotEmpty ? NetworkImage(_avatarUrl) : null,
      child: _avatarUrl.isEmpty
          ? Text(
              initials.isEmpty ? '?' : initials,
              style: TextStyle(
                fontSize: widget.radius * 0.8,
                fontWeight: FontWeight.w600,
                color: cs.onPrimary,
              ),
            )
          : null,
    );
  }
}
