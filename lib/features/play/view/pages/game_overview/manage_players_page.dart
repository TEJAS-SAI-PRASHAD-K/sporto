import 'package:flutter/material.dart';
import 'package:playo/features/play/view/widgets/manage_tabs_bar.dart';
import 'package:playo/core/common/widgets/see_reputation_page.dart';
import 'package:playo/core/common/widgets/retire_bottom_sheet.dart';
import 'package:playo/features/play/view/widgets/player_card.dart';
import 'package:playo/features/play/view/widgets/game_sub_tab_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:playo/init_dependecies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/features/play/viewmodel/game_view_model.dart';
import 'package:playo/core/models/game.dart';

class ManagePlayersPage extends ConsumerStatefulWidget {
  final Game? game; // optional: pass current game to scope queries
  const ManagePlayersPage({super.key, this.game});

  @override
  ConsumerState<ManagePlayersPage> createState() => _ManagePlayersPageState();
}

class _ManagePlayersPageState extends ConsumerState<ManagePlayersPage> {
  bool _matchFull = false;
  final List<_Player> _requests = [];
  final List<_Player> _invited = [];
  final List<_Player> _playing = [];
  final List<_Player> _retired = [];

  SupabaseClient get _supabase => serviceLocator<SupabaseClient>();

  @override
  void initState() {
    super.initState();
    _refreshParticipants();
  }

  Future<void> _refreshParticipants() async {
    final g = widget.game;
    if (g == null) return;
    final vm = ref.read(gameViewModelProvider.notifier);
    final grouped = await vm.participantsByStatus(g.gameId);
    grouped.when(
      data: (map) {
        setState(() {
          _requests
            ..clear()
            ..addAll(_mapParticipants(map['Pending']));
          _playing
            ..clear()
            ..addAll(_mapParticipants(map['Joined']));
          _retired
            ..clear()
            ..addAll(_mapParticipants(map['Cancelled']));
        });
      },
      error: (e, st) {},
      loading: () {},
    );
  }

  List<_Player> _mapParticipants(List<GameParticipation>? list) {
    if (list == null) return const [];
    return list
        .map(
          (p) => _Player(
            name: p.userId,
            skill: 'NO SKILL',
            updatedAt: p.joinedAt ?? DateTime.now(),
            role: p.isOrganiser ? 'Host' : null,
            lastFive: const [],
            message: null,
            noShows: 0,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Manage',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: FittedBox(
                  child: Text(
                    'Match Full',
                    style: TextStyle(color: cs.onSurface),
                  ),
                ),
              ),
            ),
            Transform.scale(
              scale: 0.7,
              child: Switch.adaptive(
                value: _matchFull,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (v) => setState(() => _matchFull = v),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(30, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(color: cs.outlineVariant),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Icon(Icons.add, color: cs.onSurface),
              ),
            ),
          ],
          bottom: ManageTabsBar(
            requestsCount: _requests.length,
            invitedCount: _invited.length,
            playingCount: _playing.length,
            retiredCount: _retired.length,
          ),
        ),
        body: Column(
          children: [
            const GameSubTabBar(
              text: 'Badminton / Night / 18th Sep, Thu / Beginner +',
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  // Requests
                  _buildRequestsTab(context),
                  // Invited
                  _buildInvitedTab(context),
                  // Playing
                  _buildPlayingTab(context),
                  // Retired
                  _buildRetiredTab(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsTab(BuildContext context) {
    if (_requests.isEmpty) return _emptyList(context, 'No requests');
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: _requests.length,
      itemBuilder: (_, i) {
        final p = _requests[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PlayerCard(
            avatarInitials: p.initials,
            name: p.name,
            rightTimeText: _timeAgo(p.updatedAt),
            skillLabel: p.skill,
            roleChip: p.role,
            lastFive: p.lastFive,
            message: p.message,
            noShows: p.noShows,
            onSeeReputation: () => openSeeReputation(
              context,
              playerName: p.name,
              noShowsLast15: p.noShows,
            ),
            secondaryLabel: 'RETIRE',
            onSecondary: () async {
              final msg = await showRetireBottomSheet(
                context,
                playerName: p.name,
              );
              if (msg != null) {
                // TODO: send `msg` to backend along with retire action
                _retireFrom(_requests, i);
              }
            },
            primaryLabel: 'ACCEPT',
            primaryType: PlayerPrimaryButtonType.primary,
            onPrimary: () => _acceptRequest(i),
          ),
        );
      },
    );
  }

  Widget _buildInvitedTab(BuildContext context) {
    if (_invited.isEmpty) return _emptyList(context, 'No invited players');
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: _invited.length,
      itemBuilder: (_, i) {
        final p = _invited[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PlayerCard(
            avatarInitials: p.initials,
            name: p.name,
            rightTimeText: _timeAgo(p.updatedAt),
            skillLabel: p.skill,
            roleChip: p.role,
            noShows: p.noShows,
            onSeeReputation: () => openSeeReputation(
              context,
              playerName: p.name,
              noShowsLast15: p.noShows,
            ),
            secondaryLabel: 'RETIRE',
            onSecondary: () async {
              final msg = await showRetireBottomSheet(
                context,
                playerName: p.name,
              );
              if (msg != null) {
                // TODO: send `msg` to backend along with retire action
                _retireFrom(_invited, i);
              }
            },
            primaryLabel: 'REMIND',
            primaryType: PlayerPrimaryButtonType.alert,
            onPrimary: () => _snack('Reminder sent to ${p.name}'),
          ),
        );
      },
    );
  }

  Widget _buildPlayingTab(BuildContext context) {
    if (_playing.isEmpty) return _emptyList(context, 'No one is playing');
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: _playing.length,
      itemBuilder: (_, i) {
        final p = _playing[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PlayerCard(
            avatarInitials: p.initials,
            name: p.name,
            rightTimeText: _timeAgo(p.updatedAt),
            skillLabel: p.skill,
            roleChip: p.role,
            noShows: p.noShows,
            onSeeReputation: () => openSeeReputation(
              context,
              playerName: p.name,
              noShowsLast15: p.noShows,
            ),
            secondaryLabel: 'RETIRE',
            onSecondary: () async {
              final msg = await showRetireBottomSheet(
                context,
                playerName: p.name,
              );
              if (msg != null) {
                // TODO: send `msg` to backend along with retire action
                _retireFrom(_playing, i);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildRetiredTab(BuildContext context) {
    if (_retired.isEmpty) return _emptyList(context, 'No retired players');
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: _retired.length,
      itemBuilder: (_, i) {
        final p = _retired[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PlayerCard(
            avatarInitials: p.initials,
            name: p.name,
            rightTimeText: _timeAgo(p.updatedAt),
            skillLabel: p.skill,
            roleChip: p.role,
            noShows: p.noShows,
            onSeeReputation: () => openSeeReputation(
              context,
              playerName: p.name,
              noShowsLast15: p.noShows,
            ),
          ),
        );
      },
    );
  }

  Future<void> _acceptRequest(int index) async {
    final g = widget.game;
    if (g == null) return;
    // Assuming player name is actually user_id for now; in real code map to id
    final userId = _requests[index].name;
    try {
      // Query minimal participation id
      final rows = await _supabase
          .from('games_participants')
          .select('participation_id')
          .eq('game_id', g.gameId)
          .eq('user_id', userId)
          .eq('participation_status', 'Pending')
          .limit(1);
      if (rows.isEmpty) return;
      final participationId = rows.first['participation_id'] as String;
      final vm = ref.read(gameViewModelProvider.notifier);
      final res = await vm.acceptJoinRequest(participationId);
      res.when(
        data: (_) async {
          _snack('Accepted $userId');
          await _refreshParticipants();
        },
        error: (e, st) => _snack('Failed: $e'),
        loading: () {},
      );
    } catch (e) {
      _snack('Failed to accept');
    }
  }

  void _retireFrom(List<_Player> list, int index) {
    final p = list.removeAt(index);
    setState(() {
      _retired.add(p);
    });
    _snack('Retired ${p.name}');
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays >= 1)
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    if (diff.inHours >= 1) return '${diff.inHours} hours ago';
    if (diff.inMinutes >= 1) return '${diff.inMinutes} minutes ago';
    return 'moments ago';
  }

  Widget _emptyList(BuildContext context, String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

// _GameSummaryBar moved to reusable GameSubTabBar in widgets.

class _Player {
  final String name;
  final String? role;
  final String skill; // NO SKILL / INTERMEDIATE / PROFESSIONAL
  final List<String> lastFive; // e.g., X list
  final String? message;
  final int noShows;
  final DateTime updatedAt;
  _Player({
    required this.name,
    required this.skill,
    required this.updatedAt,
    this.role,
    this.lastFive = const [],
    this.message,
    this.noShows = 0,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r"\s+"));
    return parts
        .take(2)
        .map((e) => e.isNotEmpty ? e[0].toUpperCase() : '')
        .join();
  }
}
