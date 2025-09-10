import 'package:flutter/material.dart';
import 'package:playo/core/models/venue.dart' as model;

class BookingSummaryWidget extends StatelessWidget {
  final List<model.Court> selectedCourtsList;
  final Map<String, int> selectedCourtsWithDuration;
  final TimeOfDay selectedTime;
  final int selectedDuration; // Fallback duration
  final double totalPrice;
  final String currency;
  final VoidCallback onAddToBooking;
  final ColorScheme colorScheme;

  const BookingSummaryWidget({
    super.key,
    required this.selectedCourtsList,
    required this.selectedCourtsWithDuration,
    required this.selectedTime,
    required this.selectedDuration,
    required this.totalPrice,
    required this.currency,
    required this.onAddToBooking,
    required this.colorScheme,
  });

  double _calculateCourtPrice(model.Court court, int duration) {
    // Convert to USD pricing (rate adjusted for USD conversion)
    final priceInDollars = court.hourlyRate / 86.0;
    return (priceInDollars * duration) / 60.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        top: 12,
        bottom: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Center(
            child: Text(
              "Booking Summary",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Selected Arenas Section
          Text(
            selectedCourtsList.length == 1
                ? "Selected Arena"
                : "Selected Arenas",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),

          // Arena list with improved layout for multiple arenas
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: selectedCourtsList.asMap().entries.map((entry) {
                final index = entry.key;
                final court = entry.value;
                // Get the specific duration for this court
                final courtDuration =
                    selectedCourtsWithDuration[court.id] ?? selectedDuration;
                final courtPrice = _calculateCourtPrice(court, courtDuration);
                final isLast = index == selectedCourtsList.length - 1;

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: isLast
                        ? null
                        : Border(
                            bottom: BorderSide(
                              color: colorScheme.outline.withValues(alpha: 0.2),
                              width: 0.5,
                            ),
                          ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              court.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              '${courtDuration ~/ 60}h ${courtDuration % 60 > 0 ? '${courtDuration % 60}m' : ''}',
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "USD ${courtPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Fixed spacing instead of Spacer to avoid layout issues
          const SizedBox(height: 32),

          // Bottom section with total price and button
          Column(
            children: [
              // Total Price
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Price:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      "USD ${totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onAddToBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  child: Text(
                    'PROCEED TO PAYMENT',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
