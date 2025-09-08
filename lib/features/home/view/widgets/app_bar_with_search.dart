import 'package:flutter/material.dart';

class AppBarWithSearch extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isSearching;
  final VoidCallback onSearchToggle;
  final List<Widget>? additionalActions;
  final bool centerTitle;

  const AppBarWithSearch({
    super.key,
    required this.title,
    required this.isSearching,
    required this.onSearchToggle,
    this.additionalActions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: centerTitle
          ? Center(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color:
                      Theme.of(context).appBarTheme.titleTextStyle?.color ??
                      Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            )
          : Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color:
                    Theme.of(context).appBarTheme.titleTextStyle?.color ??
                    Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
      actions: [
        IconButton(
          icon: Icon(
            isSearching ? Icons.close : Icons.search,
            color:
                Theme.of(context).appBarTheme.iconTheme?.color ??
                Theme.of(context).iconTheme.color,
          ),
          onPressed: onSearchToggle,
        ),
        if (additionalActions != null) ...additionalActions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
