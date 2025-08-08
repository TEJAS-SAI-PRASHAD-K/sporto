import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:playo/features/play/viewmodel/play_page_viewmodel.dart';

class PlayAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PlayAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayPageViewModel>(
      builder: (context, viewModel, _) => AppBar(
        title: Row(
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: DropdownButton<String>(
        value: selectedCity,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        underline: const SizedBox.shrink(),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        borderRadius: BorderRadius.circular(10),
        items: availableCities.map((String city) {
          return DropdownMenuItem<String>(
            value: city,
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).colorScheme.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  city,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
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
          onPressed: () {},
          icon: const Icon(Iconsax.note_1_copy),
          tooltip: 'Notes',
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.notification_1_copy),
          tooltip: 'Notifications',
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {},
          child: const CircleAvatar(
            radius: 18,
            foregroundImage: AssetImage("assets/images/boy_10.png"),
          ),
        ),
      ],
    );
  }
}
