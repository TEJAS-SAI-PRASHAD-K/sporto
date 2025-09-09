import 'package:flutter/material.dart';
import 'package:playo/core/models/game.dart';

class PaymentCheckPage extends StatefulWidget {
  final Game? gameData;

  const PaymentCheckPage({super.key, this.gameData});

  @override
  State<PaymentCheckPage> createState() => _PaymentCheckPageState();
}

class _PaymentCheckPageState extends State<PaymentCheckPage> {
  bool isKarmaRedeemEnabled = false;
  bool showCouponField = false;
  final TextEditingController couponController = TextEditingController();

  // Game data from booking page
  late Game gameData;

  @override
  void initState() {
    super.initState();
    // Ensure we have game data - this should always be provided
    if (widget.gameData == null) {
      throw Exception('PaymentCheckPage requires gameData to be provided');
    }
    gameData = widget.gameData!;
    isKarmaRedeemEnabled = gameData.isKarmaRedeemEnabled ?? false;
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
          gameData.venueName ?? 'Unknown Venue',
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
    // Get sport name from game's sportId, convert to uppercase
    final sportName = gameData.sportId.toUpperCase();

    // Choose appropriate icon based on sport
    IconData sportIcon;
    switch (gameData.sportId.toLowerCase()) {
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
            gameData.courtName ?? 'Court',
            colorScheme,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.calendar_today,
            gameData.formattedDate,
            colorScheme,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.access_time,
            gameData.formattedTimeSlot,
            colorScheme,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.monetization_on_outlined,
            "USD ${gameData.courtPrice.toStringAsFixed(2)}",
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
          "USD ${gameData.courtPrice.toStringAsFixed(2)}",
          colorScheme,
        ),
        const SizedBox(height: 12),
        _buildPriceRow(
          "Convenience Fee",
          "USD ${(gameData.convenienceFee ?? 0.0).toStringAsFixed(2)}",
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
                "USD ${gameData.totalAmount.toStringAsFixed(2)}",
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
                      "USD ${gameData.advancePayable.toStringAsFixed(2)}",
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
                      "USD ${gameData.toBePayedAtVenue.toStringAsFixed(2)}",
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
          onPressed: () {
            // Handle payment processing
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Proceeding to payment..."),
                backgroundColor: colorScheme.primary,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "USD ${gameData.totalAmount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "Proceed to Pay",
                style: const TextStyle(
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
}
