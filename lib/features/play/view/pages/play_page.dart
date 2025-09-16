import 'package:flutter/material.dart';
import 'package:playo/core/common/widgets/main_app_bar.dart';
import 'package:playo/features/play/view/pages/create_game_page.dart';
import 'package:provider/provider.dart';
import 'package:playo/features/play/viewmodel/play_page_viewmodel.dart';
import 'package:playo/features/play/view/widgets/play_tabs_bar.dart';
import 'package:playo/features/play/view/widgets/play_sub_tabs_bar.dart';
import 'package:playo/features/play/view/widgets/empty_games_widget.dart';
import 'package:playo/features/play/view/widgets/menu_overlay.dart';
import 'package:playo/features/play/model/game.dart';
import 'package:playo/features/play/view/widgets/game_card.dart';
import 'package:playo/features/play/view/pages/game_overview/game_overview_page.dart';
import 'package:playo/features/play/view/widgets/upcoming_games.dart';

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

  void _showMenu(BuildContext ctx, PlayPageViewModel vm) {
    final RenderBox box = ctx.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);

    _menuOverlay = MenuOverlay.build(
      top: position.dy + 50,
      right: 12,
      actions: vm.menuActions,
      onClose: _hideMenu,
    );

    Overlay.of(context).insert(_menuOverlay!);
  }

  void _hideMenu() {
    _menuOverlay?.remove();
    _menuOverlay = null;
  }

  @override
  void dispose() {
    _hideMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayPageViewModel>(
      builder: (context, vm, _) => GestureDetector(
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateGamePage(),
                            ),
                          );
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
                                userCreatedGames: vm.userCreatedGames,
                                nearbyGames: vm.nearbyGames,
                                onCreateGame: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CreateGamePage(),
                                    ),
                                  );
                                },
                                onGameTap: (game) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          GameOverviewPage(game: game),
                                    ),
                                  );
                                },
                                onGameBoardTap: () {
                                  // TODO: Navigate to game board
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Game Board tapped!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                onInvitePlaypalsTap: () {
                                  // TODO: Navigate to invite playpals screen
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Invite Playpals tapped!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              )
                            : // Past sub-tab
                              EmptyGamesWidget(
                                title: vm.emptyTitle,
                                buttonText: vm.buttonLabel,
                                selectedCity: vm.selectedCity,
                              ),
                      )
                    : vm.tabIndex == 1
                    ? // My Sports tab
                      ListView.builder(
                        itemCount: vm.currentSportGames.length,
                        itemBuilder: (context, index) {
                          final Game g = vm.currentSportGames[index];
                          return GameCard(
                            game: g,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => GameOverviewPage(game: g),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : // Other Sports tab
                      EmptyGamesWidget(
                        title: vm.emptyTitle,
                        buttonText: vm.buttonLabel,
                        selectedCity: vm.selectedCity,
                      ),
              ),
            ],
          ),
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
