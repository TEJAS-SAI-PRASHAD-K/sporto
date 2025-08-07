import 'package:flutter/material.dart';
import 'package:playo/features/play/model/menu_action.dart';

class MenuOverlay {
  static OverlayEntry build({
    required double top,
    required double right,
    required List<MenuAction> actions,
    required VoidCallback onClose,
  }) {
    return OverlayEntry(
      builder: (_) => Positioned(
        top: top,
        right: right,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 185,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 4),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: actions.map((action) {
                return InkWell(
                  onTap: onClose,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Icon(action.icon, size: 18, color: Colors.black),
                        const SizedBox(width: 14),
                        Text(
                          action.title,
                          style: const TextStyle(fontSize: 15),
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
    );
  }
}
