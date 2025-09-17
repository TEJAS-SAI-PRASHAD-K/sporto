import 'package:flutter/material.dart';

/// Opens a bottom sheet asking to confirm retiring a player with an optional message.
/// Returns the typed message (possibly empty string) if RETIRE is confirmed,
/// or null if the user cancels/closes the sheet.
Future<String?> showRetireBottomSheet(
  BuildContext context, {
  required String playerName,
}) async {
  final controller = TextEditingController();
  final cs = Theme.of(context).colorScheme;

  final result = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: cs.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Are you sure you want to retire $playerName?',
                    style: TextStyle(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  icon: Icon(Icons.close, color: cs.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.outlineVariant),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: TextField(
                controller: controller,
                maxLength: 1024,
                minLines: 4,
                maxLines: 6,
                style: TextStyle(color: cs.onSurface),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '${controller.text.length}/1024',
                  hintText: 'Send a message to the player (Optional)',
                  hintStyle: TextStyle(color: cs.onSurfaceVariant),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(ctx).pop(controller.text);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('RETIRE'),
              ),
            ),
          ],
        ),
      );
    },
  );
  return result;
}
