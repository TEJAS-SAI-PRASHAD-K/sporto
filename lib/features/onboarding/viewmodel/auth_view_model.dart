import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:playo/features/onboarding/repository/auth_remote_repository.dart';
import 'package:playo/core/providers/current_user_provider.dart';
import 'package:playo/core/models/user.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<void>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> signUpWithOtp({required String mobileNumber}) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.signUpWithPhoneOtp(
      mobileNumber: mobileNumber,
    );

    if (res case Left(value: final failure)) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final _)) {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> verifyPhoneOtp({
    required String mobileNumber,
    required String token,
  }) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.verifyWithPhoneOtp(
      mobileNumber: mobileNumber,
      token: token,
    );

    if (res case Left(value: final failure)) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final authResponse)) {
      // Auth successful, create/update user profile
      await _handleSuccessfulAuth(authResponse, mobileNumber);
      state = const AsyncValue.data(null);
    }
  }

  Future<void> signUpWithEmailOtp({required String email}) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.signUpWithEmailOtp(email: email);

    if (res case Left(value: final failure)) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final _)) {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> verifyEmailOtp({
    required String email,
    required String token,
  }) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.verifyWithEmailOtp(
      email: email,
      token: token,
    );

    if (res case Left(value: final failure)) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final authResponse)) {
      // Auth successful, create/update user profile
      await _handleSuccessfulAuth(authResponse, email);
      state = const AsyncValue.data(null);
    }
  }

  Future<void> _handleSuccessfulAuth(
    AuthResponse authResponse,
    String emailOrPhone,
  ) async {
    try {
      final user = authResponse.user;
      if (user != null) {
        // Determine if it's email or phone
        final isEmail = emailOrPhone.contains('@');

        await _currentUserNotifier.createOrUpdateUser(
          email: isEmail ? emailOrPhone : (user.email ?? ''),
          fullName:
              user.userMetadata?['full_name'] ??
              user.userMetadata?['name'] ??
              'User', // Default name
          phone: !isEmail ? emailOrPhone : user.phone,
          authProvider: isEmail
              ? AuthProvider.email
              : AuthProvider.email, // Update when you add phone provider
          role: UserRole.player,
          subscriptionStatus: SubscriptionStatus.free,
        );
      }
    } catch (e) {
      // Log error but don't fail the authentication
      print('Error creating user profile: $e');
    }
  }

  Future<void> updateUserNames({
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _currentUserNotifier.updateUserProfile(
        firstName: firstName,
        lastName: lastName,
        fullName: '$firstName $lastName',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserAvatar({required String profilePictureUrl}) async {
    try {
      await _currentUserNotifier.updateUserProfile(
        profilePictureUrl: profilePictureUrl,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserSports({required List<String> preferredSports}) async {
    try {
      await _currentUserNotifier.updateUserProfile(
        preferredSports: preferredSports,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> completeProfile({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String gender,
    required List<String> preferredSports,
    String? bio,
    String? city,
    String? state,
    String? country,
  }) async {
    try {
      await _currentUserNotifier.updateUserProfile(
        firstName: firstName,
        lastName: lastName,
        fullName: '$firstName $lastName',
        bio: bio,
        dateOfBirth: dateOfBirth,
        gender: gender,
        city: city,
        userState: state,
        country: country,
        preferredSports: preferredSports,
      );
    } catch (e) {
      // Handle error appropriately
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _currentUserNotifier.logout();
    } catch (e) {
      // Handle error appropriately
      rethrow;
    }
  }
}
