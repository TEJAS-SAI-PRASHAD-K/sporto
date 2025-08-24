import 'package:flutter/material.dart';

/// Represents a top category tile like Badminton, Swimming, etc.
class ServiceCategory {
  final String id;
  final String name;
  final String imageAsset;
  final Color background;

  const ServiceCategory({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.background,
  });
}
