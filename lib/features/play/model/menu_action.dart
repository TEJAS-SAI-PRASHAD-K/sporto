import 'package:flutter/material.dart';

class MenuAction {
  final String id; // stable identifier for routing/handling
  final IconData icon;
  final String title;

  const MenuAction(this.icon, this.title, {required this.id});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuAction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          icon == other.icon &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ icon.hashCode ^ title.hashCode;
}
