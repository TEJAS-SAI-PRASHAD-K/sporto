import 'package:flutter/material.dart';
import 'package:playo/core/theme/app_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_provider.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeData build() => lightTheme;

  void toggleTheme() {
    state = state == lightTheme ? darkTheme : lightTheme;
  }

  void setTheme(ThemeData mode) {
    state = mode;
  }
}
