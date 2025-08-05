import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/providers/theme_provider.dart';
import 'package:playo/core/theme/app_theme.dart';

class ThemeSwitchIconButton extends ConsumerWidget {
  const ThemeSwitchIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeNotifierProvider);
    final themeNotifier = ref.read(themeModeNotifierProvider.notifier);
    return IconButton(
      onPressed: themeNotifier.toggleTheme,
      icon: theme == lightTheme
          ? Icon(Icons.dark_mode_rounded, color: Theme.of(context).primaryColor)
          : Icon(Icons.light_mode_rounded, color: Colors.white),
    );
  }
}
