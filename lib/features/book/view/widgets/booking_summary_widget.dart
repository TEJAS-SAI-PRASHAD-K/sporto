import 'package:flutter/material.dart';
import 'package:playo/core/models/venue.dart' as model;

class BookingSummaryWidget extends StatelessWidget {
  final List<model.Court> selectedCourtsList;
  final TimeOfDay selectedTime;
  final int selectedDuration;
  final double totalPrice;
  final String currency;
  final VoidCallback onAddToBooking;
  final ColorScheme colorScheme;

  const BookingSummaryWidget({
    super.key,
    required this.selectedCourtsList,
    required this.selectedTime,
    required this.selectedDuration,
    required this.totalPrice,
    required this.currency,
    required this.onAddToBooking,
    required this.colorScheme,
  });

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  double _calculateCourtPrice(model.Court court, int duration) {
    // Convert to USD pricing (rate adjusted for USD conversion)
    final priceInDollars = court.hourlyRate / 86.0;
    return (priceInDollars * duration) / 60.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Text(
            "Selected Courts",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          ...selectedCourtsList.map((court) {
            final courtPrice = _calculateCourtPrice(court, selectedDuration);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      court.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Text(
                    "USD ${courtPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          Text(
            "Time: ${_formatTime(selectedTime)}",
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Text(
            "Duration: $selectedDuration minutes",
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          Text(
            "Total Price: USD ${totalPrice.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
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
                'ADD TO BOOKING',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
