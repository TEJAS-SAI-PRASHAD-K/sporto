import 'package:flutter/material.dart';

class MoreListTile extends StatelessWidget {
  final bool isFirst;
  final IconData leading;
  final String title;
  final String? subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? tileColor;
  final TextStyle? titleStyle;
  final Color? leadingIconColor;
  final Color? leadingIconBackgroundColor;

  const MoreListTile({
    super.key,
    required this.isFirst,
    required this.leading,
    required this.title,
    this.subTitle,
    this.trailing,
    this.onTap,
    this.tileColor,
    this.titleStyle,
    this.leadingIconColor,
    this.leadingIconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFirst)
          Divider(
            color: Theme.of(context).colorScheme.secondaryFixedDim,
            indent: 18,
            endIndent: 28,
            thickness: 0.4,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    leadingIconBackgroundColor ??
                    Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: Icon(
                leading,
                color:
                    leadingIconColor ?? Theme.of(context).colorScheme.primary,
                size: 28,
              ),
            ),
            title: Text(title, style: titleStyle),
            subtitle: subTitle != null
                ? Text(
                    subTitle!,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  )
                : null,
            trailing: trailing,
            onTap: onTap,
            tileColor: tileColor,
          ),
        ),
      ],
    );
  }
}
