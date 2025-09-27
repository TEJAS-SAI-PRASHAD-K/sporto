import 'package:flutter/material.dart';
import 'package:playo/features/play/model/menu_action.dart';

class MenuOverlay {
  static OverlayEntry build({
    required double top,
    required double right,
    required List<MenuAction> actions,
    required VoidCallback onClose,
    void Function(MenuAction)? onActionTap,
  }) {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Backdrop to capture outside taps and dismiss the overlay
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onClose,
            ),
          ),
          Positioned(
            top: top,
            right: right,
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 185, maxWidth: 280),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: actions.map((action) {
                      return InkWell(
                        onTap: () {
                          onActionTap?.call(action);
                          onClose();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                action.icon,
                                size: 18,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  action.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
