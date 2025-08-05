import 'package:flutter/material.dart';

PreferredSizeWidget buildCustomAppBar() {
  return AppBar(
    title: Row(
      children: [
        const Icon(Icons.edit_location_alt),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "Location",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.message_outlined)),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_none_outlined),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 14, left: 7),
        child: CircleAvatar(radius: 18, child: const Icon(Icons.person)),
      ),
    ],
  );
}
