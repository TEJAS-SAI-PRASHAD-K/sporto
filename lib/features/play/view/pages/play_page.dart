import 'package:flutter/material.dart';
import 'package:playo/core/common/widgets/main_app_bar.dart';
import 'package:playo/features/more/view/pages/my_bookings_page.dart';
import 'package:playo/features/play/view/pages/create_game_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/features/play/viewmodel/game_view_model.dart';
import 'package:playo/features/play/view/widgets/play_tabs_bar.dart';
import 'package:playo/features/play/view/widgets/play_sub_tabs_bar.dart';
import 'package:playo/features/play/view/widgets/empty_games_widget.dart';
import 'package:playo/features/play/view/widgets/menu_overlay.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/features/play/model/game_ui_extensions.dart';
import 'package:playo/features/play/view/widgets/game_card.dart';
import 'package:playo/features/play/view/pages/game_overview/game_overview_page.dart';
import 'package:playo/features/play/view/pages/public_game_details_page.dart';
import 'package:playo/features/play/view/pages/game_board_page.dart';
import 'package:playo/features/play/view/pages/game_overview/add_players_page.dart';
import 'package:playo/features/play/view/widgets/upcoming_games.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:playo/init_dependecies.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class PlayPage extends ConsumerStatefulWidget {
  const PlayPage({super.key});

  @override
  ConsumerState<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends ConsumerState<PlayPage> {
  OverlayEntry? _menuOverlay;
  // Local state to hold newly created games so Upcoming updates immediately
  final List<Game> _localUserCreated = [];

  @override
  void initState() {
    super.initState();
    // Initial refresh
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameViewModelProvider.notifier).refreshUpcoming();
    });
  }

  void _replaceInList(List<Game> list, Game updated) {
    final idx = list.indexWhere((g) => g.id == updated.id);
    if (idx != -1) list[idx] = updated;
  }

  // Merge local optimistic games with fetched ones, ensuring uniqueness by id
  List<Game> _combinedUserCreated(GameViewModel vm) {
    final seen = <String>{};
    final merged = <Game>[];
    void add(Game g) {
      if (seen.add(g.id)) merged.add(g);
    }

    for (final g in _localUserCreated) {
      add(g);
    }
    for (final g in vm.userCreatedUpcomingGames) {
      add(g);
    }
    return merged;
  }

  void _onGameUpdated(Game updated) {
    setState(() {
      _replaceInList(_localUserCreated, updated);
      final notifier = ref.read(gameViewModelProvider.notifier);
      _replaceInList(notifier.userCreatedUpcomingGames, updated);
      _replaceInList(notifier.currentSportGames, updated);
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
      final notifier = ref.read(gameViewModelProvider.notifier);
      notifier.setTabIndex(0);
      await notifier.refreshUpcoming();
      // Reconcile: remove any locally-added game that now exists in VM list
      setState(() {
        _localUserCreated.removeWhere(
          (g) => notifier.userCreatedUpcomingGames.any((u) => u.id == g.id),
        );
      });
    }
  }

  void _showMenu(BuildContext ctx, GameViewModel vm) {
    final RenderBox box = ctx.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);

    _menuOverlay = MenuOverlay.build(
      top: position.dy + 50,
      right: 12,
      actions: vm.menuActions,
      onClose: _hideMenu,
      onActionTap: (action) async {
        switch (action.id) {
          case GameViewModel.actCreateGame:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => CreateGamePage()),
            );
            break;
          case GameViewModel.actShareCalendar:
            _showShareCalendarSheet(vm);
            break;
          case GameViewModel.actInvitePlaypals:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => AddPlayersPage()),
            );
            break;
          case GameViewModel.actMyBookings:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => MyBookingsPage()),
            );
            break;
          case GameViewModel.actFilter:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => CreateGamePage()),
            );
            break;
          case GameViewModel.actSort:
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

  void _showShareCalendarSheet(GameViewModel vm) {
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
    ref.listen(gameViewModelProvider, (prev, next) {
      next.whenOrNull(
        error: (e, st) {
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString())));
          }
        },
      );
    });
    // Watch to trigger rebuilds when internal state changes
    final gameState = ref.watch(gameViewModelProvider);
    final notifier = ref.read(gameViewModelProvider.notifier);
    final vm = notifier;
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
            if (gameState.isLoading)
              const LinearProgressIndicator(minHeight: 2),
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
                      onTap: _openCreateGame,
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
                              nearbyGames: vm.nearbyAcceptedGames,
                              onCreateGame: () {
                                _openCreateGame();
                              },
                              onGameTap: (game) async {
                                // If organiser is me open overview else open public details
                                final supabase =
                                    serviceLocator<SupabaseClient>();
                                final currentUserId =
                                    supabase.auth.currentUser?.id;
                                final isMine =
                                    game.organiserUserId == currentUserId;
                                if (isMine) {
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
                                    final vm = notifier;
                                    setState(() {
                                      _localUserCreated.removeWhere(
                                        (g) => g.id == game.id,
                                      );
                                      vm.userCreatedUpcomingGames.removeWhere(
                                        (g) => g.id == game.id,
                                      );
                                      vm.currentSportGames.removeWhere(
                                        (g) => g.id == game.id,
                                      );
                                    });
                                    await vm.refreshUpcoming();
                                  }
                                } else {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          PublicGameDetailsPage(game: game),
                                    ),
                                  );
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
                                  await notifier.refreshUpcoming();
                                  setState(() {
                                    _localUserCreated.removeWhere(
                                      (g) => vm.userCreatedUpcomingGames.any(
                                        (u) => u.id == g.id,
                                      ),
                                    );
                                  });
                                }
                              },
                              onJoinTap: null,
                            )
                          : // Past sub-tab
                            UpcomingGames(
                              userCreatedGames: vm.pastUserCreatedGames,
                              nearbyGames: const [],
                              onCreateGame: _openCreateGame,
                              isPastMode: true,
                              onGameTap: (game) async {
                                final supabase =
                                    serviceLocator<SupabaseClient>();
                                final currentUserId =
                                    supabase.auth.currentUser?.id;
                                final isMine =
                                    game.organiserUserId == currentUserId;
                                if (isMine) {
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
                                    final vm = notifier;
                                    setState(() {
                                      _localUserCreated.removeWhere(
                                        (g) => g.id == game.id,
                                      );
                                      vm.userCreatedUpcomingGames.removeWhere(
                                        (g) => g.id == game.id,
                                      );
                                      vm.currentSportGames.removeWhere(
                                        (g) => g.id == game.id,
                                      );
                                    });
                                    await vm.refreshUpcoming();
                                  }
                                } else {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          PublicGameDetailsPage(game: game),
                                    ),
                                  );
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
                                  await notifier.refreshUpcoming();
                                  setState(() {
                                    _localUserCreated.removeWhere(
                                      (g) => vm.userCreatedUpcomingGames.any(
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
                                  // Games in My Sports lists are public games by others
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          PublicGameDetailsPage(game: g),
                                    ),
                                  );
                                },
                              );
                            },
                          ))
                  : // Other Sports tab
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
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          PublicGameDetailsPage(game: g),
                                    ),
                                  );
                                },
                              );
                            },
                          )),
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
