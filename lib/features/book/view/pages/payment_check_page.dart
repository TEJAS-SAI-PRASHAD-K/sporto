import 'package:flutter/material.dart';
import 'package:playo/core/models/venue_booking.dart';
import 'package:playo/core/services/booking_service.dart';

class PaymentCheckPage extends StatefulWidget {
  final VenueBooking? venueBookingData;

  const PaymentCheckPage({super.key, this.venueBookingData});

  @override
  State<PaymentCheckPage> createState() => _PaymentCheckPageState();
}

class _PaymentCheckPageState extends State<PaymentCheckPage> {
  bool isKarmaRedeemEnabled = false;
  bool showCouponField = false;
  final TextEditingController couponController = TextEditingController();
  final BookingService _bookingService = BookingService();
  bool _isProcessingPayment = false;

  // Venue booking data from booking page
  late VenueBooking venueBookingData;

  @override
  void initState() {
    super.initState();
    // Ensure we have venue booking data - this should always be provided
    if (widget.venueBookingData == null) {
      throw Exception(
        'PaymentCheckPage requires venueBookingData to be provided',
      );
    }
    venueBookingData = widget.venueBookingData!;
    isKarmaRedeemEnabled = venueBookingData.isKarmaRedeemEnabled;
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          venueBookingData.venueName,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSportBadge(colorScheme),
                  const SizedBox(height: 16),
                  _buildBookingDetails(colorScheme),
                  const SizedBox(height: 24),
                  _buildPriceBreakdown(colorScheme),
                  const SizedBox(height: 24),
                  _buildPaymentBreakdown(colorScheme),
                  const SizedBox(height: 32),
                  _buildTermsOfService(colorScheme),
                ],
              ),
            ),
          ),
          _buildProceedToPayButton(colorScheme),
        ],
      ),
    );
  }

  Widget _buildSportBadge(ColorScheme colorScheme) {
    // Get sport name from venue booking's sportId, convert to uppercase
    final sportName = venueBookingData.sportId.toUpperCase();

    // Choose appropriate icon based on sport
    IconData sportIcon;
    switch (venueBookingData.sportId.toLowerCase()) {
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
      case 'volleyball':
        sportIcon = Icons.sports_volleyball;
        break;
      case 'swimming':
        sportIcon = Icons.pool;
        break;
      case 'golf':
        sportIcon = Icons.sports_golf;
        break;
      default:
        sportIcon = Icons.sports;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            sportName,
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 4),
          Icon(sportIcon, color: colorScheme.primary, size: 16),
        ],
      ),
    );
  }

  Widget _buildBookingDetails(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            Icons.sports_tennis,
            venueBookingData.courtNames,
            colorScheme,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.calendar_today,
            venueBookingData.formattedDate,
            colorScheme,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.access_time,
            venueBookingData.formattedTimeSlot,
            colorScheme,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.monetization_on_outlined,
            "USD ${venueBookingData.subtotal.toStringAsFixed(2)}",
            colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String text,
    ColorScheme colorScheme, {
    bool hasCheckIcon = false,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (hasCheckIcon)
          Icon(Icons.check_circle, size: 20, color: colorScheme.primary),
      ],
    );
  }

  Widget _buildPriceBreakdown(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPriceRow(
          "Court Price",
          "USD ${venueBookingData.subtotal.toStringAsFixed(2)}",
          colorScheme,
        ),
        const SizedBox(height: 12),
        _buildPriceRow(
          "Convenience Fee",
          "USD ${venueBookingData.convenienceFee.toStringAsFixed(2)}",
          colorScheme,
          hasInfoIcon: true,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Redeem Karma",
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            Switch(
              value: isKarmaRedeemEnabled,
              onChanged: (value) {
                setState(() {
                  isKarmaRedeemEnabled = value;
                });
              },
              activeColor: colorScheme.primary,
            ),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            setState(() {
              showCouponField = !showCouponField;
            });
          },
          child: Row(
            children: [
              Text(
                "Apply Coupon",
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                showCouponField
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        if (showCouponField) ...[
          const SizedBox(height: 12),
          TextField(
            controller: couponController,
            decoration: InputDecoration(
              hintText: "Enter coupon code",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: TextButton(
                onPressed: () {
                  // Apply coupon logic
                },
                child: Text("Apply"),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPriceRow(
    String label,
    String amount,
    ColorScheme colorScheme, {
    bool hasInfoIcon = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (hasInfoIcon) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
        Text(
          amount,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentBreakdown(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "USD ${venueBookingData.totalAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Advance Payable",
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "USD ${venueBookingData.advancePayable.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "To be paid at Venue",
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "USD ${venueBookingData.toBePayedAtVenue.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTermsOfService(ColorScheme colorScheme) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "By continuing, you agree to our ",
          style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14),
          children: [
            TextSpan(
              text: "terms of service",
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProceedToPayButton(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: _isProcessingPayment ? null : _handleProceedToPay,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: _isProcessingPayment
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: colorScheme.onPrimary,
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Processing...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "USD ${venueBookingData.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Proceed to Pay",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
        ),
      ),
    );
  }

  /// Handle the proceed to pay button press
  Future<void> _handleProceedToPay() async {
    setState(() {
      _isProcessingPayment = true;
    });

    try {
      // Check if user is authenticated
      if (!_bookingService.isUserAuthenticated()) {
        _showErrorMessage("Please log in to continue with booking");
        return;
      }

      // Update booking with current karma and coupon settings
      final updatedBooking = _createUpdatedBooking();

      // Save booking to database
      final success = await _bookingService.saveVenueBooking(updatedBooking);

      if (success) {
        _showSuccessMessage();
        // Navigate back to previous screens or to booking confirmation
        Navigator.of(context).pop(); // Go back to booking page
        Navigator.of(context).pop(); // Go back to venue page
      } else {
        _showErrorMessage("Failed to save booking. Please try again.");
      }
    } catch (e) {
      _showErrorMessage("An error occurred: ${e.toString()}");
    } finally {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
      }
    }
  }

  /// Create an updated booking with current UI state
  VenueBooking _createUpdatedBooking() {
    // Calculate updated totals based on karma and coupon
    double karmaDiscount = 0.0;
    double couponDiscount = 0.0;

    if (isKarmaRedeemEnabled) {
      // Example: karma gives $1 discount per point (adjust as needed)
      karmaDiscount = 1.0; // You can implement karma calculation logic here
    }

    if (couponController.text.isNotEmpty) {
      // Example: apply coupon discount (implement your coupon logic)
      couponDiscount =
          2.0; // You can implement coupon validation and discount logic
    }

    final updatedTotalAmount =
        (venueBookingData.subtotal +
                venueBookingData.convenienceFee -
                karmaDiscount -
                couponDiscount)
            .clamp(0.0, double.infinity);

    // Create a new booking object with updated values
    return VenueBooking(
      venueId: venueBookingData.venueId,
      venueName: venueBookingData.venueName,
      venueCity: venueBookingData.venueCity,
      cancellationHours: venueBookingData.cancellationHours,
      selectedCourts: venueBookingData.selectedCourts,
      bookingId: venueBookingData.bookingId,
      userId: _bookingService.getCurrentUserId() ?? venueBookingData.userId,
      sportId: venueBookingData.sportId,
      bookingDate: venueBookingData.bookingDate,
      bookingTime: venueBookingData.bookingTime,
      totalDuration: venueBookingData.totalDuration,
      bookingStatus: BookingStatus.pending,
      subtotal: venueBookingData.subtotal,
      convenienceFee: venueBookingData.convenienceFee,
      couponDiscount: couponDiscount,
      karmaDiscount: karmaDiscount,
      totalAmount: updatedTotalAmount,
      currency: venueBookingData.currency,
      paymentSplit: venueBookingData.paymentSplit,
      couponCode: couponController.text.isNotEmpty
          ? couponController.text
          : null,
      isKarmaRedeemEnabled: isKarmaRedeemEnabled,
      karmaPointsUsed: isKarmaRedeemEnabled ? 1.0 : 0.0, // Adjust as needed
      specialRequests: null, // You can add a field for this if needed
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Show success message when booking is saved
  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Booking Confirmed!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Your booking has been successfully saved.",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Show error message
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
