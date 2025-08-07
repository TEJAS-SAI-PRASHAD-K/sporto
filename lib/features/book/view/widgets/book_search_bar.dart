import 'package:flutter/material.dart';

class BookSearchBar extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const BookSearchBar({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          onChanged: onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search For Location',
            hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16),
            prefixIcon: Icon(Icons.search, color: Color(0xFF9E9E9E)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),
    );
  }
}
