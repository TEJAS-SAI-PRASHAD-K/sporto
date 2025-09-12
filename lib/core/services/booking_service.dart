import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:playo/core/models/venue_booking.dart';

class BookingService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Save a new venue booking to the database
  Future<bool> saveVenueBooking(VenueBooking booking) async {
    try {
      // Start a transaction by saving the main booking first
      await _saveMainBooking(booking);

      // Then save the associated courts
      await _saveBookingCourts(booking);

      return true;
    } catch (e) {
      print('Error saving venue booking: $e');
      return false;
    }
  }

  /// Save the main booking record to venue_bookings table
  Future<void> _saveMainBooking(VenueBooking booking) async {
    final bookingData = {
      'booking_id': booking.bookingId,
      'user_id': booking.userId,
      'venue_id': booking.venueId,
      'venue_name': booking.venueName,
      'venue_city': booking.venueCity,
      'sport_id': booking.sportId,
      'booking_date': booking.bookingDate.toIso8601String().split(
        'T',
      )[0], // Date only
      'booking_time': booking.bookingTime,
      'total_duration': booking.totalDuration,
      'booking_status': booking.bookingStatus.name,
      'subtotal': booking.subtotal,
      'convenience_fee': booking.convenienceFee,
      'coupon_discount': booking.couponDiscount,
      'karma_discount': booking.karmaDiscount,
      'total_amount': booking.totalAmount,
      'currency': booking.currency,
      'payment_split': booking.paymentSplit.name,
      'coupon_code': booking.couponCode,
      'is_karma_redeem_enabled': booking.isKarmaRedeemEnabled,
      'karma_points_used': booking.karmaPointsUsed,
      'special_requests': booking.specialRequests,
      'cancellation_hours': booking.cancellationHours,
      'created_at': booking.createdAt.toIso8601String(),
      'updated_at': booking.updatedAt.toIso8601String(),
    };

    await _supabase.from('venue_bookings').insert(bookingData);
  }

  /// Save the booking courts to booking_courts table
  Future<void> _saveBookingCourts(VenueBooking booking) async {
    final courtDataList = booking.selectedCourts
        .map(
          (court) => {
            'booking_id': booking.bookingId,
            'court_id': court.courtId,
            'court_name': court.courtName,
            'sport_id': court.sportId,
            'court_type': court.courtType,
            'court_surface': court.courtSurface,
            'hourly_rate': court.hourlyRate,
            'duration_minutes': court.durationMinutes,
            'total_price': court.totalPrice,
            'features': court.features.isNotEmpty ? court.features : null,
            'equipment': court.equipment.isNotEmpty ? court.equipment : null,
          },
        )
        .toList();

    if (courtDataList.isNotEmpty) {
      await _supabase.from('booking_courts').insert(courtDataList);
    }
  }

  /// Get user's bookings
  Future<List<VenueBooking>> getUserBookings(String userId) async {
    try {
      final response = await _supabase
          .from('venue_bookings')
          .select('''
            *,
            booking_courts(*)
          ''')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final bookingsData = response as List<dynamic>;

      return bookingsData.map((bookingJson) {
        // Convert booking_courts array to BookingCourt objects
        final courtsData = bookingJson['booking_courts'] as List<dynamic>;
        final courts = courtsData
            .map((courtJson) => BookingCourt.fromJson(courtJson))
            .toList();

        // Remove booking_courts from the main object and add selectedCourts
        final mainBookingData = Map<String, dynamic>.from(bookingJson);
        mainBookingData.remove('booking_courts');
        mainBookingData['selected_courts'] = courts
            .map((c) => c.toJson())
            .toList();

        return VenueBooking.fromJson(mainBookingData);
      }).toList();
    } catch (e) {
      print('Error fetching user bookings: $e');
      return [];
    }
  }

  /// Update booking status
  Future<bool> updateBookingStatus(
    String bookingId,
    BookingStatus newStatus,
  ) async {
    try {
      await _supabase
          .from('venue_bookings')
          .update({
            'booking_status': newStatus.name,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('booking_id', bookingId);

      return true;
    } catch (e) {
      print('Error updating booking status: $e');
      return false;
    }
  }

  /// Cancel a booking
  Future<bool> cancelBooking(String bookingId) async {
    return updateBookingStatus(bookingId, BookingStatus.cancelled);
  }

  /// Get current user ID from Supabase auth
  String? getCurrentUserId() {
    return _supabase.auth.currentUser?.id;
  }

  /// Check if user is authenticated
  bool isUserAuthenticated() {
    return _supabase.auth.currentUser != null;
  }
}
