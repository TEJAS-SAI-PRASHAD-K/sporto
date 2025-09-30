import 'package:flutter/material.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/features/play/model/game_ui_extensions.dart';
// Removed old participation repository in favor of GameViewModel
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/features/play/viewmodel/game_view_model.dart';
import 'package:playo/init_dependecies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:playo/features/play/view/pages/game_overview/add_players_page.dart';

/// Lightweight details page for quick preview from sports lists
/// Mirrors the UI fields shown in the provided screenshot:
/// - Sport title, time range, date
/// - Venue row with "Venue Booked"
/// - Players card (host + skill chip) and All players CTA
/// - Queries card (latest query preview) and All queries CTA
/// - Public/private badge
/// - Bottom bar with Send Query + Join Game
class PublicGameDetailsPage extends StatefulWidget {
  final Game game;
  const PublicGameDetailsPage({super.key, required this.game});

  @override
  State<PublicGameDetailsPage> createState() => _PublicGameDetailsPageState();
}

class _PublicGameDetailsPageState extends State<PublicGameDetailsPage> {
  GameParticipation? _myParticipation;
  bool _loading = false;

  SupabaseClient get _supabase => serviceLocator<SupabaseClient>();
  Game get game => widget.game;

  @override
  void initState() {
    super.initState();
    _loadMyParticipation();
  }

  Future<void> _loadMyParticipation() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;
      final rows = await _supabase
          .from('games_participants')
          .select()
          .eq('user_id', userId)
          .eq('game_id', game.gameId)
          .order('joined_at', ascending: false)
          .limit(1);
      if (rows.isNotEmpty) {
        setState(() {
          _myParticipation = GameParticipation.fromJson(rows.first);
        });
      }
    } catch (_) {}
  }

  bool get _isPending =>
      (_myParticipation?.participationStatus ?? '') == 'Pending';
  bool get _isJoined =>
      (_myParticipation?.participationStatus ?? '') == 'Joined';

  void _showSkillSheet(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        const options = [
          'Beginner',
          'Amateur',
          'Intermediate',
          'Advanced',
          'Professional',
        ];
        int selected = 2; // default Intermediate like screenshot
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: cs.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "What's Your ${game.sport} Skill Level?",
                        style: TextStyle(
                          color: cs.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(options.length, (i) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(options[i]),
                        subtitle: i == 0
                            ? const Text("I'm new to the sport. Baby steps...")
                            : i == 1
                            ? const Text(
                                "I've played it a couple times but it's been casual",
                              )
                            : i == 2
                            ? const Text(
                                "Been there, done that. I know what's what!",
                              )
                            : i == 3
                            ? const Text(
                                "I'm pretty awesome at it. Bring it on!",
                              )
                            : const Text('Bring me the best!'),
                        trailing: Radio<int>(
                          value: i,
                          groupValue: selected,
                          onChanged: (v) => setState(() => selected = v ?? 0),
                        ),
                        onTap: () => setState(() => selected = i),
                      );
                    }),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loading
                            ? null
                            : () async {
                                Navigator.pop(context);
                                await _sendJoinRequest();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cs.primary,
                          foregroundColor: cs.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('ALL SET! SEND REQUEST'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _sendJoinRequest() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;
    setState(() => _loading = true);
    final container = ProviderScope.containerOf(context, listen: false);
    final vm = container.read(gameViewModelProvider.notifier);
    final res = await vm.requestToJoinGame(game.gameId);
    res.when(
      data: (p) => setState(() => _myParticipation = p),
      error: (e, _) {},
      loading: () {},
    );
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _cancelRequest() async {
    final part = _myParticipation;
    if (part == null) return;
    setState(() => _loading = true);
    final container = ProviderScope.containerOf(context, listen: false);
    final vm = container.read(gameViewModelProvider.notifier);
    final res = await vm.leaveGame(part.participationId);
    res.when(
      data: (_) => setState(() => _myParticipation = null),
      error: (e, _) {},
      loading: () {},
    );
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    String _formatTime(DateTime t) {
      final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
      final m = t.minute.toString().padLeft(2, '0');
      final ampm = t.hour >= 12 ? 'PM' : 'AM';
      return '$h:$m $ampm';
    }

    String _formatRange(DateTime start, DateTime end) =>
        '${_formatTime(start)} - ${_formatTime(end)}';

    String _formatDate(DateTime t) {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return '${t.day}${_ordinal(t.day)} ${months[t.month - 1]}, ${weekdays[(t.weekday - 1) % 7]}';
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              game.sport,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              '${_formatRange(game.startTime, game.endTime)} • ${_formatDate(game.startTime)}',
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Venue
                _Card(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined, color: cs.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              game.venue,
                              style: TextStyle(
                                color: cs.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Find and tag your venue',
                              style: TextStyle(color: cs.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: () {},
                        child: const Text(
                          'TAG\nVENUE',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Players section
                Text(
                  'Players (${game.goingCount})',
                  style: TextStyle(
                    fontSize: 18,
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                _Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      game.organizerName,
                                      style: TextStyle(
                                        color: cs.onSurface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    _chip('HOST', cs),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                _levelPill('INTERMEDIATE', cs),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddPlayersPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.person_add_alt_1),
                            tooltip: 'Invite',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: _circleAction(
                          context: context,
                          label: 'All players',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                if (!_isPending && !_isJoined) ...[
                  // Queries section – hidden after request/when joined
                  Text(
                    'Queries (1)',
                    style: TextStyle(
                      fontSize: 18,
                      color: cs.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Q.', style: TextStyle(color: cs.onSurface)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'is court booked?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: cs.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 14,
                              child: Icon(Icons.person, size: 16),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Sasank M, 13 hours ago',
                              style: TextStyle(color: cs.onSurfaceVariant),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: _circleAction(
                            context: context,
                            label: 'All queries',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      game.isPublic
                          ? 'This game is Public'
                          : 'This game is Private',
                      style: TextStyle(color: cs.onSurfaceVariant),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.public, size: 18),
                  ],
                ),
              ],
            ),
          ),
          // Bottom actions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surface,
              border: Border(top: BorderSide(color: cs.outlineVariant)),
            ),
            child: SafeArea(
              top: false,
              child: _isPending
                  ? SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _loading ? null : _cancelRequest,
                        icon: const Icon(Icons.close),
                        label: const Text('CANCEL REQUEST'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                  : _isJoined
                  ? const SizedBox.shrink()
                  : Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _loading ? null : () {},
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('SEND QUERY'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _loading
                                ? null
                                : () => _showSkillSheet(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cs.primary,
                              foregroundColor: cs.onPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('JOIN GAME'),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  static String _ordinal(int n) {
    if (n >= 11 && n <= 13) return 'th';
    switch (n % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  Widget _chip(String label, ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: cs.onSurface,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _levelPill(String label, ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: cs.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _circleAction({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: cs.outlineVariant),
              color: cs.surface,
            ),
            child: const Icon(Icons.arrow_forward),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const _Card({required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: child,
    );
  }
}
