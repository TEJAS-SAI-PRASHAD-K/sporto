import 'package:flutter/material.dart';
import 'package:playo/core/common/widgets/message_bottom_sheet.dart';
import 'package:playo/core/common/widgets/see_reputation_page.dart';

enum PlayerPrimaryButtonType { primary, alert, none }

class PlayerCard extends StatelessWidget {
  final String avatarInitials;
  final String name;
  final String? rightTimeText;
  final String? roleChip;
  final String? skillLabel;
  final List<String>? lastFive;
  final String? message;
  final int? noShows;

  final VoidCallback? onSeeReputation;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  final String? primaryLabel;
  final PlayerPrimaryButtonType primaryType;
  final VoidCallback? onPrimary;

  const PlayerCard({
    super.key,
    required this.avatarInitials,
    required this.name,
    this.rightTimeText,
    this.roleChip,
    this.skillLabel,
    this.lastFive,
    this.message,
    this.noShows,
    this.onSeeReputation,
    this.secondaryLabel,
    this.onSecondary,
    this.primaryLabel,
    this.primaryType = PlayerPrimaryButtonType.none,
    this.onPrimary,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: cs.surfaceContainerHighest,
                child: Text(
                  avatarInitials,
                  style: TextStyle(color: cs.onSurface),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: cs.onSurface,
                            ),
                          ),
                        ),
                        if (rightTimeText != null)
                          Text(
                            rightTimeText!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: cs.onSurfaceVariant),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (skillLabel != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: skillLabel!.toUpperCase() == 'INTERMEDIATE'
                                  ? Colors.amber.withOpacity(0.25)
                                  : skillLabel!.toUpperCase() == 'PROFESSIONAL'
                                  ? Colors.orange.withOpacity(0.3)
                                  : cs.surface,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: cs.outlineVariant),
                            ),
                            child: Text(
                              skillLabel!.toUpperCase(),
                              style: TextStyle(
                                color: cs.onSurface,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        if (roleChip != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: cs.surface,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: cs.outlineVariant),
                            ),
                            child: Text(
                              roleChip!,
                              style: TextStyle(
                                color: cs.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (message != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await showMessageBottomSheet(context, toName: name);
                  },
                  child: Icon(
                    Icons.chat_bubble_outline,
                    color: cs.onSurface,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(message!, style: TextStyle(color: cs.onSurface)),
                ),
              ],
            ),
          ],

          if ((lastFive != null && lastFive!.isNotEmpty)) ...[
            const SizedBox(height: 10),
            Divider(color: cs.outlineVariant, height: 1),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Last 5 Matches Rating',
                  style: TextStyle(color: cs.onSurface),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      for (final s in lastFive!) ...[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 18,
                          height: 18,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: cs.outlineVariant),
                          ),
                          child: Text(s, style: TextStyle(color: cs.onSurface)),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),

                    child: Text(
                      '${noShows ?? 0} NO SHOWS',
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed:
                        onSeeReputation ??
                        () => openSeeReputation(
                          context,
                          playerName: name,
                          noShowsLast15: noShows ?? 0,
                        ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'See Reputation',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (secondaryLabel != null)
                    OutlinedButton(
                      onPressed: onSecondary,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 9,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: const Size(0, 0),
                      ),
                      child: Text(secondaryLabel!),
                    ),
                  if (secondaryLabel != null) const SizedBox(width: 8),
                  if (primaryLabel != null)
                    switch (primaryType) {
                      PlayerPrimaryButtonType.alert => _AlertButton(
                        label: primaryLabel!,
                        onPressed: onPrimary,
                      ),
                      PlayerPrimaryButtonType.primary => _PrimaryButton(
                        label: primaryLabel!,
                        onPressed: onPrimary,
                      ),
                      PlayerPrimaryButtonType.none => const SizedBox.shrink(),
                    },
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const _PrimaryButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(label),
    );
  }
}

class _AlertButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const _AlertButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: cs.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(label),
    );
  }
}
