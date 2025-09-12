import 'package:flutter/material.dart';
import 'package:playo/core/models/venue_booking.dart';
import 'package:playo/core/services/booking_service.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  int _selectedIndex = 0;
  static const List<String> _tabs = ['Upcoming', 'Past', 'Cancelled'];

  final BookingService _bookingService = BookingService();
  List<VenueBooking> _allBookings = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final userId = _bookingService.getCurrentUserId();
      if (userId != null) {
        final bookings = await _bookingService.getUserBookings(userId);
        if (mounted) {
          setState(() {
            _allBookings = bookings;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _error = 'Please log in to view your bookings';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error =
              'Failed to load bookings. Please check your connection and try again.';
          _isLoading = false;
        });
      }
    }
  }

  List<VenueBooking> _getFilteredBookings() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (_selectedIndex) {
      case 0: // Upcoming
        return _allBookings.where((booking) {
          final bookingDate = DateTime(
            booking.bookingDate.year,
            booking.bookingDate.month,
            booking.bookingDate.day,
          );
          return (bookingDate.isAfter(today) ||
                  bookingDate.isAtSameMomentAs(today)) &&
              (booking.bookingStatus == BookingStatus.pending ||
                  booking.bookingStatus == BookingStatus.confirmed);
        }).toList();

      case 1: // Past
        return _allBookings.where((booking) {
          final bookingDate = DateTime(
            booking.bookingDate.year,
            booking.bookingDate.month,
            booking.bookingDate.day,
          );
          return bookingDate.isBefore(today) &&
              (booking.bookingStatus == BookingStatus.completed ||
                  booking.bookingStatus == BookingStatus.confirmed ||
                  booking.bookingStatus == BookingStatus.pending);
        }).toList();

      case 2: // Cancelled
        return _allBookings.where((booking) {
          return booking.bookingStatus == BookingStatus.cancelled;
        }).toList();

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'My Bookings',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: List.generate(_tabs.length, (index) {
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    margin: index < _tabs.length - 1
                        ? const EdgeInsets.only(right: 24)
                        : EdgeInsets.zero,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _tabs[index],
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 3,
                          width: 75,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colorScheme.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(child: _buildBookingsList()),
        ],
      ),
    );
  }

  Widget _buildBookingsList() {
    final colorScheme = Theme.of(context).colorScheme;

    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Loading your bookings...',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadBookings,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final filteredBookings = _getFilteredBookings();

    if (filteredBookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getEmptyStateIcon(),
              size: 64,
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              _getEmptyStateMessage(),
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getEmptyStateSubtitle(),
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadBookings,
      color: colorScheme.primary,
      backgroundColor: colorScheme.surface,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredBookings.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _BookingCard(
              booking: filteredBookings[index],
              onCancel: _selectedIndex == 0 ? _cancelBooking : null,
            ),
          );
        },
      ),
    );
  }

  IconData _getEmptyStateIcon() {
    switch (_selectedIndex) {
      case 0:
        return Icons.calendar_today;
      case 1:
        return Icons.history;
      case 2:
        return Icons.cancel_outlined;
      default:
        return Icons.sports_tennis;
    }
  }

  String _getEmptyStateMessage() {
    switch (_selectedIndex) {
      case 0:
        return 'No Upcoming Bookings';
      case 1:
        return 'No Past Bookings';
      case 2:
        return 'No Cancelled Bookings';
      default:
        return 'No Bookings';
    }
  }

  String _getEmptyStateSubtitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Book your next game and it will appear here';
      case 1:
        return 'Your completed bookings will be shown here';
      case 2:
        return 'Cancelled bookings will appear here';
      default:
        return '';
    }
  }

  Future<void> _cancelBooking(String bookingId) async {
    final colorScheme = Theme.of(context).colorScheme;

    // Show confirmation dialog
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: colorScheme.error),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );

    if (shouldCancel == true) {
      // Show loading dialog
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(color: colorScheme.primary),
                const SizedBox(width: 16),
                const Text('Cancelling booking...'),
              ],
            ),
          ),
        );
      }

      final success = await _bookingService.cancelBooking(bookingId);

      // Close loading dialog
      if (mounted) {
        Navigator.of(context).pop();
      }

      if (success) {
        // Reload bookings to reflect the change
        _loadBookings();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Booking cancelled successfully'),
              backgroundColor: colorScheme.primary,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Failed to cancel booking'),
              backgroundColor: colorScheme.error,
            ),
          );
        }
      }
    }
  }
}

class _BookingCard extends StatelessWidget {
  final VenueBooking booking;
  final Function(String)? onCancel;

  const _BookingCard({required this.booking, this.onCancel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with venue name and status
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.venueName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking.venueCity,
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _BookingStatusChip(status: booking.bookingStatus),
              ],
            ),

            const SizedBox(height: 16),

            // Sport badge
            _SportBadge(sportId: booking.sportId),

            const SizedBox(height: 12),

            // Booking details
            _BookingDetailRow(
              icon: Icons.calendar_today,
              label: 'Date',
              value: booking.formattedDate,
            ),
            const SizedBox(height: 8),
            _BookingDetailRow(
              icon: Icons.access_time,
              label: 'Time',
              value: booking.formattedTimeSlot,
            ),
            const SizedBox(height: 8),
            _BookingDetailRow(
              icon: Icons.sports_tennis,
              label: 'Courts',
              value: booking.courtNames,
            ),
            const SizedBox(height: 8),
            _BookingDetailRow(
              icon: Icons.monetization_on_outlined,
              label: 'Total',
              value:
                  '${booking.currency} ${booking.totalAmount.toStringAsFixed(2)}',
            ),

            // Cancel button for upcoming bookings
            if (onCancel != null) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => onCancel!(booking.bookingId),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    side: BorderSide(color: colorScheme.error),
                  ),
                  child: const Text('Cancel Booking'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BookingStatusChip extends StatelessWidget {
  final BookingStatus status;

  const _BookingStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status) {
      case BookingStatus.pending:
        backgroundColor = colorScheme.secondary.withValues(alpha: 0.1);
        textColor = colorScheme.secondary;
        displayText = 'Pending';
        break;
      case BookingStatus.confirmed:
        backgroundColor = colorScheme.primary.withValues(alpha: 0.1);
        textColor = colorScheme.primary;
        displayText = 'Confirmed';
        break;
      case BookingStatus.cancelled:
        backgroundColor = colorScheme.error.withValues(alpha: 0.1);
        textColor = colorScheme.error;
        displayText = 'Cancelled';
        break;
      case BookingStatus.completed:
        backgroundColor = colorScheme.tertiary.withValues(alpha: 0.1);
        textColor = colorScheme.tertiary;
        displayText = 'Completed';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SportBadge extends StatelessWidget {
  final String sportId;

  const _SportBadge({required this.sportId});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    IconData sportIcon;
    switch (sportId.toLowerCase()) {
      case 'badminton':
        sportIcon = Icons.sports_tennis;
        break;
      case 'tennis':
        sportIcon = Icons.sports_tennis;
        break;
      case 'cricket':
        sportIcon = Icons.sports_cricket;
        break;
      case 'football':
        sportIcon = Icons.sports_soccer;
        break;
      case 'basketball':
        sportIcon = Icons.sports_basketball;
        break;
      default:
        sportIcon = Icons.sports;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            sportId.toUpperCase(),
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Icon(sportIcon, color: colorScheme.primary, size: 14),
        ],
      ),
    );
  }
}

class _BookingDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _BookingDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 16, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
