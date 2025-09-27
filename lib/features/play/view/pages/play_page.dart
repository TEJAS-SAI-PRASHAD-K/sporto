import 'package:flutter/material.dart';
import 'package:playo/core/common/widgets/main_app_bar.dart';
import 'package:playo/features/more/view/pages/my_bookings_page.dart';
import 'package:playo/features/play/view/pages/create_game_page.dart';
import 'package:provider/provider.dart';
import 'package:playo/features/play/viewmodel/play_page_viewmodel.dart';
import 'package:playo/features/play/view/widgets/play_tabs_bar.dart';
import 'package:playo/features/play/view/widgets/play_sub_tabs_bar.dart';
import 'package:playo/features/play/view/widgets/empty_games_widget.dart';
import 'package:playo/features/play/view/widgets/menu_overlay.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/features/play/model/game_ui_extensions.dart';
import 'package:playo/features/play/view/widgets/game_card.dart';
import 'package:playo/features/play/view/pages/game_overview/game_overview_page.dart';
import 'package:playo/features/play/view/pages/game_board_page.dart';
import 'package:playo/features/play/view/pages/game_overview/add_players_page.dart';
import 'package:playo/features/play/view/widgets/upcoming_games.dart';
import 'package:playo/features/play/repository/games_remote_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:playo/init_dependecies.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayPageViewModel(),
      child: const PlayPageBody(),
    );
  }
}

class PlayPageBody extends StatefulWidget {
  const PlayPageBody({super.key});

  @override
  State<PlayPageBody> createState() => _PlayPageBodyState();
}

class _PlayPageBodyState extends State<PlayPageBody> {
  OverlayEntry? _menuOverlay;
  // Local state to hold newly created games so Upcoming updates immediately
  final List<Game> _localUserCreated = [];

  @override
  void initState() {
    super.initState();
    // Initial refresh
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<PlayPageViewModel>(context, listen: false);
      vm.refreshUpcoming();
    });
  }

  void _replaceInList(List<Game> list, Game updated) {
    final idx = list.indexWhere((g) => g.id == updated.id);
    if (idx != -1) list[idx] = updated;
  }

  // Merge local optimistic games with fetched ones, ensuring uniqueness by id
  List<Game> _combinedUserCreated(PlayPageViewModel vm) {
    final seen = <String>{};
    final merged = <Game>[];
    void add(Game g) {
      if (seen.add(g.id)) merged.add(g);
    }

    for (final g in _localUserCreated) {
      add(g);
    }
    for (final g in vm.userCreatedGames) {
      add(g);
    }
    return merged;
  }

  void _onGameUpdated(Game updated) {
    setState(() {
      // Update local created list
      _replaceInList(_localUserCreated, updated);
      // Update provider-backed calendar list (user created)
      final vm = Provider.of<PlayPageViewModel>(context, listen: false);
      _replaceInList(vm.userCreatedGames, updated);
      _replaceInList(vm.currentSportGames, updated);
    });
  }

  Future<void> _openCreateGame() async {
    final created = await Navigator.of(context).push<Game>(
      MaterialPageRoute(builder: (context) => const CreateGamePage()),
    );
    if (created != null) {
      setState(() {
        final exists = _localUserCreated.any((g) => g.id == created.id);
        if (!exists) {
          _localUserCreated.insert(0, created);
        }
      });
      // Switch to Calendar > Upcoming to show the newly created game
      final vm = Provider.of<PlayPageViewModel>(context, listen: false);
      vm.setTabIndex(0);
      await vm.refreshUpcoming();
      // Reconcile: remove any locally-added game that now exists in VM list
      setState(() {
        _localUserCreated.removeWhere(
          (g) => vm.userCreatedGames.any((u) => u.id == g.id),
        );
      });
    }
  }

  Future<void> _joinPublicGame(Game game) async {
    try {
      final supabase = serviceLocator<SupabaseClient>();
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;
      final repo = GamesRemoteRepository(supabase);
      final res = await repo.addPlayer(game.id, userId);
      res.match(
        (_) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Failed to join game')));
        },
        (_) async {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Joined game')));
          // Refresh upcoming to reflect updated counts
          final vm = Provider.of<PlayPageViewModel>(context, listen: false);
          await vm.refreshUpcoming();
          setState(() {});
        },
      );
    } catch (_) {}
  }

  void _showMenu(BuildContext ctx, PlayPageViewModel vm) {
    final RenderBox box = ctx.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);

    _menuOverlay = MenuOverlay.build(
      top: position.dy + 50,
      right: 12,
      actions: vm.menuActions,
      onClose: _hideMenu,
      onActionTap: (action) async {
        switch (action.id) {
          case PlayPageViewModel.actCreateGame:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => CreateGamePage()),
            );
            break;
          case PlayPageViewModel.actShareCalendar:
            _showShareCalendarSheet(vm);
            break;
          case PlayPageViewModel.actInvitePlaypals:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => AddPlayersPage()),
            );
            break;
          case PlayPageViewModel.actMyBookings:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => MyBookingsPage()),
            );
            break;
          case PlayPageViewModel.actFilter:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => CreateGamePage()),
            );
            break;
          case PlayPageViewModel.actSort:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => CreateGamePage()),
            );
            break;
        }
      },
    );

    Overlay.of(context).insert(_menuOverlay!);
  }

  void _hideMenu() {
    _menuOverlay?.remove();
    _menuOverlay = null;
  }

  void _showShareCalendarSheet(PlayPageViewModel vm) {
    final city = vm.selectedCity;
    final link = 'https://playo.app/calendar?city=${Uri.encodeComponent(city)}';
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Share Calendar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Share your $city game calendar with friends',
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: cs.surfaceContainer,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cs.outlineVariant),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        link,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: cs.onSurface),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Copy link',
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: link));
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Link copied')),
                          );
                        }
                      },
                      icon: const Icon(Icons.copy_outlined),
                    ),
                    IconButton(
                      tooltip: 'Share',
                      onPressed: () {
                        Share.share(
                          'Check out my Playo calendar: ' + link,
                          subject: 'Playo Calendar',
                        );
                      },
                      icon: const Icon(Icons.share_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Share.share(
                      'Check out my Playo calendar: ' + link,
                      subject: 'Playo Calendar',
                    );
                  },
                  child: const Text('SHARE'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _hideMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlayPageViewModel>(context);
    return GestureDetector(
      onTap: _hideMenu,
      child: Scaffold(
        appBar: const MainAppBar(),
        body: Column(
          children: [
            PlayTabsBar(
              selectedIndex: vm.tabIndex,
              onTabSelected: vm.setTabIndex,
            ),
            PlaySubTabsBar(
              selectedIndex: vm.subTabIndex,
              onTabSelected: vm.setSubTabIndex,
              onMenuPressed: (ctx) {
                if (_menuOverlay != null) {
                  _hideMenu();
                } else {
                  _showMenu(ctx, vm);
                }
              },
              items: vm.subTabs,
            ),
            if (vm.tabIndex == 1)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    _ActionButton(
                      icon: Icons.add,
                      label: 'Create Game',
                      color: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        _openCreateGame();
                      },
                    ),
                    const Spacer(),
                    _ActionButton(
                      icon: Icons.filter_list,
                      label: 'Filter',
                      color: Theme.of(context).colorScheme.onSurface,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      icon: Icons.sort,
                      label: 'Sort',
                      color: Theme.of(context).colorScheme.onSurface,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            Expanded(
              child: vm.tabIndex == 0
                  ? // Calendar tab
                    SingleChildScrollView(
                      child: vm.subTabIndex == 0
                          ? // Upcoming sub-tab
                            UpcomingGames(
                              userCreatedGames: _combinedUserCreated(vm),
                              nearbyGames: vm.nearbyGames,
                              onCreateGame: () {
                                _openCreateGame();
                              },
                              onGameTap: (game) async {
                                final result = await Navigator.of(context)
                                    .push<String>(
                                      MaterialPageRoute(
                                        builder: (_) => GameOverviewPage(
                                          game: game,
                                          onGameUpdated: _onGameUpdated,
                                        ),
                                      ),
                                    );
                                if (result == 'deleted' && mounted) {
                                  final vm = Provider.of<PlayPageViewModel>(
                                    context,
                                    listen: false,
                                  );
                                  setState(() {
                                    _localUserCreated.removeWhere(
                                      (g) => g.id == game.id,
                                    );
                                    vm.userCreatedGames.removeWhere(
                                      (g) => g.id == game.id,
                                    );
                                    vm.currentSportGames.removeWhere(
                                      (g) => g.id == game.id,
                                    );
                                  });
                                  // Also refresh from Supabase to stay in sync
                                  await vm.refreshUpcoming();
                                }
                              },
                              onGameBoardTap: (game) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => GameBoardPage(game: game),
                                  ),
                                );
                              },
                              onInvitePlaypalsTap: (game) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const AddPlayersPage(),
                                  ),
                                );
                              },
                              onRehostTap: (game) async {
                                final created = await Navigator.of(context)
                                    .push<Game>(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CreateGamePage(prefill: game),
                                      ),
                                    );
                                if (created != null) {
                                  // Ensure it shows in upcoming after rehost
                                  setState(() {
                                    _localUserCreated.insert(0, created);
                                  });
                                  final vm = Provider.of<PlayPageViewModel>(
                                    context,
                                    listen: false,
                                  );
                                  await vm.refreshUpcoming();
                                  setState(() {
                                    _localUserCreated.removeWhere(
                                      (g) => vm.userCreatedGames.any(
                                        (u) => u.id == g.id,
                                      ),
                                    );
                                  });
                                }
                              },
                              onJoinTap: (g) => _joinPublicGame(g),
                            )
                          : // Past sub-tab
                            UpcomingGames(
                              userCreatedGames: vm.pastUserCreatedGames,
                              nearbyGames: const [],
                              onCreateGame: _openCreateGame,
                              isPastMode: true,
                              onGameTap: (game) async {
                                final result = await Navigator.of(context)
                                    .push<String>(
                                      MaterialPageRoute(
                                        builder: (_) => GameOverviewPage(
                                          game: game,
                                          onGameUpdated: _onGameUpdated,
                                        ),
                                      ),
                                    );
                                if (result == 'deleted' && mounted) {
                                  final vm = Provider.of<PlayPageViewModel>(
                                    context,
                                    listen: false,
                                  );
                                  setState(() {
                                    _localUserCreated.removeWhere(
                                      (g) => g.id == game.id,
                                    );
                                    vm.userCreatedGames.removeWhere(
                                      (g) => g.id == game.id,
                                    );
                                    vm.currentSportGames.removeWhere(
                                      (g) => g.id == game.id,
                                    );
                                  });
                                  await vm.refreshUpcoming();
                                }
                              },
                              onRehostTap: (game) async {
                                final created = await Navigator.of(context)
                                    .push<Game>(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CreateGamePage(prefill: game),
                                      ),
                                    );
                                if (created != null) {
                                  setState(() {
                                    _localUserCreated.insert(0, created);
                                  });
                                  final vm = Provider.of<PlayPageViewModel>(
                                    context,
                                    listen: false,
                                  );
                                  await vm.refreshUpcoming();
                                  setState(() {
                                    _localUserCreated.removeWhere(
                                      (g) => vm.userCreatedGames.any(
                                        (u) => u.id == g.id,
                                      ),
                                    );
                                  });
                                }
                              },
                            ),
                    )
                  : vm.tabIndex == 1
                  ? // My Sports tab
                    (vm.currentSportGames.isEmpty
                        ? EmptyGamesWidget(
                            title: vm.emptyTitle,
                            selectedCity: vm.selectedCity,
                          )
                        : ListView.builder(
                            itemCount: vm.currentSportGames.length,
                            itemBuilder: (context, index) {
                              final Game g = vm.currentSportGames[index];
                              return GameCard(
                                game: g,
                                onTap: () async {
                                  final result = await Navigator.of(context)
                                      .push<String>(
                                        MaterialPageRoute(
                                          builder: (_) => GameOverviewPage(
                                            game: g,
                                            onGameUpdated: _onGameUpdated,
                                          ),
                                        ),
                                      );
                                  if (result == 'deleted' && mounted) {
                                    final vm = Provider.of<PlayPageViewModel>(
                                      context,
                                      listen: false,
                                    );
                                    setState(() {
                                      _localUserCreated.removeWhere(
                                        (x) => x.id == g.id,
                                      );
                                      vm.userCreatedGames.removeWhere(
                                        (x) => x.id == g.id,
                                      );
                                      vm.currentSportGames.removeWhere(
                                        (x) => x.id == g.id,
                                      );
                                    });
                                    await vm.refreshUpcoming();
                                  }
                                },
                              );
                            },
                          ))
                  : // Other Sports tab
                    EmptyGamesWidget(
                      title: vm.emptyTitle,
                      selectedCity: vm.selectedCity,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
