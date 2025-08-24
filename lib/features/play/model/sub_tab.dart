import 'package:flutter/material.dart';

/// Simple model representing a sub-tab item in the Play page.
@immutable
class SubTab {
  final String id;
  final String label;
  final IconData? icon;

  const SubTab({required this.id, required this.label, this.icon});
}
