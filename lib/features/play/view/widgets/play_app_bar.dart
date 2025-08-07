import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:playo/features/play/viewmodel/play_page_viewmodel.dart';

class PlayAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PlayAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayPageViewModel>(
      builder: (context, viewModel, _) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: const Color(0xFF27313C),
        child: SafeArea(
          child: Row(
            children: [
              _LocationDropdown(
                selectedCity: viewModel.selectedCity,
                availableCities: viewModel.availableCities,
                onCityChanged: viewModel.setSelectedCity,
              ),
              const Spacer(),
              const _AppBarActions(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationDropdown extends StatelessWidget {
  final String selectedCity;
  final List<String> availableCities;
  final ValueChanged<String> onCityChanged;

  const _LocationDropdown({
    required this.selectedCity,
    required this.availableCities,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButton<String>(
        value: selectedCity,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        underline: const SizedBox.shrink(),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
          size: 20,
        ),
        dropdownColor: const Color(0xFF27313C),
        borderRadius: BorderRadius.circular(10),
        items: availableCities.map((String city) {
          return DropdownMenuItem<String>(
            value: city,
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.green, size: 18),
                const SizedBox(width: 8),
                Text(
                  city,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (String? newCity) {
          if (newCity != null) {
            onCityChanged(newCity);
          }
        },
      ),
    );
  }
}

class _AppBarActions extends StatelessWidget {
  const _AppBarActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            // Handle notes action
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Notes clicked')));
          },
          icon: const Icon(Icons.notes, color: Colors.white),
          tooltip: 'Notes',
        ),
        IconButton(
          onPressed: () {
            // Handle notifications action
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications clicked')),
            );
          },
          icon: const Icon(Icons.notifications, color: Colors.white),
          tooltip: 'Notifications',
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            // Handle profile action
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Profile clicked')));
          },
          child: const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
