import 'package:flutter/material.dart';
import 'package:playo/core/services/notification_service.dart';

Future<String?> showMessageBottomSheet(
  BuildContext context, {
  required String toName,
  int maxLength = 300,
}) async {
  final controller = TextEditingController();
  String? result;
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      final cs = Theme.of(ctx).colorScheme;
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          top: 8,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            final canSend = controller.text.trim().isNotEmpty;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Send a message to "$toName"',
                  style: Theme.of(
                    ctx,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'User is not your playpal, if you send request and user accepts then user will be able to send messages, share game invites and see your online status',
                  style: Theme.of(
                    ctx,
                  ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,
                  maxLines: 4,
                  maxLength: maxLength,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Type your message',
                    filled: true,
                    fillColor: cs.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    counterText:
                        '${controller.text.characters.length}/$maxLength',
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        controller.clear();
                        setState(() {});
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('CLEAR'),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: canSend
                          ? () {
                              result = controller.text.trim();
                              // Trigger notification for sent message
                              NotificationService().showNotification(
                                5,
                                'Message Sent',
                                'Your message to $toName was sent.',
                              );
                              Navigator.of(ctx).pop();
                            }
                          : null,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                      child: const Text('SEND'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
  return result;
}
