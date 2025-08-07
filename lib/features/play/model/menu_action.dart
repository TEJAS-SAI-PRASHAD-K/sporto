import 'package:flutter/material.dart';

class MenuAction {
  final IconData icon;
  final String title;

  const MenuAction(this.icon, this.title);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuAction &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          title == other.title;

  @override
  int get hashCode => icon.hashCode ^ title.hashCode;
}
