import 'package:flutter/material.dart';
import 'package:playo/core/common/widgets/message_bottom_sheet.dart';

class Contacts extends StatefulWidget {
  final List<ContactItem> items;
  final DateTime? lastSyncedAt;
  final VoidCallback? onSyncNow;
  final void Function(ContactItem)? onInvite;
  final void Function(ContactItem)? onMessage;
  // Optional: additional section for phone contacts with WhatsApp-like send
  final List<OtherContact>? otherContacts;
  final void Function(OtherContact)? onSendOtherContact;

  const Contacts({
    super.key,
    required this.items,
    this.lastSyncedAt,
    this.onSyncNow,
    this.onInvite,
    this.onMessage,
    this.otherContacts,
    this.onSendOtherContact,
  });

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final Set<int> _invited = <int>{};

  Future<void> _handleMessage(ContactItem item) async {
    await showMessageBottomSheet(context, toName: item.name);
    widget.onMessage?.call(item);
  }

  void _handleInvite(int index, ContactItem item) {
    setState(() => _invited.add(index));
    widget.onInvite?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Header with divider and sync info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(child: Container(height: 1, color: cs.outlineVariant)),
              const SizedBox(width: 12),
              Text(
                widget.lastSyncedAt == null
                    ? 'Not Synced'
                    : 'Last Synced: ${_timeAgo(widget.lastSyncedAt!)}',
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: widget.onSyncNow,
                child: Text(
                  'Sync now',
                  style: TextStyle(
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Card container for contacts list
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.items.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: cs.outlineVariant),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final invited = _invited.contains(index);
                return _ContactRow(
                  item: item,
                  invited: invited,
                  onInvite: () => _handleInvite(index, item),
                  onMessage: () => _handleMessage(item),
                );
              },
            ),
          ),
        ),
        if ((widget.otherContacts?.isNotEmpty ?? false)) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Other Contacts',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'Refer now & earn 50 karma points',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.otherContacts!.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: cs.outlineVariant),
                itemBuilder: (context, index) {
                  final oc = widget.otherContacts![index];
                  return _OtherContactRow(
                    item: oc,
                    onSend: widget.onSendOtherContact == null
                        ? null
                        : () => widget.onSendOtherContact!(oc),
                  );
                },
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  String _timeAgo(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays >= 365) {
      final y = (diff.inDays / 365).floor();
      return y == 1 ? '1 year ago' : '$y years ago';
    }
    if (diff.inDays >= 30) {
      final m = (diff.inDays / 30).floor();
      return m == 1 ? '1 month ago' : '$m months ago';
    }
    if (diff.inDays >= 1) {
      return diff.inDays == 1 ? '1 day ago' : '${diff.inDays} days ago';
    }
    return 'just now';
  }
}

class ContactItem {
  final String name;
  final String? avatarUrl;
  final String skill; // e.g., NO SKILL / INTERMEDIATE
  final DateTime lastGameAt;
  const ContactItem({
    required this.name,
    required this.skill,
    required this.lastGameAt,
    this.avatarUrl,
  });
}

class _ContactRow extends StatelessWidget {
  final ContactItem item;
  final bool invited;
  final VoidCallback? onInvite;
  final VoidCallback? onMessage;
  const _ContactRow({
    required this.item,
    required this.invited,
    this.onInvite,
    this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: cs.surfaceContainerHighest,
            backgroundImage: item.avatarUrl != null
                ? NetworkImage(item.avatarUrl!)
                : null,
            child: item.avatarUrl == null
                ? Icon(Icons.person, color: cs.onSurfaceVariant)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: item.skill.toUpperCase() == 'INTERMEDIATE'
                            ? Colors.amber.withValues(alpha: 0.25)
                            : cs.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: cs.outlineVariant),
                      ),
                      child: Text(
                        item.skill.toUpperCase(),
                        style: TextStyle(
                          color: cs.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Last game ${_ago(item.lastGameAt)}',
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onMessage,
            icon: Icon(
              Icons.chat_bubble_outline,
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withOpacity(0.9),
            ),
            tooltip: 'Message',
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 36,
            child: invited
                ? FilledButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text('INVITED'),
                  )
                : OutlinedButton(
                    onPressed: onInvite,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withOpacity(0.5),
                      ),
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.9),
                    ),
                    child: const Text('INVITE'),
                  ),
          ),
        ],
      ),
    );
  }

  String _ago(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays >= 365) return '${(diff.inDays / 365).floor()} year ago';
    if (diff.inDays >= 30) return '${(diff.inDays / 30).floor()} months ago';
    if (diff.inDays >= 1) return '${diff.inDays} days ago';
    return 'today';
  }
}

class OtherContact {
  final String displayName;
  final String phoneLabel; // could be phone number or subtitle
  const OtherContact({required this.displayName, required this.phoneLabel});
}

class _OtherContactRow extends StatelessWidget {
  final OtherContact item;
  final VoidCallback? onSend;
  const _OtherContactRow({required this.item, this.onSend});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: cs.surfaceContainerHighest,
            child: Icon(Icons.person_outline, color: cs.onSurfaceVariant),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.displayName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.phoneLabel,
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 36,
            child: OutlinedButton.icon(
              onPressed: onSend,
              icon: Icon(Icons.send, color: Colors.green.shade600),
              label: const Text('SEND'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
