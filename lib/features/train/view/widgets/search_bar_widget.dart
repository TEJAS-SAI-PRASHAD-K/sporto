import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const SearchBarWidget({
    super.key,
    this.hintText = "Search by Sport",
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Icon(
            Iconsax.search_normal_1_copy,
            color: theme.colorScheme.outline,
            size: 18,
          ),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainer,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
