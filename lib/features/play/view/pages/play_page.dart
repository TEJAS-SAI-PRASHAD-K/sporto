import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:playo/features/play/viewmodel/play_page_viewmodel.dart';
import 'package:playo/features/play/view/widgets/play_app_bar.dart';
import 'package:playo/features/play/view/widgets/play_tabs_bar.dart';
import 'package:playo/features/play/view/widgets/play_sub_tabs_bar.dart';
import 'package:playo/features/play/view/widgets/empty_games_widget.dart';
import 'package:playo/features/play/view/widgets/menu_overlay.dart';

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
          appBar: const PlayAppBar(),
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
              ),
              Expanded(
                child: EmptyGamesWidget(
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
