import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeData build() => ThemeData.light();

  void toggleTheme() {
    state = state == ThemeData.light() ? ThemeData.dark() : ThemeData.light();
  }

  void setTheme(ThemeData mode) {
    state = mode;
  }
}
