import 'package:flutter/material.dart';
import 'package:playo/core/models/venue.dart' as model;

class VenueSportSelector extends StatelessWidget {
  final model.Datum venueData;
  final String? selectedSportId;
  final Function(String?) onSportSelected;
  final ColorScheme colorScheme;

  const VenueSportSelector({
    super.key,
    required this.venueData,
    required this.selectedSportId,
    required this.onSportSelected,
    required this.colorScheme,
  });

  // Extract unique sports from venue courts
  List<String> get availableSports {
    final sportsSet = <String>{};
    for (final court in venueData.court) {
      if (court.isBookable) {
        sportsSet.add(court.sportId);
      }
    }
    return sportsSet.toList()..sort();
  }

  // Get sport-specific icon
  IconData _getSportIcon(String sportId) {
    switch (sportId.toLowerCase()) {
      case 'badminton':
        return Icons.sports_tennis; // Closest icon for badminton
      case 'tennis':
        return Icons.sports_tennis;
      case 'football':
      case 'soccer':
        return Icons.sports_soccer;
      case 'basketball':
        return Icons.sports_basketball;
      case 'cricket':
        return Icons.sports_cricket;
      case 'volleyball':
        return Icons.sports_volleyball;
      case 'table tennis':
      case 'ping pong':
        return Icons.sports_tennis;
      case 'squash':
        return Icons.sports_tennis;
      case 'golf':
        return Icons.sports_golf;
      case 'swimming':
        return Icons.pool;
      case 'gym':
      case 'fitness':
        return Icons.fitness_center;
      default:
        return Icons.sports;
    }
  }

  // Get sport display name (capitalize first letter)
  String _getSportDisplayName(String sportId) {
    return sportId
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : word,
        )
        .join(' ');
  }

  // Get court count for a sport
  int _getCourtCount(String sportId) {
    return venueData.court
        .where((court) => court.sportId == sportId && court.isBookable)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final sports = availableSports;

    if (sports.isEmpty) {
      return const SizedBox.shrink();
    }

    // Auto-select first sport if not already selected
    if (selectedSportId == null && sports.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onSportSelected(sports.first);
      });
    }

    // Show horizontal selector for both single and multiple sports (no "All" option)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Sport',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: sports.length == 1
              ? Center(
                  // Center single sport card
                  child: _buildSportCard(
                    sportId: sports.first,
                    displayName: _getSportDisplayName(sports.first),
                    icon: _getSportIcon(sports.first),
                    courtCount: _getCourtCount(sports.first),
                    isSelected: true, // Always selected for single sport
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate total width needed for all sport cards (no "All" option)
                    final totalCards = sports.length;
                    final cardWidth = 90.0;
                    final cardMargin = 12.0;
                    final totalWidth =
                        (totalCards * cardWidth) +
                        ((totalCards - 1) * cardMargin);

                    // If content fits in available width, center it
                    if (totalWidth <= constraints.maxWidth) {
                      return Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: sports
                              .map(
                                (sport) => Padding(
                                  padding: EdgeInsets.only(
                                    right: sport == sports.last
                                        ? 0
                                        : cardMargin,
                                  ),
                                  child: _buildSportCard(
                                    sportId: sport,
                                    displayName: _getSportDisplayName(sport),
                                    icon: _getSportIcon(sport),
                                    courtCount: _getCourtCount(sport),
                                    isSelected: selectedSportId == sport,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      );
                    } else {
                      // If content doesn't fit, use scrollable list
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sports.length,
                        itemBuilder: (context, index) {
                          final sport = sports[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index == sports.length - 1
                                  ? 0
                                  : cardMargin,
                            ),
                            child: _buildSportCard(
                              sportId: sport,
                              displayName: _getSportDisplayName(sport),
                              icon: _getSportIcon(sport),
                              courtCount: _getCourtCount(sport),
                              isSelected: selectedSportId == sport,
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSportCard({
    required String? sportId,
    required String displayName,
    required IconData icon,
    required int courtCount,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onSportSelected(sportId),
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer.withValues(alpha: 0.3)
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 6),
            Text(
              displayName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outline.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$courtCount',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
